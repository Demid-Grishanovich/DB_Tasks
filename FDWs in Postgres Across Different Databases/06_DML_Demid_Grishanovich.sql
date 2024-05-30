SELECT * FROM local_external_table;

INSERT INTO local_external_table (id, full_name, years) VALUES (11, 'George Hall', 34);

UPDATE local_external_table SET years = 50 WHERE full_name = 'Anna Johnson';

DELETE FROM local_external_table WHERE full_name = 'Kevin Clark';