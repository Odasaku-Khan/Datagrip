CREATE DATABASE Lab7;

CREATE TABLE departaments2(
    departament_id SERIAL PRIMARY KEY,
    departament_name VARCHAR(25),
    budget INTEGER
);

CREATE TABLE country(
    country_id SERIAL PRIMARY KEY ,
    country_name VARCHAR(25),
    population INTEGER,
    area INTEGER
);

CREATE TABLE employee(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary INTEGER,
    departament_id INTEGER
);

INSERT INTO country(country_name, population, area) VALUES
('USA', 331002651, 9833517),
('Canada', 37742154, 9984670),
('Germany', 83783942, 357114),
('France', 65273511, 551695),
('Japan', 126476461, 377975);

INSERT INTO employee (first_name, last_name, salary, departament_id) VALUES
('abcd','error',NULL,Null),
('John', 'Doe', 50000, 1),
('Jane', 'Smith', 60000, 2),
('Alice', 'Johnson', 70000, 1),
('Bob', 'Brown', 55000, 3),
('Charlie', 'Davis', 65000, 2);

INSERT INTO departaments2(departament_name, budget) VALUES
('Human Resources', 200000),
('Finance', 500000),
('IT', 300000),
('Marketing', 150000),
('Sales', 400000);

CREATE INDEX country_indx ON country(country_name);

CREATE INDEX indx_employee_first_last_name ON employee(first_name,last_name);

CREATE UNIQUE INDEX salary_indx ON employee(salary);

CREATE INDEX indx_employee_subname ON employee(SUBSTRING(first_name FROM 1 FOR 4));

CREATE INDEX indx_employee_departament ON employee(departament_id,salary);

CREATE INDEX indx_depatament_budget ON departaments2(departament_id,budget);

SELECT * FROM country WHERE country.country_name = 'Germany';

SELECT * FROM employee WHERE employee.first_name = 'John'
AND last_name = 'Doe';

SELECT * FROM employee WHERE salary < 55000
AND salary > 15000;

SELECT * FROM employee WHERE substring(first_name
from 1 for 4) = 'abcd';

SELECT * FROM employee e JOIN departaments2 d
ON d.departament_id = e.departament_id WHERE
d.budget > 150000 AND e.salary < 60000;

drop table departaments2,employee,country;