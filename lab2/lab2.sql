CREATE DATABASE  lab2;
CREATE TABLE countries
(
    id serial primary key,
    country_name varchar,
    region_id integer,
    population integer
);
INSERT INTO countries
values (1,'Italy',15,5500000);
SELECT * from countries;

INSERT INTO countries(id,country_name)
values (2,'Spain');

INSERT INTO countries (region_id)
values (null);

insert into countries (population)
values (1234567890);
insert into countries (population)
values (123456);
insert into countries (population)
values (1890);

ALTER table countries ALTER COLUMN country_name SET DEFAULT ('Kazakhstan');

insert into countries (country_name) VALUES (default) ;

UPDATE countries
set country_name =default
where id>2 and id<6;

CREATE table countries_new(
    like countries
);
SELECT * FROM countries_new;

INSERT INTO countries_new
SELECT * FROM countries;

UPDATE countries_new
SET region_id=1
WHERE region_id is null;

UPDATE countries
SET region_id=1
WHERE region_id is null;

ALTER TABLE countries_new
ALTER COLUMN population TYPE decimal;


UPDATE countries_new AS new_population
SET population=population*1.1
RETURNING *;

DELETE FROM countries_new
WHERE population<100000
RETURNING *;

DELETE FROM countries_new
USING countries
WHERE countries_new.id=countries.id
RETURNING *;

DELETE FROM countries
RETURNING *;

DROP DATABASE lab2;