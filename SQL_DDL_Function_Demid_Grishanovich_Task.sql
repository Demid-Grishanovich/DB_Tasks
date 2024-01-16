CREATE OR REPLACE VIEW sales_revenue_by_category_qtr AS
SELECT
  c.name AS category,
  SUM(p.amount) AS total_sales_revenue
FROM
  category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE
  EXTRACT(QUARTER FROM p.payment_date) = EXTRACT(QUARTER FROM CURRENT_DATE)
  AND EXTRACT(YEAR FROM p.payment_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
  c.name
HAVING
  COUNT(p.payment_id) > 0;





CREATE OR REPLACE FUNCTION get_sales_revenue_by_category_qtr(current_qtr INTEGER) RETURNS TABLE(category TEXT, total_sales_revenue NUMERIC) AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.name AS category,
    SUM(p.amount) AS total_sales_revenue
  FROM
    category c
  JOIN film_category fc ON c.category_id = fc.category_id
  JOIN inventory i ON fc.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
  JOIN payment p ON r.rental_id = p.rental_id
  WHERE
    EXTRACT(QUARTER FROM p.payment_date) = current_qtr
    AND EXTRACT(YEAR FROM p.payment_date) = EXTRACT(YEAR FROM CURRENT_DATE)
  GROUP BY
    c.name
  HAVING
    COUNT(p.payment_id) > 0;
END;
$$ LANGUAGE plpgsql STABLE;




CREATE OR REPLACE FUNCTION new_movie(movie_title TEXT) RETURNS VOID AS $$
DECLARE
  lang_id INT;
BEGIN

  SELECT language_id INTO lang_id FROM language WHERE name = 'Klingon';
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Language not found';
  END IF;
  

  INSERT INTO film (title, rental_rate, rental_duration, replacement_cost, release_year, language_id)
  VALUES (movie_title, 4.99, 3, 19.99, EXTRACT(YEAR FROM CURRENT_DATE), lang_id);
END;
$$ LANGUAGE plpgsql;

