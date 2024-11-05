CREATE DATABASE lab6;

CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY ,
    street_addres VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departaments(
    departament_id SERIAL PRIMARY KEY ,
    departament_name VARCHAR(50) UNIQUE ,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    departament_id INTEGER REFERENCES departaments
);

INSERT INTO locations(street_addres, postal_code, city, state_province)
VALUES
    ('Main st',10001,'New York','NY'),
    ('Elm st',10002,'Los Angeles','CA'),
    ('Oak st',9002,'Chicago','IL'),
    ('Maple st',60601,'Houston','TX'),
    ('Pine St', 85001, 'Phoenix', 'AZ'),
    ('Cedar St', 98107, 'Seattle', 'WA'),
    ('Walnut St', 94109, 'San Francisco', 'CA'),
    ('Birch St', 30301, 'Atlanta', 'GA'),
    ('Witch St',57868,'New Jersey','NY');

INSERT INTO departaments (departament_id,departament_name, budget, location_id)
VALUES
    (40,'Finance', 100000, 1),
    (50,'HR', 50000, 2),
    (60,'IT', 120000, 3),
    (70,'Marketing', 80000, 4),
    (80,'Sales', 110000, 5),
    (90,'Customer Support', 90000, 6),
    (100,'Legal', 60000, 7),
    (110,'Engineering', 200000, 8),
    (120,'Tech Support',47000,9)
;

INSERT INTO employees (first_name, last_name, email, phone_number, salary, departament_id)
VALUES
    ('Mark', 'Taylor', 'mark.taylor@example.com', '678-123-4567', 68000, 60),
    ('Lucy', 'Martinez', 'lucy.martinez@example.com', '789-234-5678', 72000, 70),
    ('Tom', 'Anderson', 'tom.anderson@example.com', '890-345-6789', 90000, 80),
    ('Sophia', 'Wilson', 'sophia.wilson@example.com', '901-456-7890', 95000, 40),
    ('Liam', 'Thomas', 'liam.thomas@example.com', '012-567-8901', 78000, 60),
    ('Olivia', 'Lee', 'olivia.lee@example.com', '123-678-9012', 85000, 100),
    ('Noah', 'White', 'noah.white@example.com', '234-789-0123', 62000, 110),
    ('Emma', 'Walker', 'emma.walker@example.com', '345-890-1234', 83000, 90),
    ('James', 'Hall', 'james.hall@example.com', '456-901-2345', 77000, 40),
    ('Isabella', 'King', 'isabella.king@example.com', '567-012-3456', 56000, 50),
    ('Khan','Solo','khansoloking1@gmail.com','123-345-7890',80000,NULL);
--3
SELECT
    employees.first_name,
    employees.last_name,
    employees.departament_id,
    departaments.departament_name
FROM employees
LEFT JOIN departaments on departaments.departament_id = employees.departament_id;
--4
SELECT
    employees.first_name,
    employees.last_name,
    employees.departament_id,
    departaments.departament_name
FROM employees
LEFT JOIN departaments on departaments.departament_id = employees.departament_id
WHERE
    departaments.departament_id=80
   OR
    departaments.departament_id=40;
--5
SELECT
    employees.first_name,
    employees.last_name,
    locations.city,
    departaments.departament_name,
    locations.state_province
FROM employees
LEFT JOIN departaments  on departaments.departament_id = employees.departament_id
LEFT JOIN locations on locations.location_id=departaments.location_id;
--6
SELECT
    COUNT(first_name) AS NUMBER_OF_WORKERS,
    departaments.departament_name,
    employees.departament_id
FROM departaments
LEFT JOIN employees  on departaments.departament_id = employees.departament_id
GROUP BY departament_name, employees.departament_id ;
--7
SELECT
    employees.first_name,
    employees.last_name,
    employees.departament_id,
    departaments.departament_name
FROM employees
LEFT JOIN departaments  on departaments.departament_id = employees.departament_id;

DROP TABLE departaments,locations,employees;

DROP DATABASE lab6;

