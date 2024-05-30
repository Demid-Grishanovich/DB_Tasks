CREATE EXTENSION postgres_fdw;

CREATE SERVER northwind_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (dbname 'northwind');

CREATE USER MAPPING FOR CURRENT_USER
SERVER northwind_server
OPTIONS (USER 'postgres', password 'password');

IMPORT FOREIGN SCHEMA public
FROM SERVER northwind_server
INTO staging;