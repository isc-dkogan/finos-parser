package com.finos;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Stream;

public class FinOSParser {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static void main(String[] args) {
        System.out.println("[INFO] Starting FinOSParser with data/ folder...");
        processFirstDirectory(Paths.get("data"));
    }

    private static void processFirstDirectory(Path dataFolder) {
        System.out.println("[INFO] Searching for subdirectories in: " + dataFolder);

        try (Stream<Path> paths = Files.walk(dataFolder, 1)) {
            Optional<Path> firstDir = paths
                .filter(Files::isDirectory)
                .filter(path -> !path.equals(dataFolder))
                .findFirst();

            if (firstDir.isEmpty()) {
                System.out.println("[WARN] No subdirectories found in " + dataFolder);
                return;
            }

            Path subdirectory = firstDir.get();
            String subdirectoryName = subdirectory.getFileName().toString();
            System.out.println("[INFO] Found subdirectory: " + subdirectoryName);

            // Create output/ folder if needed
            Path outputDir = Paths.get("output");
            if (!Files.exists(outputDir)) {
                Files.createDirectory(outputDir);
                System.out.println("[INFO] Created output/ folder");
            }

            // Our output file is named after the subdirectory
            Path ddlOutputFile = outputDir.resolve(subdirectoryName + ".sql");
            System.out.println("[INFO] DDL will be written to: " + ddlOutputFile);

            processJsonFilesInDirectory(subdirectory, subdirectoryName, ddlOutputFile);

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to find the first directory: " + e.getMessage());
        }
    }

    private static void processJsonFilesInDirectory(Path directory, String subdirectoryName, Path ddlOutputFile) {
        System.out.println("[INFO] Processing .json files in: " + directory);

        try (Stream<Path> dirStream = Files.walk(directory)) {
            dirStream.filter(Files::isRegularFile)
                     .filter(path -> path.toString().toLowerCase().endsWith(".json"))
                     .forEach(jsonFile -> generateDDLFromJson(jsonFile, subdirectoryName, ddlOutputFile));
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to process JSON files in " + directory + ": " + e.getMessage());
        }
    }

    private static void generateDDLFromJson(Path jsonFile, String subdirectoryName, Path ddlOutputFile) {
        System.out.println("[INFO] Reading JSON file: " + jsonFile);

        try {
            JsonNode root = objectMapper.readTree(jsonFile.toFile());
            JsonNode propertiesNode = root.get("properties");

            if (propertiesNode == null || !propertiesNode.isObject()) {
                System.err.println("[WARN] No 'properties' object in " + jsonFile + "; skipping.");
                return;
            }

            if (!root.has("title")) {
                System.err.println("[WARN] No 'title' found in JSON: " + jsonFile + "; skipping.");
                return;
            }
            String tableName = root.get("title").asText();
            System.out.println("[INFO] Creating table for: " + tableName);

            Set<String> requiredFields = new HashSet<>();
            JsonNode requiredNode = root.get("required");
            if (requiredNode != null && requiredNode.isArray()) {
                for (JsonNode fieldName : requiredNode) {
                    requiredFields.add(fieldName.asText());
                }
            }

            String ddlStatement = buildCreateTableStatement(tableName, propertiesNode, requiredFields, subdirectoryName);

            try (FileWriter writer = new FileWriter(ddlOutputFile.toFile(), true)) {
                writer.write(ddlStatement);
            }
            System.out.println("[INFO] Wrote DDL for table: " + tableName);

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to read JSON file " + jsonFile + ": " + e.getMessage());
        }
    }

    private static String buildCreateTableStatement(
            String tableName,
            JsonNode propertiesNode,
            Set<String> requiredFields,
            String subdirectoryName) {

        StringBuilder ddlBuilder = new StringBuilder("CREATE TABLE ");
        ddlBuilder.append(tableName).append(" (\n");

        List<String> columns = new ArrayList<>();
        Iterator<String> fieldNames = propertiesNode.fieldNames();

        while (fieldNames.hasNext()) {
            String key = fieldNames.next();
            JsonNode fieldNode = propertiesNode.get(key);

            String columnName = escapeReservedWord(key);

            if (fieldNode.has("$ref")) {
                String rawRef = fieldNode.get("$ref").asText();
                if (isEnumReference(rawRef, subdirectoryName)) {
                    columns.add(buildColumnDefinitionForEnum(columnName, rawRef, subdirectoryName, fieldNode));
                } else {
                    String refTable = getRefTableName(rawRef, subdirectoryName);
                    boolean isRequired = requiredFields.contains(key);
                    columns.add(buildColumnDefinitionForRef(columnName, refTable, fieldNode, isRequired));
                }
            } else {
                String columnType = determineColumnType(fieldNode);
                boolean isRequired = requiredFields.contains(key);
                columns.add(buildColumnDefinition(columnName, columnType, fieldNode, isRequired));
            }
        }

        ddlBuilder.append(String.join(",\n", columns));
        ddlBuilder.append("\n);\n\n");
        return ddlBuilder.toString();
    }

    private static String getRefTableName(String rawRef, String subdirectoryName) {
        // Find the file path for the referenced schema
        Path foundFile = findSchemaFile(rawRef, subdirectoryName);
        if (foundFile == null) {
            return rawRef; // Use the raw reference as a fallback
        }

        try {
            JsonNode root = objectMapper.readTree(foundFile.toFile());
            // Use the "title" property if it exists
            if (root.has("title")) {
                return root.get("title").asText();
            }
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to read referenced file for title: " + foundFile + ": " + e.getMessage());
        }

        return rawRef; // Fallback if "title" is not present
    }

    private static String determineColumnType(JsonNode fieldNode) {
        // If the "type" property is missing, default to VARCHAR
        if (!fieldNode.has("type")) {
            return "VARCHAR(255)";
        }

        String type = fieldNode.get("type").asText().toLowerCase();

        return switch (type) {
            case "string"  -> "VARCHAR(255)";
            case "integer" -> "INT";
            case "number"  -> "FLOAT";
            case "boolean" -> "BOOLEAN";
            case "object"  -> "JSON";
            case "array"   -> deriveListType(fieldNode); // Handle arrays separately
            default        -> "VARCHAR(255)"; // Default to VARCHAR for unknown types
        };
    }

    private static String deriveListType(JsonNode arrayNode) {
        // Check if the "items" property exists in the array definition
        if (arrayNode.has("items")) {
            JsonNode itemsNode = arrayNode.get("items");

            // If the items have a $ref, assume it references another table
            if (itemsNode.has("$ref")) {
                String refTable = getRefTableName(itemsNode.get("$ref").asText(), ""); // Provide subdirectory if needed
                return "LIST(INT) /* references " + refTable + " */";
            }
            // If the items have a "type" property, infer the list's type
            else if (itemsNode.has("type")) {
                String itemType = itemsNode.get("type").asText().toLowerCase();
                return switch (itemType) {
                    case "integer" -> "LIST(INT)";
                    case "number"  -> "LIST(FLOAT)";
                    case "boolean" -> "LIST(BOOLEAN)";
                    case "string"  -> "LIST(VARCHAR(255))";
                    case "object"  -> "LIST(JSON)";
                    default        -> "LIST(VARCHAR(255))"; // Default for unknown types
                };
            }
        }

        // If "items" is missing or undefined, assume a generic list of VARCHAR
        return "LIST(VARCHAR(255))";
    }

    private static String buildColumnDefinitionForEnum(
            String columnName,
            String rawRef,
            String subdirectoryName,
            JsonNode fieldNode) {

        StringBuilder def = new StringBuilder("    ");
        def.append(columnName).append(" VARCHAR(255)");

        String unquotedName = columnName.replace("\"", "");
        String constraintName = "CHK_" + unquotedName;

        List<String> enumValues = loadEnumValues(rawRef, subdirectoryName);
        if (!enumValues.isEmpty()) {
            def.append(" CONSTRAINT ").append(constraintName)
               .append(" CHECK (").append(columnName).append(" IN (");

            String joined = String.join(",", wrapInQuotes(enumValues));
            def.append(joined).append("))");
        }

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    private static String buildColumnDefinition(String columnName, String columnType, JsonNode fieldNode, boolean isRequired) {
        StringBuilder def = new StringBuilder("    ").append(columnName).append(" ").append(columnType);

        if (isRequired) {
            def.append(" NOT NULL");
        }

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    private static String buildColumnDefinitionForRef(String columnName, String refTable, JsonNode fieldNode, boolean isRequired) {
        StringBuilder def = new StringBuilder();

        // Define the column itself
        def.append("    ").append(columnName).append(" INT");
        if (isRequired) {
            def.append(" NOT NULL");
        }
        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" DESCRIPTION '").append(desc).append("'");
        }
        def.append(",\n");

        // Add the foreign key constraint separately
        def.append("    FOREIGN KEY (").append(columnName).append(") REFERENCES ")
           .append(refTable).append("(ID)");

        return def.toString();
    }

    private static boolean isEnumReference(String rawRef, String subdirectoryName) {
        Path foundFile = findSchemaFile(rawRef, subdirectoryName);
        if (foundFile == null) {
            return false;
        }
        try {
            JsonNode root = objectMapper.readTree(foundFile.toFile());
            if (root.has("type")
                && "string".equalsIgnoreCase(root.get("type").asText())
                && root.has("enum")
                && root.get("enum").isArray()) {
                return true;
            }
        } catch (IOException e) {
            System.err.println("[ERROR] Reading possible enum file " + foundFile + ": " + e.getMessage());
        }
        return false;
    }

    private static List<String> loadEnumValues(String rawRef, String subdirectoryName) {
        List<String> results = new ArrayList<>();
        Path foundFile = findSchemaFile(rawRef, subdirectoryName);
        if (foundFile == null) {
            return results;
        }
        try {
            JsonNode root = objectMapper.readTree(foundFile.toFile());
            if (root.has("enum") && root.get("enum").isArray()) {
                for (JsonNode val : root.get("enum")) {
                    if (val.isTextual()) {
                        results.add(val.asText());
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("[ERROR] Loading enum from " + foundFile + ": " + e.getMessage());
        }
        return results;
    }

    private static Path findSchemaFile(String rawRef, String subdirectoryName) {
        Path candidate = Paths.get("data", subdirectoryName, rawRef);
        if (Files.exists(candidate)) {
            return candidate;
        }
        return null;
    }

    private static String escapeReservedWord(String word) {
        Set<String> reservedWords = Set.of(
            "address", "version", "user", "group", "index",
            "table", "column", "order", "select", "desc",
            "value", "after", "block"
        );
        return reservedWords.contains(word.toLowerCase()) ? "\"" + word + "\"" : word;
    }

    private static List<String> wrapInQuotes(List<String> items) {
        List<String> quoted = new ArrayList<>();
        for (String item : items) {
            String safe = item.replace("'", "''");
            quoted.add("'" + safe + "'");
        }
        return quoted;
    }
}