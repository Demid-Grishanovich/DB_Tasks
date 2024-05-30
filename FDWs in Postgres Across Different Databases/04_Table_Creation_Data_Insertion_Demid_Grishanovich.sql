CREATE TABLE external_table (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  years INTEGER
);


INSERT INTO external_table (full_name, years) VALUES
   ('Anna Johnson', 40),
   ('Robert Brown', 29),
   ('Alice Williams', 31),
   ('Steve Wilson', 45),
   ('Nancy Moore', 37),
   ('Megan Taylor', 33),
   ('Gary Lewis', 26),
   ('Lisa Martin', 28),
   ('Kevin Clark', 39),
   ('Mary Rodriguez', 30);