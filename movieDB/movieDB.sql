
-- psql -d moviedb -f movieDB.sql


CREATE TABLE movies
(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(120) UNIQUE,
  year INT4,
  rated VARCHAR(5),
  genre VARCHAR(120),
  released VARCHAR(25),
  runtime VARCHAR(25),
  director VARCHAR(120),
  writer VARCHAR(120),
  actors VARCHAR(120),
  imdbRating INT4
);

