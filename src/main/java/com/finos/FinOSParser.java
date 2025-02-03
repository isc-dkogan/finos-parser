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

            // Extract version from folder name
            String version = subdirectoryName.replace("cdm-json-schema-", "");

            Path outputDir = Paths.get("output", subdirectoryName);
            if (!Files.exists(outputDir)) {
                Files.createDirectories(outputDir);
                System.out.println("[INFO] Created output directory: " + outputDir);
            }

            Path ddlOutputFile = outputDir.resolve(version + "_ddl.sql");
            Path constraintsOutputFile = outputDir.resolve(version + "_constraints.sql");
            Path insertsOutputFile = outputDir.resolve(version + "_inserts.sql");
            Path primaryKeysOutputFile = outputDir.resolve(version + "_primary_keys.sql");

            System.out.println("[INFO] DDL will be written to: " + ddlOutputFile);
            System.out.println("[INFO] Constraints will be written to: " + constraintsOutputFile);

            processJsonFilesInDirectory(subdirectory, subdirectoryName, ddlOutputFile, constraintsOutputFile, insertsOutputFile);

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to find the first directory: " + e.getMessage());
        }
    }


    private static void processJsonFilesInDirectory(Path directory, String subdirectoryName, Path ddlOutputFile, Path constraintsOutputFile, Path insertsOutputFile) {
        System.out.println("[INFO] Processing .json files in: " + directory);

        try (Stream<Path> dirStream = Files.walk(directory)) {
            dirStream.filter(Files::isRegularFile)
                     .filter(path -> path.toString().toLowerCase().endsWith(".json"))
                     .forEach(jsonFile -> generateDDLFromJson(jsonFile, subdirectoryName, ddlOutputFile, constraintsOutputFile, insertsOutputFile));
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to process JSON files in " + directory + ": " + e.getMessage());
        }
    }


    private static void generateDDLFromJson(Path jsonFile, String subdirectoryName, Path ddlOutputFile, Path constraintsOutputFile, Path insertsOutputFile) {
        System.out.println("[INFO] Reading JSON file: " + jsonFile);

        try {
            JsonNode root = objectMapper.readTree(jsonFile.toFile());

            if (!root.has("title")) {
                System.err.println("[WARN] No 'title' found in JSON: " + jsonFile + "; skipping.");
                return;
            }

            // Extract schemaName from $anchor (ensuring it's properly formatted)
            String schemaName = root.has("$anchor") ? root.get("$anchor").asText().replace(".", "_") : "default_schema";
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
                    ddlStatements.append(buildCreateTableStatementForEnum(schemaName, tableName, fullTableName, root, insertsOutputFile));
                } else {
                    System.err.println("[WARN] No 'properties' object in " + jsonFile + "; skipping.");
                    return;
                }
            } else {
                ddlStatements.append(buildCreateTableStatement(fullTableName, propertiesNode, requiredFields, subdirectoryName, constraintsOutputFile, schemaName));
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

            String schemaName = root.has("$anchor") ? root.get("$anchor").asText().replace(".", "_") : "default_schema";
            String tableName = root.get("title").asText();
            return schemaName + "." + tableName;

        } catch (IOException e) {
            System.err.println("[ERROR] Unable to read referenced file for title: " + foundFile + ": " + e.getMessage());
        }

        return rawRef; // Fallback if "title" is not present
    }

    /******************************************************
     *               BUILDING CREATE TABLE STATEMENTS
     ******************************************************/

     private static String buildCreateTableStatement(String tableName, JsonNode propertiesNode, Set<String> requiredFields, String subdirectoryName, Path constraintsOutputFile, String schemaName) {
        StringBuilder ddlBuilder = new StringBuilder("CREATE TABLE @");
        ddlBuilder.append(tableName).append(" (\n");

        List<String> columns = new ArrayList<>();

        columns.add("    " + tableName + "_id NOT NULL");

        Iterator<String> fieldNames = propertiesNode.fieldNames();

        while (fieldNames.hasNext()) {
            String key = fieldNames.next();
            JsonNode fieldNode = propertiesNode.get(key);

            String columnName = escapeReservedWord(key);

            if (fieldNode.has("$ref")) {
                String rawRef = fieldNode.get("$ref").asText();

                String refTable = getRefTableName(rawRef, subdirectoryName);
                boolean isRequired = requiredFields.contains(key);

                columns.add(buildColumnDefinitionForRef(columnName, fieldNode, isRequired));

                String alterTableStatement = buildForeignKeyConstraint(schemaName, tableName, columnName, refTable);
                writeConstraintToFile(constraintsOutputFile, alterTableStatement);
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

    private static String buildCreateTableStatementForEnum(String schemaName, String tableName, String fullTableName, JsonNode root, Path insertsOutputFile) {
        StringBuilder ddl = new StringBuilder();

        String columnType = "VARCHAR(255)";
        if (root.has("type") && root.get("type").isTextual()) {
            columnType = determineColumnType(root);
        }

        ddl.append("CREATE TABLE @").append(fullTableName).append(" (\n");
        ddl.append("    " + tableName + "_id NOT NULL,\n");
        ddl.append("    ").append(tableName).append(" ").append(columnType).append(" UNIQUE NOT NULL,\n");
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

        String insertStatements = populateEnumTableStatements(schemaName, tableName, enumValues, enumDescriptions);
        writeInsertsToFile(insertsOutputFile, insertStatements);

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

    private static String buildColumnDefinitionForRef(String columnName, JsonNode fieldNode, boolean isRequired) {
        StringBuilder def = new StringBuilder();
        def.append("    ").append(columnName).append(" INT");

        if (isRequired) {
            def.append(" NOT NULL");
        }

        if (fieldNode.has("description")) {
            String desc = fieldNode.get("description").asText().replace("'", "''");
            def.append(" %DESCRIPTION '").append(desc).append("'");
        }

        return def.toString();
    }

    /******************************************************
     *               FOREIGN KEYS ALTER TABLE
     ******************************************************/

    private static String buildForeignKeyConstraint(String schemaName, String tableName, String columnName, String refTable) {
        return "ALTER TABLE @" + schemaName + "." + tableName
               + " ADD CONSTRAINT fpk_" + columnName + "_id"
               + " FOREIGN KEY (" + columnName + ") REFERENCES @" + refTable + " (" + refTable.substring(refTable.lastIndexOf(".") + 1) + "_id);";
    }

    private static void writeConstraintToFile(Path constraintsFile, String constraintStatement) {
        try (FileWriter writer = new FileWriter(constraintsFile.toFile(), true)) {
            writer.write(constraintStatement + "\n");
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to write constraint to file: " + constraintsFile + " - " + e.getMessage());
        }
    }

    /******************************************************
     *               ENUMS INSERT INTO
     ******************************************************/

     private static String populateEnumTableStatements(String schemaName, String tableName, List<String> enumValues, Map<String, String> enumDescriptions) {
        StringBuilder insertDDL = new StringBuilder();

        for (String value : enumValues) {
            String description = enumDescriptions.getOrDefault(value, null);
            insertDDL.append("INSERT INTO @").append(schemaName + "." + tableName)
               .append(" (" + tableName).append(", Description) VALUES (")
               .append("'").append(value.replace("'", "''")).append("', ");
            if (description != null) {
                insertDDL.append("'").append(description).append("'");
            } else {
                insertDDL.append("NULL");
            }
            insertDDL.append(");\n");
        }

        return insertDDL.toString();

    }

    private static void writeInsertsToFile(Path insertsFile, String insertStatement) {
        try (FileWriter writer = new FileWriter(insertsFile.toFile(), true)) {
            writer.write(insertStatement + "\n");
        } catch (IOException e) {
            System.err.println("[ERROR] Unable to write insert statement to file: " + insertsFile + " - " + e.getMessage());
        }
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