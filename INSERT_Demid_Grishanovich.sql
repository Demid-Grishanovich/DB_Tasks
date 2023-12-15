

INSERT INTO film 
    (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update, special_features, fulltext)
VALUES 
    ('The Lighthouse', 'A tale of two lighthouse keepers on a remote and mysterious island in the 1890s.', 2019, 1, 14, 4.99, 109, 19.99, 'R', CURRENT_TIMESTAMP, '{"Commentary", "Deleted Scenes"}', 'The Lighthouse Full Text'),
    ('Parasite', 'A dark comedy thriller about two families from different classes in Seoul, South Korea.', 2019, 1, 14, 4.99, 132, 19.99, 'R', CURRENT_TIMESTAMP, '{"Behind the Scenes"}', 'Parasite Full Text'),
    ('Moonlight', 'A young African-American man grapples with his identity and sexuality while experiencing the everyday struggles of childhood, adolescence, and burgeoning adulthood.', 2016, 1, 14, 4.99, 111, 19.99, 'R', CURRENT_TIMESTAMP, '{"Exclusive Interviews"}', 'Moonlight Full Text');


INSERT INTO actor (first_name, last_name, last_update)
VALUES
    ('Willem', 'Dafoe', CURRENT_TIMESTAMP),
    ('Robert', 'Pattinson', CURRENT_TIMESTAMP),
    ('Song', 'Kang-ho', CURRENT_TIMESTAMP),
    ('Lee', 'Sun-kyun', CURRENT_TIMESTAMP),
    ('Trevante', 'Rhodes', CURRENT_TIMESTAMP),
    ('Ashton', 'Sanders', CURRENT_TIMESTAMP);


INSERT INTO film_actor (actor_id, film_id, last_update)
VALUES
    ((SELECT actor_id FROM actor WHERE first_name = 'Song' AND last_name = 'Kang-ho'), (SELECT film_id FROM film WHERE title = 'Parasite'), CURRENT_TIMESTAMP),
    ((SELECT actor_id FROM actor WHERE first_name = 'Lee' AND last_name = 'Sun-kyun'), (SELECT film_id FROM film WHERE title = 'Parasite'), CURRENT_TIMESTAMP);


INSERT INTO film_actor (actor_id, film_id, last_update)
VALUES
    ((SELECT actor_id FROM actor WHERE first_name = 'Trevante' AND last_name = 'Rhodes'), (SELECT film_id FROM film WHERE title = 'Moonlight'), CURRENT_TIMESTAMP),
    ((SELECT actor_id FROM actor WHERE first_name = 'Ashton' AND last_name = 'Sanders'), (SELECT film_id FROM film WHERE title = 'Moonlight'), CURRENT_TIMESTAMP);


INSERT INTO inventory (film_id, store_id, last_update)
SELECT film_id, store_id, CURRENT_TIMESTAMP
FROM film, (SELECT store_id FROM store WHERE store_id IN (1, 2)) AS store
WHERE title IN ('The Lighthouse', 'Parasite', 'Moonlight');








