-- Adding StartDate, EndDate, and RecordID columns to DimEmployee table if they do not exist
ALTER TABLE DimEmployee ADD COLUMN IF NOT EXISTS HireStart DATE;
ALTER TABLE DimEmployee ADD COLUMN IF NOT EXISTS HireEnd DATE;
ALTER TABLE DimEmployee ADD COLUMN IF NOT EXISTS EmployeeRecordID SERIAL;

-- Dropping existing primary key constraint
ALTER TABLE DimEmployee
DROP CONSTRAINT IF EXISTS dimemployee_pkey CASCADE;

-- Adding new primary key constraint to EmployeeID and EmployeeRecordID columns
ALTER TABLE DimEmployee
    ADD CONSTRAINT dimemployee_primary_key PRIMARY KEY (EmployeeID, EmployeeRecordID);

CREATE OR REPLACE FUNCTION sync_dimemployees()
RETURNS TRIGGER AS
$$
BEGIN
    -- Logic to handle INSERT, UPDATE, and DELETE operations
    IF TG_OP = 'INSERT' THEN
        -- Logic for INSERT operation
        INSERT INTO DimEmployee (
            EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address,
            City, Region, PostalCode, Country, HomePhone, Extension, HireStart, HireEnd
        ) VALUES (
            NEW.employee_id, NEW.last_name, NEW.first_name, NEW.title, NEW.birth_date, NEW.hire_date,
            NEW.address, NEW.city, NEW.region, NEW.postal_code, NEW.country,
            NEW.home_phone, NEW.extension, CURRENT_DATE, NULL
        );
    ELSIF TG_OP = 'UPDATE' THEN
        -- Logic for UPDATE operation
UPDATE DimEmployee
SET HireEnd = CURRENT_DATE
WHERE EmployeeID = OLD.employee_id AND HireEnd IS NULL;

INSERT INTO DimEmployee (
    EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address,
    City, Region, PostalCode, Country, HomePhone, Extension, HireStart, HireEnd
) VALUES (
             OLD.employee_id, NEW.last_name, NEW.first_name, NEW.title, NEW.birth_date, NEW.hire_date,
             NEW.address, NEW.city, NEW.region, NEW.postal_code, NEW.country,
             NEW.home_phone, NEW.extension, CURRENT_DATE, NULL
         );
ELSIF TG_OP = 'DELETE' THEN
        -- Logic for DELETE operation
UPDATE DimEmployee
SET HireEnd = CURRENT_DATE
WHERE EmployeeID = OLD.employee_id AND HireEnd IS NULL;
END IF;

RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- Creating trigger to handle INSERT, UPDATE, and DELETE on staging_employees
CREATE OR REPLACE TRIGGER trigger_manage_scd
AFTER INSERT OR UPDATE OR DELETE ON staging_employees
    FOR EACH ROW
    EXECUTE FUNCTION sync_dimemployees();


-- Select all records from staging_employees and DimEmployee for verification
SELECT * FROM staging_employees;
SELECT * FROM DimEmployee;

-- Testing changes to staging_employees table
INSERT INTO staging_employees (
    employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date,
    address, city, region, postal_code, country, home_phone, extension, notes, reports_to, photo_path
) VALUES (
             10, 'Doe', 'William', 'District Manager', 'Mr.', '1985-02-15', '2018-04-22',
             '456 Oak St', 'Othertown', 'OT', '67890', 'USA', '555-555-5678', '1234',
             'William is known for his strategic thinking.', 101, 'images/william.jpg'
         );

-- Updating a record in the staging_employees table
UPDATE staging_employees
SET first_name = 'Bill'
WHERE employee_id = 10;

-- Deleting a record from the staging_employees table
DELETE FROM staging_employees
WHERE employee_id = 10;