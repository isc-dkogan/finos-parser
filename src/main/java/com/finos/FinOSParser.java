package com.finos;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.stream.Stream;

public class FinOSParser {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java -jar finos-parser.jar <folder_path> <ddl_output_file>");
            System.exit(1);
        }

        String folderPath = args[0];
        String ddlOutputFile = args[1];
        processDirectoryAndGenerateDDL(Paths.get(folderPath), ddlOutputFile);
    }

    // Method to process the first directory and all JSON files in it to generate a single DDL file
    private static void processDirectoryAndGenerateDDL(Path folderPath, String ddlOutputFile) {
        try (Stream<Path> paths = Files.walk(folderPath)) {
            // Process only the first directory found
            Path firstDirectory = paths.filter(Files::isDirectory)
                                        .findFirst()
                                        .orElseThrow(() -> new IOException("No directories found"));

            System.out.println("Processing first directory: " + firstDirectory);

            // Process all JSON files in this directory
            try (Stream<Path> dirStream = Files.walk(firstDirectory)) {
                dirStream.filter(Files::isRegularFile)
                         .filter(path -> path.toString().toLowerCase().endsWith(".json"))
                         .forEach(jsonFile -> generateDDLFromJson(jsonFile, ddlOutputFile));

            }

        } catch (IOException e) {
            System.err.println("Error processing directory or JSON file: " + e.getMessage());
        }
    }

    // Method to generate DDL SQL from a JSON file and append it to the DDL output file
    private static void generateDDLFromJson(Path jsonFile, String ddlOutputFile) {
        try {
            JsonNode jsonNode = objectMapper.readTree(jsonFile.toFile());
            JsonNode propertiesNode = jsonNode.get("properties");
            if (propertiesNode == null || !propertiesNode.isObject()) {
                System.err.println("No properties found in JSON: " + jsonFile);
                return;
            }

            StringBuilder ddlBuilder = new StringBuilder();

            // Create SQL DDL for a table based on JSON structure
            ddlBuilder.append("CREATE TABLE ").append(jsonFile.getFileName().toString().replace(".json", "")).append(" (\n");

            Iterator<String> fieldNames = propertiesNode.fieldNames();
            while (fieldNames.hasNext()) {
                String key = fieldNames.next();
                JsonNode field = propertiesNode.get(key);

                if (field.has("$ref")) {
                    // This property is a reference to another table
                    String refTableName = getTableNameFromRef(field.get("$ref").asText());
                    ddlBuilder.append("    ").append(key).append(" INT, -- Foreign key to ").append(refTableName).append("\n");
                    ddlBuilder.append("    FOREIGN KEY (").append(key).append(") REFERENCES ").append(refTableName).append("(id)\n");
                } else {
                    String columnDescription = field.has("description") ? field.get("description").asText() : "No description";
                    String columnType = field.has("type") ? inferColumnType(field.get("type").asText()) : "TEXT";

                    ddlBuilder.append("    ").append(key).append(" ").append(columnType)
                            .append(" -- ").append(columnDescription).append("\n");
                }

                if (fieldNames.hasNext()) {
                    ddlBuilder.append(",\n");
                }
            }

            ddlBuilder.append("\n);\n\n");

            // Append the generated DDL to the output file
            System.out.println("Appending DDL for file: " + jsonFile);
            try (FileWriter writer = new FileWriter(ddlOutputFile, true)) {
                writer.write(ddlBuilder.toString());
            }

        } catch (IOException e) {
            System.err.println("Error processing JSON file " + jsonFile + ": " + e.getMessage());
        }
    }

    // Method to infer the column type based on the JSON type string
    private static String inferColumnType(String jsonType) {
        switch (jsonType.toLowerCase()) {
            case "integer":
                return "INT";
            case "string":
                return "VARCHAR(255)";
            case "boolean":
                return "BOOLEAN";
            case "number":
                return "DECIMAL(10, 2)";
            default:
                return "TEXT";  // Default to TEXT for unknown types
        }
    }

    // Method to extract the table name from the $ref
    private static String getTableNameFromRef(String ref) {
        // The $ref is expected to be a file path, so we extract the filename without extension
        Path refPath = Paths.get(ref);
        return refPath.getFileName().toString().replace(".json", "");
    }
}
