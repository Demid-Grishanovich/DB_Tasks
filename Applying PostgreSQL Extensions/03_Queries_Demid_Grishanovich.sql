-- Retrieve all records from the employees table
SELECT * FROM employees;

-- Update the last name of the employee with the email 'olivia.martinez@example.com' to 'Johnson'
UPDATE employees SET last_name = 'Johnson' WHERE email = 'olivia.martinez@example.com';

-- Delete the employee record with the email 'emma.stone@example.com'
DELETE FROM employees WHERE email = 'emma.stone@example.com';

-- Select all records from the pg_stat_statements view to analyze the execution statistics of SQL statements
SELECT * FROM pg_stat_statements;




-- Query to retrieve performance statistics of executed statements from pg_stat_statements
SELECT * FROM pg_stat_statements;

-- Identify the most frequently executed queries and analyze their performance
SELECT query, calls, total_time, rows
FROM pg_stat_statements
ORDER BY calls DESC;

-- Determine queries with the highest average runtime
SELECT query, total_time / calls AS avg_time, calls
FROM pg_stat_statements
ORDER BY avg_time DESC;
