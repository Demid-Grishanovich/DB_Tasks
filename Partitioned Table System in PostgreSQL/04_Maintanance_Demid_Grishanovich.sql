CREATE OR REPLACE FUNCTION manage_sales_partitions() RETURNS integer
    LANGUAGE plpgsql AS
$$
DECLARE
pattern_table_name VARCHAR;
    next_table_name VARCHAR;
    one_month_later DATE;
    two_months_later DATE;
    last_valid_table_name VARCHAR;
    table_name RECORD;
BEGIN
    pattern_table_name := 'sales_info_\d{4}_\d{2}';
    -- Get the next year and month
    next_table_name := to_char(now() + INTERVAL '1 month', 'sales_info_YYYY_MM');

    -- Get range start and end dates for the next month
    one_month_later := (now() + INTERVAL '1 month')::DATE;
    two_months_later := (now() + INTERVAL '2 month')::DATE;
    last_valid_table_name := to_char(now() - INTERVAL '12 month', 'sales_info_YYYY_MM');

    -- Create the partition for the next month
EXECUTE format('CREATE TABLE IF NOT EXISTS %I PARTITION OF sales_info FOR VALUES FROM (%L) TO (%L);', next_table_name, one_month_later, two_months_later);

-- Remove partitions older than a year
FOR table_name IN
SELECT table_name
FROM information_schema.TABLES
WHERE table_name ~ pattern_table_name
        AND table_name <= last_valid_table_name
    LOOP
        EXECUTE format('DROP TABLE IF EXISTS %I', table_name.table_name);
END LOOP;
RETURN 1;
END;
$$;

-- Create extension for pg_cron
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Schedule a pg_cron task to run monthly
SELECT cron.schedule('0 0 1 * *', $$SELECT manage_sales_partitions();$$);
