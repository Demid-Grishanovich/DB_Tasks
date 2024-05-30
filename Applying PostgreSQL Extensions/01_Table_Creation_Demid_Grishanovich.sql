-- Install the pg_stat_statements extension to track SQL statement execution statistics
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Install the pgcrypto extension to use cryptographic functions for password encryption
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Create the employees table with encrypted password storage
-- id: A unique serial identifier for each employee (Primary Key)
-- first_name: The employee's first name
-- last_name: The employee's last name
-- email: The employee's email address
-- encrypted_password: The employee's password, encrypted and stored as text
CREATE TABLE employees (
                           id SERIAL PRIMARY KEY,       -- Auto-incrementing primary key
                           first_name VARCHAR(255),     -- First name of the employee
                           last_name VARCHAR(255),      -- Last name of the employee
                           email VARCHAR(255),          -- Email address of the employee
                           encrypted_password TEXT      -- Encrypted password of the employee
);
