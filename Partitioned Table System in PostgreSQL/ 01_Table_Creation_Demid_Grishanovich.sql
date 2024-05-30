DROP TABLE IF EXISTS sales_info;

CREATE TABLE sales_info (
                            sale_id SERIAL,
                            item_id INT NOT NULL,
                            location_id INT NOT NULL,
                            seller_id INT NOT NULL,
                            amount NUMERIC(7, 2) NOT NULL,
                            sale_date DATE,
                            PRIMARY KEY(sale_id, sale_date)
) PARTITION BY RANGE (sale_date);

-- 1
CREATE TABLE sales_info_2024_05
    PARTITION OF sales_info
    FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');

-- 2
CREATE TABLE sales_info_2024_04
    PARTITION OF sales_info
    FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');

-- 3
CREATE TABLE sales_info_2024_03
    PARTITION OF sales_info
    FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');

-- 4
CREATE TABLE sales_info_2024_02
    PARTITION OF sales_info
    FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

-- 5
CREATE TABLE sales_info_2024_01
    PARTITION OF sales_info
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

-- 6
CREATE TABLE sales_info_2023_12
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');

-- 7
CREATE TABLE sales_info_2023_11
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');

-- 8
CREATE TABLE sales_info_2023_10
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');

-- 9
CREATE TABLE sales_info_2023_09
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');

-- 10
CREATE TABLE sales_info_2023_08
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');

-- 11
CREATE TABLE sales_info_2023_07
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');

-- 12
CREATE TABLE sales_info_2023_06
    PARTITION OF sales_info
    FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');
