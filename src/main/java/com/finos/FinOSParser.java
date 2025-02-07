package com.finos;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Stream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class FinOSParser {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    Path subdirectory;
    String subdirectoryName;
    String version;

    Path ddlOutputFile;
    Path constraintsOutputFile;
    Path insertsOutputFile;
    Path primaryKeysOutputFile;

    private static final Logger log = LogManager.getLogger(FinOSParser.class);
    public static void main(String[] args) {
        FinOSParser parser = new FinOSParser();

        log.info("Starting FinOSParser with data/ folder...");
        parser.processDirectories(Paths.get("data"));
        // parser.processFirstDirectory(Paths.get("data"));
    }

    /******************************************************
     *              PROCESSING DATA
     ******************************************************/

    private void processDirectories(Path dataFolder) {
        log.info("Searching for subdirectories in: " + dataFolder);

        try (Stream<Path> paths = Files.walk(dataFolder, 1)) {
            List<Path> subdirectories = paths
                .filter(Files::isDirectory)
                .filter(path -> !path.equals(dataFolder))
                .toList();

            if (subdirectories.isEmpty()) {
                log.warn("No subdirectories found in " + dataFolder);
                return;
            }

            for (Path subdir : subdirectories) {
                subdirectory = subdir;
                subdirectoryName = subdirectory.getFileName().toString();
                log.info("Found subdirectory: " + subdirectoryName);

                version = subdirectoryName.replace("cdm-json-schema-", "");

                Path outputDir = Paths.get("output", subdirectoryName);
                if (!Files.exists(outputDir)) {
                    Files.createDirectories(outputDir);
                    log.info("Created output directory: " + outputDir);
                }

                ddlOutputFile = outputDir.resolve(version + "_ddl.sql");
                constraintsOutputFile = outputDir.resolve(version + "_constraints.sql");
                insertsOutputFile = outputDir.resolve(version + "_inserts.sql");
                primaryKeysOutputFile = outputDir.resolve(version + "_primary_keys.sql");

                log.info("DDL will be written to: " + ddlOutputFile);
                log.info("Constraints will be written to: " + constraintsOutputFile);

                processJsonFilesInDirectory();
            }

        } catch (IOException e) {
            log.error("Unable to process directories: " + e.getMessage());
        }
    }

    private void processFirstDirectory(Path dataFolder) {
        log.info("Searching for subdirectories in: " + dataFolder);

        try (Stream<Path> paths = Files.walk(dataFolder, 1)) {
            Optional<Path> firstDir = paths
                .filter(Files::isDirectory)
                .filter(path -> !path.equals(dataFolder))
                .findFirst();

            if (firstDir.isEmpty()) {
                log.warn("No subdirectories found in " + dataFolder);
                return;
            }

            subdirectory = firstDir.get();
            subdirectoryName = subdirectory.getFileName().toString();
            log.info("Found subdirectory: " + subdirectoryName);

            version = subdirectoryName.replace("cdm-json-schema-", "");

            Path outputDir = Paths.get("output", subdirectoryName);
            if (!Files.exists(outputDir)) {
                Files.createDirectories(outputDir);
                log.info("Created output directory: " + outputDir);
            }

            ddlOutputFile = outputDir.resolve(version + "_ddl.sql");
            constraintsOutputFile = outputDir.resolve(version + "_constraints.sql");
            insertsOutputFile = outputDir.resolve(version + "_inserts.sql");
            primaryKeysOutputFile = outputDir.resolve(version + "_primary_keys.sql");

            log.info("DDL will be written to: " + ddlOutputFile);
            log.info("Constraints will be written to: " + constraintsOutputFile);

            processJsonFilesInDirectory();

        } catch (IOException e) {
            log.error("Unable to find the first directory: " + e.getMessage());
        }
    }

    private void processJsonFilesInDirectory() {
        log.info("Processing .json files in: " + subdirectory);

        try (Stream<Path> dirStream = Files.walk(subdirectory)) {
            dirStream.filter(Files::isRegularFile)
                     .filter(path -> path.toString().toLowerCase().endsWith(".json"))
                     .forEach(jsonFile -> generateDDLFromJson(jsonFile));
        } catch (IOException e) {
            log.error("Unable to process JSON files in " + subdirectory + ": " + e.getMessage());
        }
    }


    private void generateDDLFromJson(Path jsonFile) {
        log.info("Reading JSON file: " + jsonFile);

        try {
            JsonNode root = objectMapper.readTree(jsonFile.toFile());

            if (!root.has("title")) {
                log.warn("No 'title' found in JSON: " + jsonFile + "; skipping.");
                return;
            }

            String schemaName = root.has("$anchor") ? root.get("$anchor").asText().replace(".", "_") : "default_schema";
            String tableName = root.get("title").asText();
            String fullTableName = schemaName + "." + tableName;
            log.info("Creating table for: " + fullTableName);

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
                    ddlStatements.append(buildCreateTableStatementForEnum(schemaName, tableName, fullTableName, root));
                } else {
                    log.warn("No 'properties' object in " + jsonFile + "; skipping.");
                    return;
                }
            } else {
                ddlStatements.append(buildCreateTableStatement(fullTableName, propertiesNode, requiredFields, schemaName));
            }

            try (FileWriter writer = new FileWriter(ddlOutputFile.toFile(), true)) {
                writer.write(ddlStatements.toString());
            }
            log.info("Wrote DDL for table: " + fullTableName);

        } catch (IOException e) {
            log.error("Unable to read JSON file " + jsonFile + ": " + e.getMessage());
        }
    }


    private String getRefTableName(String rawRef, String subdirectoryName) {
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
            log.error("Unable to read referenced file for title: " + foundFile + ": " + e.getMessage());
        }

        return rawRef;
    }

    /******************************************************
     *               BUILDING CREATE TABLE STATEMENTS
     ******************************************************/

     private String buildCreateTableStatement(String fullTableName, JsonNode propertiesNode, Set<String> requiredFields, String schemaName) {
        String tableName = fullTableName.substring(fullTableName.lastIndexOf('.') + 1);

        StringBuilder ddlBuilder = new StringBuilder("CREATE TABLE ");
        ddlBuilder.append(fullTableName).append(" (\n");

        List<String> columns = new ArrayList<>();

        columns.add("    " + tableName + "_id INT UNIQUE NOT NULL");

        Iterator<String> fieldNames = propertiesNode.fieldNames();

        while (fieldNames.hasNext()) {
            String key = fieldNames.next();
            JsonNode fieldNode = propertiesNode.get(key);

            String columnType = determineColumnType(fieldNode);
            boolean isRequired = requiredFields.contains(key);

            if (columnType == "array") {
                handleArrayType(tableName, key, fieldNode, schemaName);

                columnType = "INT";
                isRequired = true;
            }

            columns.add(buildColumnDefinition(key, columnType, fieldNode, isRequired));

            if (fieldNode.has("$ref")) {
                String rawRef = fieldNode.get("$ref").asText();
                String refTable = getRefTableName(rawRef, subdirectoryName);

                String alterTableStatement = buildForeignKeyConstraint(schemaName, tableName, key, refTable);
                writeConstraintToFile(alterTableStatement);
            }
        }

        buildPrimaryKeyConstraint(schemaName, tableName, tableName + "_id");

        ddlBuilder.append(String.join(",\n", columns));
        ddlBuilder.append("\n);\n\n");
        return ddlBuilder.toString();
    }

    private String buildCreateTableStatementForEnum(String schemaName, String tableName, String fullTableName, JsonNode root) {
        StringBuilder ddl = new StringBuilder();

        String columnType = "VARCHAR(255)";
        if (root.has("type") && root.get("type").isTextual()) {
            columnType = determineColumnType(root);
        }

        ddl.append("CREATE TABLE ").append(fullTableName).append(" (\n");
        ddl.append("    ").append(tableName + "_id").append(" ").append(columnType).append(" UNIQUE NOT NULL,\n");
        ddl.append("    Description VARCHAR(max)\n");
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

    private void handleArrayType(String parentTable, String columnName, JsonNode arrayNode, String schemaName) {
        if (!arrayNode.has("items")) {
            log.warn("Array without 'items' found in " + parentTable + "." + columnName + "; skipping.");
            return;
        }

        JsonNode itemsNode = arrayNode.get("items");

        String arrayTableName = parentTable + "_" + columnName;
        String parentColumnName = parentTable + "_id";
        StringBuilder ddlBuilder = new StringBuilder("CREATE TABLE ");
        ddlBuilder.append(schemaName).append(".").append(arrayTableName).append(" (\n");
        ddlBuilder.append("    ").append(parentColumnName).append(" INT NOT NULL,\n");

        String valueColumnName;

        if (itemsNode.has("$ref")) {
            // The array contains references to another table
            String refTable = getRefTableName(itemsNode.get("$ref").asText(), subdirectoryName);
            String refColumnName = refTable.substring(refTable.lastIndexOf(".") + 1) + "_id";
            valueColumnName = refColumnName;
            ddlBuilder.append("    ").append(refColumnName).append(" INT UNIQUE NOT NULL\n);\n\n");

            // Write ALTER TABLE foreign key constraint to the constraints file
            String alterTableStatement = buildForeignKeyConstraint(schemaName, arrayTableName, refColumnName, refTable);
            writeConstraintToFile(alterTableStatement);
        } else {
            // The array contains primitive types
            String columnType = determineColumnType(itemsNode);
            valueColumnName = "value";
            ddlBuilder.append("    value ").append(columnType).append(" UNIQUE NOT NULL\n);\n\n");
        }

        // Write the new table DDL to the output file
        try (FileWriter writer = new FileWriter(ddlOutputFile.toFile(), true)) {
            writer.write(ddlBuilder.toString());
        } catch (IOException e) {
            log.error("Unable to write array DDL: " + e.getMessage());
        }

        // Write foreign key constraint for parent table reference
        String parentConstraint = "ALTER TABLE " + schemaName + "." + arrayTableName
                                    + " ADD CONSTRAINT fpk_" + arrayTableName + "_" + parentColumnName
                                    + " FOREIGN KEY (" + parentColumnName + ") REFERENCES "
                                    + schemaName + "." + parentTable + " (" + parentColumnName + ");";
        writeConstraintToFile(parentConstraint);

        buildPrimaryKeyConstraint(schemaName, arrayTableName, parentColumnName + "," + valueColumnName);
    }

    /******************************************************
     *               BUILDING COLUMN DEFINITIONS
     ******************************************************/


    private String buildColumnDefinition(String columnName, String columnType, JsonNode fieldNode, boolean isRequired) {
        StringBuilder def = new StringBuilder("    ").append(escapeReservedWord(columnName)).append(" ").append(columnType);

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
     *               PRIMARY KEYS ALTER TABLE
     ******************************************************/

     private void buildPrimaryKeyConstraint(String schemaName, String tableName, String primaryKey) {
        String primaryKeyConstraint = "ALTER TABLE " + schemaName + "." + tableName
                                        + " ADD CONSTRAINT xpk_" + tableName
                                        + " PRIMARY KEY (" + primaryKey + ");\n";

        try (FileWriter writer = new FileWriter(primaryKeysOutputFile.toFile(), true)) {
            writer.write(primaryKeyConstraint);
        } catch (IOException e) {
            log.error("Unable to write primaryKeyConstraint: " + e.getMessage());
        }
     }

    /******************************************************
     *               FOREIGN KEYS ALTER TABLE
     ******************************************************/

    private String buildForeignKeyConstraint(String schemaName, String tableName, String columnName, String refTable) {
        return "ALTER TABLE " + schemaName + "." + tableName
               + " ADD CONSTRAINT fpk_" + columnName + "_id"
               + " FOREIGN KEY (" + escapeReservedWord(columnName) + ") REFERENCES " + refTable + " (" + refTable.substring(refTable.lastIndexOf(".") + 1) + "_id);";
    }

    private void writeConstraintToFile(String constraintStatement) {
        try (FileWriter writer = new FileWriter(constraintsOutputFile.toFile(), true)) {
            writer.write(constraintStatement + "\n");
        } catch (IOException e) {
            log.error("Unable to write constraint to file: " + constraintsOutputFile + " - " + e.getMessage());
        }
    }

    /******************************************************
     *               ENUMS INSERT INTO
     ******************************************************/

     private String populateEnumTableStatements(String schemaName, String tableName, List<String> enumValues, Map<String, String> enumDescriptions) {
        StringBuilder insertDDL = new StringBuilder();

        for (String value : enumValues) {
            String description = enumDescriptions.getOrDefault(value, null);
            insertDDL.append("INSERT INTO ").append(schemaName + "." + tableName)
               .append(" (" + tableName + "_id").append(", Description) VALUES (")
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

    private void writeInsertsToFile(Path insertsFile, String insertStatement) {
        try (FileWriter writer = new FileWriter(insertsFile.toFile(), true)) {
            writer.write(insertStatement + "\n");
        } catch (IOException e) {
            log.error("Unable to write insert statement to file: " + insertsFile + " - " + e.getMessage());
        }
    }

    /******************************************************
     *               HELPER METHODS
     ******************************************************/

     private String determineColumnType(JsonNode fieldNode) {
        if (!fieldNode.has("type")) {
            return "VARCHAR(255)";
        }

        String type = fieldNode.get("type").asText().toLowerCase();

        return switch (type) {
            case "string"  -> "VARCHAR(255)";
            case "integer" -> "INT";
            case "number"  -> "FLOAT";
            case "boolean" -> "INT";
            case "object"  -> "JSON";
            case "array"   -> "array";
            default        -> "INT";
        };
    }

    private Path findSchemaFile(String rawRef, String subdirectoryName) {
        Path candidate = Paths.get("data", subdirectoryName, rawRef);
        if (Files.exists(candidate)) {
            return candidate;
        }
        return null;
    }

    private String escapeReservedWord(String word) {
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
            "IDENTITY", "IMMEDIATE", "IN", "INDEX", "INDICATOR", "INITIALLY",
            "INNER", "INPUT", "INSENSITIVE", "INSERT", "INT", "INTEGER", "INTERSECT",
            "INTERVAL", "INTO", "IS", "ISOLATION", "JOIN", "LANGUAGE", "LAST",
            "LEADING", "LEFT", "LEVEL", "LIKE", "LOCAL", "LOWER", "MATCH", "MAX", "MIN",
            "MINUTE", "MODULE", "NAMES", "NATIONAL", "NATURAL", "NCHAR",
            "NEXT", "NO", "NOT", "NULL", "NULLIF", "NUMERIC", "OCTET_LENGTH", "OF", "ON",
            "ONLY", "OPEN", "OPTION", "OR", "OUTER", "OUTPUT", "OVERLAPS",
            "PAD", "PARTIAL", "PREPARE", "PRESERVE", "PRIMARY", "PRIOR", "PRIVILEGES",
            "PROCEDURE", "PUBLIC", "READ", "REAL", "REFERENCES", "RELATIVE",
            "RESTRICT", "REVOKE", "RIGHT", "ROLE", "ROLLBACK", "ROWS",
            "SCHEMA", "SCROLL", "SECOND", "SECURITY", "SECTION", "SELECT", "SESSION_USER",
            "SET", "SHARD", "SMALLINT", "SOME", "SPACE", "SQLERROR", "SQLSTATE",
            "STATISTICS", "SUBSTRING", "SUM", "SYSDATE", "SYSTEM_USER", "TABLE",
            "TEMPORARY", "THEN", "TIME", "TIMEZONE_HOUR", "TIMEZONE_MINUTE",
            "TO", "TOP", "TRAILING", "TRANSACTION", "TRIM", "TRUE", "UNION", "UNIQUE",
            "UPDATE", "UPPER", "USER", "USING", "VALUES", "VARCHAR", "VARYING", "WHEN",
            "WHENEVER", "WHERE", "WITH", "WORK", "WRITE"
        );

        return reservedWords.stream().map(String::toLowerCase).anyMatch(word.toLowerCase()::equals)
                ? "\"" + word + "\""
                : word;
    }
}