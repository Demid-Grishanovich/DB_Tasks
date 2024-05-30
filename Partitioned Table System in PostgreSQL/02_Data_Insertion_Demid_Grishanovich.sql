DO $$
DECLARE
v_item_id INT;
    v_location_id INT;
    v_seller_id INT;
    v_amount NUMERIC(7, 2);
    v_sale_date DATE;
BEGIN
FOR i IN 1..1000 LOOP
        v_item_id := trunc(random() * 150 + 1);
        v_location_id := trunc(random() * 15 + 1);
        v_seller_id := trunc(random() * 60 + 1);
        v_amount := round(CAST(random() AS numeric) * 1500, 2);
        v_sale_date := date '2023-06-01' + trunc(random() * (date '2024-06-01' - date '2023-06-01'))::int;

INSERT INTO sales_info (item_id, location_id, seller_id, amount, sale_date)
VALUES (v_item_id, v_location_id, v_seller_id, v_amount, v_sale_date);
END LOOP;
END $$;

SELECT count(*) FROM sales_info;
