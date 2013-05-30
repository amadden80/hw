
--psql
--CREATE DATABASE friends_db;
--\q

--Bash
--psql -d friends_db -f dbSetup.sql


CREATE TABLE friends
(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(120),
  age INT4,
  gender VARCHAR(2),
  image VARCHAR(120),
  twitter VARCHAR(120),
  github VARCHAR(120),
  facebook VARCHAR(120),
  website VARCHAR(120),
  email VARCHAR(120),
  phone VARCHAR(120)
);



