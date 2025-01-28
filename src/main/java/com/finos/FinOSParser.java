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

    // Example usage in main:
    // mvn exec:java -Dexec.mainClass="com.finos.FinOSParser" -Dexec.args="data output.sql"
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java -jar finos-parser.jar <folder_path> <ddl_output_file>");
            System.exit(1);
        }

        String folderPath = args[0];
        String ddlOutputFile = args[1];
        generateDDLForAllJson(Paths.get(folderPath), ddlOutputFile);
    }

    /**
     * Walk through all directories in the given folder, find .json files,
     * and generate DDL statements in a single output file.
     */
    private static void generateDDLForAllJson(Path folderPath, String ddlOutputFile) {
        try (Stream<Path> paths = Files.walk(folderPath)) {
            paths.filter(Files::isDirectory)
                 .forEach(dir -> processJsonFilesInDirectory(dir, ddlOutputFile));
        } catch (IOException e) {
            System.err.println("Error walking through the directory: " + e.getMessage());
        }
    }

    /**
     * For each .json file in the specified directory, generate IRIS DDL and append it to the output file.
     */
    private static void processJsonFilesInDirectory(Path directory, String ddlOutputFile) {
        try (Stream<Path> dirStream = Files.walk(directory)) {
            dirStream.filter(Files::isRegularFile)
                     .filter(path -> path.toString().toLowerCase().endsWith(".json"))
                     .forEach(jsonFile -> generateDDLFromJson(jsonFile, ddlOutputFile));
        } catch (IOException e) {
            System.err.println("Error processing JSON files in " + directory + ": " + e.getMessage());
        }
    }

    /**
     * Generate IRIS DDL from a single JSON file and append it to the specified output file.
     */
    private static void generateDDLFromJson(Path jsonFile, String ddlOutputFile) {
        try {
            JsonNode root = objectMapper.readTree(jsonFile.toFile());
            JsonNode propertiesNode = root.get("properties");
            if (propertiesNode == null || !propertiesNode.isObject()) {
                System.err.println("No 'properties' object found in JSON: " + jsonFile);
                return;
            }

            String tableName = deriveTableName(jsonFile);
            String ddlStatement = buildCreateTableStatement(tableName, propertiesNode);

            System.out.println("Appending DDL for file: " + jsonFile);
            try (FileWriter writer = new FileWriter(ddlOutputFile, true)) {
                writer.write(ddlStatement);
            }

        } catch (IOException e) {
            System.err.println("Error processing JSON file " + jsonFile + ": " + e.getMessage());
        }
    }

    /**
     * Derive the table name by:
     * 1. Removing any trailing ".json" (and optional ".schema")
     * 2. Extracting the substring after the last dash, if present
     */
    private static String deriveTableName(Path jsonFile) {
        String fileName = jsonFile.getFileName().toString();

        // Remove .json if present
        if (fileName.endsWith(".json")) {
            fileName = fileName.substring(0, fileName.length() - 5); // remove ".json"
        }
        // Optionally remove .schema if present
        if (fileName.endsWith(".schema")) {
            fileName = fileName.substring(0, fileName.length() - 7); // remove ".schema"
        }

        // Extract substring after the last dash
        int lastDashIndex = fileName.lastIndexOf('-');
        if (lastDashIndex != -1 && lastDashIndex < fileName.length() - 1) {
            return fileName.substring(lastDashIndex + 1);
        }

        // Fallback: return the entire fileName if no dash found
        return fileName;
    }

    /**
     * Build a "CREATE TABLE" DDL statement given the table name and the "properties" node.
     */
    private static String buildCreateTableStatement(String tableName, JsonNode propertiesNode) {
        StringBuilder ddlBuilder = new StringBuilder();

        ddlBuilder.append("CREATE TABLE ").append(tableName).append(" (\n");

        // Collect column definitions
        List<String> columnDefs = new ArrayList<>();
        Iterator<String> fieldNames = propertiesNode.fieldNames();

        while (fieldNames.hasNext()) {
            String key = fieldNames.next();
            JsonNode fieldNode = propertiesNode.get(key);

            // Check for reserved words
            String columnName = escapeReservedWord(key);

            // Determine column type
            String columnType = determineColumnType(fieldNode);

            // Handle optional description
            String columnDef = buildColumnDefinition(columnName, columnType, fieldNode);
            columnDefs.add(columnDef);
        }

        // Join columns with commas
        ddlBuilder.append(String.join(",\n", columnDefs)).append("\n);\n\n");
        return ddlBuilder.toString();
    }

    /**
     * Build a single column definition, optionally adding DESCRIPTION.
     */
    private static String buildColumnDefinition(String columnName, String columnType, JsonNode fieldNode) {
        // For references, we might do something else, but let's keep it simple for now
        StringBuilder def = new StringBuilder("    ").append(columnName).append(" ").append(columnType);

        if (fieldNode.has("description")) {
            // Escape single quotes to avoid SQL errors
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    /**
     * Determine the IRIS column type based on the JSON field node (type, items, etc.).
     */
    private static String determineColumnType(JsonNode fieldNode) {
        if (!fieldNode.has("type")) {
            return "VARCHAR"; // Default if no "type" key
        }

        String type = fieldNode.get("type").asText();
        switch (type.toLowerCase()) {
            case "string":
                return "VARCHAR(255)";
            case "integer":
                return "INT";
            case "number":
                return "FLOAT";
            case "boolean":
                return "BOOLEAN";
            case "object":
                return "JSON";
            case "array":
                // IRIS LIST type
                return deriveListType(fieldNode);
            default:
                return "VARCHAR"; // Default type
        }
    }

    /**
     * For array types, IRIS supports LIST(elementType).
     * e.g., array of string -> LIST(VARCHAR(255))
     */
    private static String deriveListType(JsonNode arrayNode) {
        if (arrayNode.has("items") && arrayNode.get("items").has("type")) {
            String itemType = arrayNode.get("items").get("type").asText().toLowerCase();
            switch (itemType) {
                case "integer":
                    return "LIST(INT)";
                case "number":
                    return "LIST(FLOAT)";
                case "boolean":
                    return "LIST(BOOLEAN)";
                case "string":
                    return "LIST(VARCHAR(255))";
                case "object":
                    return "LIST(JSON)";
                default:
                    return "LIST(VARCHAR)";
            }
        }
        // No "items" type specified
        return "LIST(VARCHAR)";
    }

    /**
     * Escape reserved or problematic words for IRIS by quoting them.
     */
    private static String escapeReservedWord(String word) {
        // Subset of IRIS reserved words
        Set<String> reservedWords = Set.of(
            "address", "version", "user", "group", "index",
            "table", "column", "order", "select", "desc"
            // Add more as needed
        );
        // Use double quotes if it's reserved
        if (reservedWords.contains(word.toLowerCase())) {
            return "\"" + word + "\"";
        }
        return word;
    }
}
