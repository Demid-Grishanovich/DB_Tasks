--1
CREATE USER rentaluser WITH PASSWORD 'rentalpassword';
GRANT CONNECT ON DATABASE your_database_name TO rentaluser;

--2
GRANT SELECT ON customer TO rentaluser;

--3
CREATE ROLE rental;
GRANT rental TO rentaluser;

--4
GRANT INSERT, UPDATE ON rental TO rental;

--5
REVOKE INSERT ON rental FROM rental;

--6
-- Предполагается, что имя и фамилия клиента - 'John Doe' и он имеет id = 1
CREATE ROLE client_john_doe LOGIN PASSWORD 'password_for_john_doe';
GRANT SELECT ON rental TO client_john_doe WHERE customer_id = 1;
GRANT SELECT ON payment TO client_john_doe WHERE customer_id = 1;
