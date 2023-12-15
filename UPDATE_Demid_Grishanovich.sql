
UPDATE film
SET rental_duration = 21, rental_rate = 9.99
WHERE title = 'The Lighthouse';


UPDATE film
SET rental_duration = 21, rental_rate = 9.99
WHERE title = 'Parasite';


UPDATE film
SET rental_duration = 21, rental_rate = 9.99
WHERE title = 'Moonlight';



UPDATE customer
SET first_name = 'Demid', last_name = 'Grishanovich', address_id = (
    SELECT address_id
    FROM address
    ORDER BY RANDOM()
    LIMIT 1
)
WHERE customer_id = (
    SELECT customer.customer_id
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN payment ON customer.customer_id = payment.customer_id
    GROUP BY customer.customer_id
    HAVING COUNT(DISTINCT rental.rental_id) >= 10 AND COUNT(DISTINCT payment.payment_id) >= 10
    ORDER BY RANDOM()
    LIMIT 1
);

UPDATE customer
SET create_date = CURRENT_DATE
WHERE customer_id = (
    SELECT customer_id
    FROM customer
    ORDER BY RANDOM()
    LIMIT 1
)
RETURNING *;





