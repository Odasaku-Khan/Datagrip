--1
CREATE DATABASE lab8;
--2
CREATE TABLE salesman(
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission INTEGER
);
CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INTEGER
);
CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    purchase_amount DECIMAL,
    order_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER
);
--3
INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);
INSERT INTO customer(customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);
INSERT INTO orders(order_id, order_date, customer_id, purchase_amount, salesman_id)
VALUES
(70001, '2012-05-10', 3005, 150.5, 5002),
(70009, '2012-09-10', 3001, 270.65, 5005),
(70002, '2012-10-05', 3002, 65.26, 5001),
(70004, '2012-08-17', 3009, 110.5, 5003),
(70007, '2012-09-10', 3005, 948.5, 5002),
(70005, '2012-07-27', 3007, 2400.6, 5001),
(70008, '2012-09-10', 3002, 5760, 5001);
--3
CREATE ROLE junior_dev LOGIN ;
--4
CREATE VIEW salesman_NY AS
    SELECT * FROM salesman
             WHERE city='New York';
--5
CREATE VIEW order_info AS
    SELECT
        salesman.name,
        customer.cust_name,
        orders.order_id,
        orders.order_date,
        orders.purchase_amount
    FROM orders
    LEFT JOIN salesman ON orders.salesman_id=salesman.salesman_id
    LEFT JOIN customer ON orders.customer_id=customer.customer_id;
GRANT ALL ON order_info TO junior_dev;
--6
CREATE VIEW customer_grade AS
    SELECT MAX(customer.grade) FROM customer;
GRANT SELECT ON customer_grade TO junior_dev;
--7
CREATE VIEW number_of_salesman AS
    SELECT COUNT(salesman.name),
           salesman.city
    FROM salesman
    GROUP BY (city);
--8
CREATE VIEW num_cust_of_salesman AS
    SELECT
        COUNT(customer.cust_name) AS customer_number,
        salesman.name
    FROM customer
    LEFT JOIN salesman on salesman.salesman_id=customer.salesman_id
    GROUP BY salesman.name
    HAVING COUNT(customer.cust_name)>1;
--9
CREATE ROLE intern;
GRANT junior_dev TO intern;




