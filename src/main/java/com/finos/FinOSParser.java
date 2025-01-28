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
        // No command-line arguments. We always look in "data/".
        System.out.println("[INFO] Starting FinOSParser with data/ folder...");
        processFirstDirectory(Paths.get("data"));
    }

    /**
     * Finds the first subdirectory under "data" and generates DDL for all JSON files there,
     * outputting to "output/<subdirectoryName>.sql".
     */
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

            // Process the subdirectory
            processJsonFilesInDirectory(subdirectory, subdirectoryName, ddlOutputFile);

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to find the first directory: " + e.getMessage());
        }
    }

    /**
     * Processes all .json files in the given directory, generating IRIS DDL and writing it
     * to ddlOutputFile.
     */
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

    /**
     * Reads a JSON file, extracts 'properties', and builds a CREATE TABLE statement for IRIS.
     */
    private static void generateDDLFromJson(Path jsonFile, String subdirectoryName, Path ddlOutputFile) {
        System.out.println("[INFO] Reading JSON file: " + jsonFile);

        try {
            JsonNode root = objectMapper.readTree(jsonFile.toFile());
            JsonNode propertiesNode = root.get("properties");
            if (propertiesNode == null || !propertiesNode.isObject()) {
                System.err.println("[WARN] No 'properties' object in " + jsonFile + "; skipping.");
                return;
            }

            // Derive table name from the file name
            String tableName = deriveTableName(jsonFile);
            System.out.println("[INFO] Creating table for: " + tableName);

            String ddlStatement = buildCreateTableStatement(tableName, propertiesNode, subdirectoryName);

            // Write the resulting DDL
            try (FileWriter writer = new FileWriter(ddlOutputFile.toFile(), true)) {
                writer.write(ddlStatement);
            }
            System.out.println("[INFO] Wrote DDL for table: " + tableName);

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to read JSON file " + jsonFile + ": " + e.getMessage());
        }
    }

    /**
     * Build a CREATE TABLE statement from the properties node.
     */
    private static String buildCreateTableStatement(String tableName, JsonNode propertiesNode, String subdirectoryName) {
        StringBuilder ddlBuilder = new StringBuilder("CREATE TABLE ");
        ddlBuilder.append(tableName).append(" (\n");

        List<String> columns = new ArrayList<>();
        Iterator<String> fieldNames = propertiesNode.fieldNames();

        while (fieldNames.hasNext()) {
            String key = fieldNames.next();
            JsonNode fieldNode = propertiesNode.get(key);

            // Possibly escape reserved words
            String columnName = escapeReservedWord(key);

            // If we see a top-level $ref, check if it's an enum or a foreign table reference
            if (fieldNode.has("$ref")) {
                String rawRef = fieldNode.get("$ref").asText();
                if (isEnumReference(rawRef, subdirectoryName)) {
                    columns.add(buildColumnDefinitionForEnum(columnName, rawRef, subdirectoryName, fieldNode));
                } else {
                    String refTable = deriveRefTableName(rawRef);
                    columns.add(buildColumnDefinitionForRef(columnName, refTable, fieldNode));
                }
            }
            else {
                // Otherwise, a normal typed field
                String columnType = determineColumnType(fieldNode);
                columns.add(buildColumnDefinition(columnName, columnType, fieldNode));
            }
        }

        ddlBuilder.append(String.join(",\n", columns));
        ddlBuilder.append("\n);\n\n");
        return ddlBuilder.toString();
    }

    // ------------------------------------------------------------------------
    //  Column definitions for foreign refs, enums, normal fields
    // ------------------------------------------------------------------------

    private static String buildColumnDefinitionForRef(String columnName, String refTable, JsonNode fieldNode) {
        StringBuilder def = new StringBuilder("    ")
            .append(columnName)
            .append(" INT REFERENCES ")
            .append(refTable)
            .append("(id)");

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    private static String buildColumnDefinition(String columnName, String columnType, JsonNode fieldNode) {
        StringBuilder def = new StringBuilder("    ")
            .append(columnName)
            .append(" ")
            .append(columnType);

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    /**
     * Creates a VARCHAR(255) with a CONSTRAINT CHECK for enum references.
     */
    private static String buildColumnDefinitionForEnum(String columnName, String rawRef, String subdirectoryName, JsonNode fieldNode) {
        StringBuilder def = new StringBuilder("    ");
        def.append(columnName).append(" VARCHAR(255)");

        // Build the constraint name
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

    // ------------------------------------------------------------------------
    //  Handling arrays
    // ------------------------------------------------------------------------

    private static String determineColumnType(JsonNode fieldNode) {
        if (!fieldNode.has("type")) {
            return "VARCHAR";
        }
        String type = fieldNode.get("type").asText().toLowerCase();

        return switch (type) {
            case "string"  -> "VARCHAR(255)";
            case "integer" -> "INT";
            case "number"  -> "FLOAT";
            case "boolean" -> "BOOLEAN";
            case "object"  -> "JSON";
            case "array"   -> deriveListType(fieldNode);
            default        -> "VARCHAR";
        };
    }

    private static String deriveListType(JsonNode arrayNode) {
        if (arrayNode.has("items")) {
            JsonNode itemsNode = arrayNode.get("items");
            if (itemsNode.has("$ref")) {
                String fullRef = itemsNode.get("$ref").asText();
                return "LIST(INT) /* references " + deriveRefTableName(fullRef) + " */";
            } else if (itemsNode.has("type")) {
                String itemType = itemsNode.get("type").asText().toLowerCase();
                return switch (itemType) {
                    case "integer" -> "LIST(INT)";
                    case "number"  -> "LIST(FLOAT)";
                    case "boolean" -> "LIST(BOOLEAN)";
                    case "string"  -> "LIST(VARCHAR(255))";
                    case "object"  -> "LIST(JSON)";
                    default        -> "LIST(VARCHAR)";
                };
            }
        }
        return "LIST(VARCHAR)";
    }

    // ------------------------------------------------------------------------
    //  Distinguish enum from non-enum references
    // ------------------------------------------------------------------------

    private static boolean isEnumReference(String rawRef, String subdirectoryName) {
        // We won't print about the enum creation here, as requested
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

    private static String deriveRefTableName(String rawRef) {
        // "cdm-base-math-ArithmeticOperationEnum.schema.json" -> "ArithmeticOperationEnum"
        Path p = Paths.get(rawRef).getFileName();
        if (p == null) return rawRef;

        String refFileName = p.toString();
        if (refFileName.endsWith(".json")) {
            refFileName = refFileName.substring(0, refFileName.length() - 5);
        }
        if (refFileName.endsWith(".schema")) {
            refFileName = refFileName.substring(0, refFileName.length() - 7);
        }
        int dashIndex = refFileName.lastIndexOf('-');
        if (dashIndex != -1 && dashIndex < refFileName.length() - 1) {
            return refFileName.substring(dashIndex + 1);
        }
        return refFileName;
    }

    // ------------------------------------------------------------------------
    //  Load enum values from the subdirectory
    // ------------------------------------------------------------------------

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

    /**
     * Expects the file to be at data/<subdirectoryName>/<rawRef>.
     */
    private static Path findSchemaFile(String rawRef, String subdirectoryName) {
        Path candidate = Paths.get("data", subdirectoryName, rawRef);
        if (Files.exists(candidate)) {
            return candidate;
        }
        return null;
    }

    // ------------------------------------------------------------------------
    //  Utility for quoting strings
    // ------------------------------------------------------------------------

    private static List<String> wrapInQuotes(List<String> items) {
        List<String> quoted = new ArrayList<>();
        for (String item : items) {
            String safe = item.replace("'", "''");
            quoted.add("'" + safe + "'");
        }
        return quoted;
    }

    // ------------------------------------------------------------------------
    //  Reserved Words
    // ------------------------------------------------------------------------

    /**
     * We quote the word if it's in our reserved words set, which now includes:
     * "value", "after", and "block" as requested.
     */
    private static String escapeReservedWord(String word) {
        Set<String> reservedWords = Set.of(
            "address", "version", "user", "group", "index",
            "table", "column", "order", "select", "desc",
            "value", "after", "block"
        );
        return reservedWords.contains(word.toLowerCase()) ? "\"" + word + "\"" : word;
    }

    // ------------------------------------------------------------------------
    //  Derive table name from a JSON file path
    // ------------------------------------------------------------------------

    private static String deriveTableName(Path jsonFile) {
        // e.g. cdm-base-math-ArithmeticOperationEnum.schema.json -> ArithmeticOperationEnum
        String fileName = jsonFile.getFileName().toString();
        if (fileName.endsWith(".json")) {
            fileName = fileName.substring(0, fileName.length() - 5);
        }
        if (fileName.endsWith(".schema")) {
            fileName = fileName.substring(0, fileName.length() - 7);
        }
        int dashIndex = fileName.lastIndexOf('-');
        if (dashIndex != -1 && dashIndex < fileName.length() - 1) {
            return fileName.substring(dashIndex + 1);
        }
        return fileName;
    }
}
