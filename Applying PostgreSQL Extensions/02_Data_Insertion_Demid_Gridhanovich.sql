
INSERT INTO employees (first_name, last_name, email, encrypted_password) VALUES
   ('Emma', 'Stone', 'emma.stone@example.com', crypt('emma1234', gen_salt('bf'))),
   ('Liam', 'Harris', 'liam.harris@example.com', crypt('liam5678', gen_salt('bf'))),
    ('Olivia', 'Martinez', 'olivia.martinez@example.com', crypt('olivia910', gen_salt('bf'))),
    ('Noah', 'Robinson', 'noah.robinson@example.com', crypt('noah1112', gen_salt('bf'))),
    ('Ava', 'Walker', 'ava.walker@example.com', crypt('ava1314', gen_salt('bf'))),
    ('Mason', 'Young', 'mason.young@example.com', crypt('mason1516', gen_salt('bf'))),
    ('Sophia', 'King', 'sophia.king@example.com', crypt('sophia1718', gen_salt('bf'))),
    ('Jacob', 'Wright', 'jacob.wright@example.com', crypt('jacob1920', gen_salt('bf'))),
    ('Isabella', 'Scott', 'isabella.scott@example.com', crypt('isabella2122', gen_salt('bf'))),
    ('Ethan', 'Green', 'ethan.green@example.com', crypt('ethan2324', gen_salt('bf'))),
    ('Mia', 'Adams', 'mia.adams@example.com', crypt('mia2526', gen_salt('bf'))),
    ('Lucas', 'Baker', 'lucas.baker@example.com', crypt('lucas2728', gen_salt('bf'))),
    ('Amelia', 'Nelson', 'amelia.nelson@example.com', crypt('amelia2930', gen_salt('bf'))),
    ('Henry', 'Carter', 'henry.carter@example.com', crypt('henry3132', gen_salt('bf'))),
    ('Charlotte', 'Mitchell', 'charlotte.mitchell@example.com', crypt('charlotte3334', gen_salt('bf'))),
    ('Sebastian', 'Perez', 'sebastian.perez@example.com', crypt('sebastian3536', gen_salt('bf'))),
    ('Harper', 'Roberts', 'harper.roberts@example.com', crypt('harper3738', gen_salt('bf'))),
    ('Alexander', 'Turner', 'alexander.turner@example.com', crypt('alexander3940', gen_salt('bf'))),
    ('Ella', 'Phillips', 'ella.phillips@example.com', crypt('ella4142', gen_salt('bf'))),
    ('Daniel', 'Campbell', 'daniel.campbell@example.com', crypt('daniel4344', gen_salt('bf')));

SELECT COUNT(*) FROM employees;