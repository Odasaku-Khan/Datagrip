CREATE DATABASE lab5;
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY ,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER
);
CREATE TABLE Orders (
    ord_no INTEGER PRIMARY KEY ,
    purch_amt DECIMAL,
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER
);
CREATE TABLE Salesman(
    salesman_id INTEGER,
    name VARCHAR(255),
    city VARCHAR(255),
    commision DECIMAL
);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London',NULL,  5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001);
INSERT INTO Salesman (salesman_id, name, city, commision)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen',NULL,  0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

SELECT
    SUM(purch_amt)
FROM Orders;

SELECT
    AVG(purch_amt)
FROM Orders;

SELECT COUNT(cust_name)
FROM customers
WHERE cust_name IS NOT NULL ;

SELECT
    MIN(purch_amt)
FROM Orders;

INSERT INTO customers
VALUES (
        3010,'Hullian Aazib'
       );

SELECT *
FROM customers
WHERE cust_name LIKE '%b';

SELECT *
FROM Orders,customers
WHERE Orders.customer_id=customers.customer_id AND city='New York';

SELECT *
FROM customers,Orders
WHERE customers.customer_id=Orders.customer_id AND purch_amt>10;

SELECT
    COUNT(grade),
    SUM(grade)
FROM customers;

SELECT MAX(grade)
    FROM customers;

SELECT cust_name
    FROM customers
        WHERE cust_name IS NOT NULL ;

DROP TABLE customers,Salesman,Orders;
DROP DATABASE lab5 ;