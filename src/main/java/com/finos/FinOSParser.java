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

    /******************************************************
     *              PROCESSING DATA
     ******************************************************/

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

            Path outputDir = Paths.get("output");
            if (!Files.exists(outputDir)) {
                Files.createDirectory(outputDir);
                System.out.println("[INFO] Created output/ folder");
            }

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

            if (!root.has("title")) {
                System.err.println("[WARN] No 'title' found in JSON: " + jsonFile + "; skipping.");
                return;
            }

            String schemaName = root.get("$anchor").asText().replace(".", "_");
            String tableName = root.get("title").asText();
            String fullTableName = schemaName + "." + tableName;
            System.out.println("[INFO] Creating table for: " + fullTableName);

            Set<String> requiredFields = new HashSet<>();
            JsonNode requiredNode = root.get("required");
            if (requiredNode != null && requiredNode.isArray()) {
                for (JsonNode fieldName : requiredNode) {
                    requiredFields.add(fieldName.asText());
                }
            }

            StringBuilder ddlStatements = new StringBuilder();

            JsonNode propertiesNode = root.get("properties");
            if (propertiesNode == null || !propertiesNode.isObject()) {

                if (root.has("enum") && root.get("enum").isArray()) {
                    List<String> enumValues = new ArrayList<>();
                    for (JsonNode val : root.get("enum")) {
                        if (val.isTextual()) {
                            enumValues.add(val.asText());
                        }
                    }

                    ddlStatements.append(buildCreateTableStatementForEnum(fullTableName, root));
                } else {
                    System.err.println("[WARN] No 'properties' object in " + jsonFile + "; skipping.");
                    return;
                }
            } else {
                ddlStatements.append(buildCreateTableStatement(fullTableName, propertiesNode, requiredFields, subdirectoryName));
            }

            try (FileWriter writer = new FileWriter(ddlOutputFile.toFile(), true)) {
                writer.write(ddlStatements.toString());
            }
            System.out.println("[INFO] Wrote DDL for table: " + fullTableName);

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to read JSON file " + jsonFile + ": " + e.getMessage());
        }
    }

    private static String getRefTableName(String rawRef, String subdirectoryName) {
        Path foundFile = findSchemaFile(rawRef, subdirectoryName);
        if (foundFile == null) {
            return rawRef;
        }

        try {
            JsonNode root = objectMapper.readTree(foundFile.toFile());

            if (root.has("title")) {
                return root.get("title").asText();
            }
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to read referenced file for title: " + foundFile + ": " + e.getMessage());
        }

        return rawRef; // Fallback if "title" is not present
    }

    /******************************************************
     *               BUILDING CREATE TABLE STATEMENTS
     ******************************************************/

    private static String buildCreateTableStatement(String tableName, JsonNode propertiesNode, Set<String> requiredFields, String subdirectoryName) {
        StringBuilder ddlBuilder = new StringBuilder("CREATE TABLE ");
        ddlBuilder.append(tableName).append(" (\n");

        List<String> columns = new ArrayList<>();

        columns.add("    %PUBLICROWID");

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

    private static String buildCreateTableStatementForEnum(String fullTableName, JsonNode root) {
        StringBuilder ddl = new StringBuilder();
        String columnName = fullTableName.substring(fullTableName.lastIndexOf('.') + 1);

        String columnType = "VARCHAR(255)";
        if (root.has("type") && root.get("type").isTextual()) {
            columnType = determineColumnType(root);
        }

        ddl.append("CREATE TABLE ").append(fullTableName).append(" (\n");
        ddl.append("    ID INT PRIMARY KEY,\n");
        ddl.append("    ").append(columnName).append(" ").append(columnType).append(" UNIQUE NOT NULL,\n");
        ddl.append("    Description VARCHAR(255)\n");
        ddl.append(");\n\n");

        List<String> enumValues = new ArrayList<>();
        if (root.has("enum") && root.get("enum").isArray()) {
            for (JsonNode val : root.get("enum")) {
                if (val.isTextual()) {
                    enumValues.add(val.asText());
                }
            }
        }

        Map<String, String> enumDescriptions = new HashMap<>();
        if (root.has("oneOf") && root.get("oneOf").isArray()) {
            for (JsonNode oneOfNode : root.get("oneOf")) {
                if (oneOfNode.has("enum") && oneOfNode.get("enum").isArray() && oneOfNode.get("enum").size() > 0) {
                    String enumValue = oneOfNode.get("enum").get(0).asText();  // Get the enum value
                    String description = oneOfNode.has("description") ? oneOfNode.get("description").asText().replace("'", "''") : null;
                    enumDescriptions.put(enumValue, description);  // Store description mapped to enum value
                }
            }
        }

        int rowIndex = 1;
        for (String value : enumValues) {
            String description = enumDescriptions.getOrDefault(value, null);
            ddl.append("INSERT INTO ").append(fullTableName)
               .append(" (ID, ").append(columnName).append(", Description) VALUES (")
               .append(rowIndex).append(", '")
               .append(value.replace("'", "''")).append("', ");
            if (description != null) {
                ddl.append("'").append(description).append("'");
            } else {
                ddl.append("NULL");
            }
            ddl.append(");\n");

            rowIndex++;
        }

        ddl.append("\n");
        return ddl.toString();
    }

    /******************************************************
     *               BUILDING COLUMN DEFINITIONS
     ******************************************************/


    private static String buildColumnDefinition(String columnName, String columnType, JsonNode fieldNode, boolean isRequired) {
        StringBuilder def = new StringBuilder("    ").append(columnName).append(" ").append(columnType);

        if (isRequired) {
            def.append(" NOT NULL");
        }

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" %DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    private static String buildColumnDefinitionForRef(String columnName, String refTable, JsonNode fieldNode, boolean isRequired) {
        StringBuilder def = new StringBuilder();

        def.append("    ").append(columnName).append(" INT");
        if (isRequired) {
            def.append(" NOT NULL");
        }
        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" %DESCRIPTION '").append(desc).append("'");
        }
        def.append(",\n");

        def.append("    CONSTRAINT ").append(columnName).append("FK")
           .append(" FOREIGN KEY (").append(columnName).append(") REFERENCES ")
           .append(refTable).append("(ID)");

        return def.toString();
    }

    private static String buildColumnDefinitionForEnum(String columnName, String rawRef, String subdirectoryName, JsonNode fieldNode) {
        String enumTable = getRefTableName(rawRef, subdirectoryName); // Resolve the correct enum table name

        StringBuilder def = new StringBuilder("    ");
        def.append(columnName).append(" VARCHAR(255)");

        // Foreign key to the enum table
        def.append(",\n    CONSTRAINT ").append(columnName).append("FK")
        .append(" FOREIGN KEY (").append(columnName).append(") REFERENCES ")
        .append(enumTable).append("(ID)");

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" %DESCRIPTION '").append(desc).append("'");
        }
        return def.toString();
    }

    /******************************************************
     *               HELPER METHODS
     ******************************************************/

     private static String determineColumnType(JsonNode fieldNode) {
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
            case "array"   -> "VARCHAR(-1)";
            default        -> "VARCHAR(255)";
        };
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
            System.err.println("[ERROR] Reading file " + foundFile + ": " + e.getMessage());
        }
        return false;
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
            "ABSOLUTE", "ADD", "ALL", "ALLOCATE", "ALTER", "AND", "ANY", "ARE", "AS",
            "ASC", "ASSERTION", "AT", "AUTHORIZATION", "AVG", "BEGIN", "BETWEEN",
            "BIT", "BIT_LENGTH", "BOTH", "BY", "CASCADE", "CASE", "CAST",
            "CHAR", "CHARACTER", "CHARACTER_LENGTH", "CHAR_LENGTH",
            "CHECK", "CLOSE", "COALESCE", "COLLATE", "COMMIT", "CONNECT",
            "CONNECTION", "CONSTRAINT", "CONSTRAINTS", "CONTINUE", "CONVERT",
            "CORRESPONDING", "COUNT", "CREATE", "CROSS", "CURRENT",
            "CURRENT_DATE", "CURRENT_TIME", "CURRENT_TIMESTAMP",
            "CURRENT_USER", "CURSOR", "DATE", "DEALLOCATE", "DEC", "DECIMAL",
            "DECLARE", "DEFAULT", "DEFERRABLE", "DEFERRED", "DELETE", "DESC",
            "DESCRIBE", "DESCRIPTOR", "DIAGNOSTICS", "DISCONNECT", "DISTINCT",
            "DOMAIN", "DOUBLE", "DROP", "ELSE", "END", "ENDEXEC", "ESCAPE", "EXCEPT",
            "EXCEPTION", "EXEC", "EXECUTE", "EXISTS", "EXTERNAL", "EXTRACT",
            "FALSE", "FETCH", "FIRST", "FLOAT", "FOR", "FOREIGN", "FOUND", "FROM", "FULL",
            "GET", "GLOBAL", "GO", "GOTO", "GRANT", "GROUP", "HAVING", "HOUR",
            "IDENTITY", "IMMEDIATE", "IN", "INDICATOR", "INITIALLY",
            "INNER", "INPUT", "INSENSITIVE", "INSERT", "INT", "INTEGER", "INTERSECT",
            "INTERVAL", "INTO", "IS", "ISOLATION", "JOIN", "LANGUAGE", "LAST",
            "LEADING", "LEFT", "LEVEL", "LIKE", "LOCAL", "LOWER", "MATCH", "MAX", "MIN",
            "MINUTE", "MODULE", "NAMES", "NATIONAL", "NATURAL", "NCHAR",
            "NEXT", "NO", "NOT", "NULL", "NULLIF", "NUMERIC", "OCTET_LENGTH", "OF", "ON",
            "ONLY", "OPEN", "OPTION", "OR", "OUTER", "OUTPUT", "OVERLAPS",
            "PAD", "PARTIAL", "PREPARE", "PRESERVE", "PRIMARY", "PRIOR", "PRIVILEGES",
            "PROCEDURE", "PUBLIC", "READ", "REAL", "REFERENCES", "RELATIVE",
            "RESTRICT", "REVOKE", "RIGHT", "ROLE", "ROLLBACK", "ROWS",
            "SCHEMA", "SCROLL", "SECOND", "SECTION", "SELECT", "SESSION_USER",
            "SET", "SHARD", "SMALLINT", "SOME", "SPACE", "SQLERROR", "SQLSTATE",
            "STATISTICS", "SUBSTRING", "SUM", "SYSDATE", "SYSTEM_USER", "TABLE",
            "TEMPORARY", "THEN", "TIME", "TIMEZONE_HOUR", "TIMEZONE_MINUTE",
            "TO", "TOP", "TRAILING", "TRANSACTION", "TRIM", "TRUE", "UNION", "UNIQUE",
            "UPDATE", "UPPER", "USER", "USING", "VALUES", "VARCHAR", "VARYING", "WHEN",
            "WHENEVER", "WHERE", "WITH", "WORK", "WRITE"
        );

        return reservedWords.contains(word.toLowerCase()) ? "\"" + word + "\"" : word;
    }
}