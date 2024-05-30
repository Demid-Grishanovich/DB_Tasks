
SELECT *
FROM sales_info
WHERE sale_date >= '2024-05-01' AND sale_date < '2024-06-01';

SELECT
    EXTRACT(month FROM sale_date) AS month,
    SUM(amount) AS total_amount
FROM sales_info
GROUP BY month
ORDER BY month;

SELECT
    seller_id,
    SUM(amount) AS total_amount
FROM sales_info
WHERE location_id = 7
GROUP BY seller_id
ORDER BY total_amount DESC
    LIMIT 3;