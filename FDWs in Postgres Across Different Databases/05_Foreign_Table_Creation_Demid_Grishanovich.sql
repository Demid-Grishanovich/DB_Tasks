CREATE FOREIGN TABLE local_external_table (
    id INTEGER,
    full_name VARCHAR(255),
    years INTEGER
)
SERVER foreign_db_two
OPTIONS (schema_name 'public', table_name 'external_table');