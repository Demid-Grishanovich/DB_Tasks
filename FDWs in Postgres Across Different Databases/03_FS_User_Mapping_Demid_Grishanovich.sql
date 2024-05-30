CREATE SERVER foreign_db_two
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (dbname 'database_two');


CREATE USER MAPPING FOR CURRENT_USER
SERVER foreign_db_two
OPTIONS (user 'current_user', password '');