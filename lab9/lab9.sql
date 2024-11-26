CREATE DATABASE lab9;
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Salary NUMERIC(10, 2) NOT NULL
);

INSERT INTO Employees (Name, Position, Salary) VALUES
('Alice Johnson', 'Manager', 75000.00),
('Bob Smith', 'Developer', 65000.00),
('Charlie Davis', 'Analyst', 58000.00);

CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price NUMERIC(10, 2) NOT NULL
);

INSERT INTO Products (Name, Category, Price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00);

CREATE TABLE Categories (
    CategoryID SERIAL PRIMARY KEY,
    Name VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO Categories (Name) VALUES
('Electronics'),
('Furniture'),
('Kitchenware');

CREATE TABLE EmployeeBonuses (
    BonusID SERIAL PRIMARY KEY,
    EmployeeID INT REFERENCES Employees(EmployeeID),
    BonusAmount NUMERIC(10, 2) NOT NULL,
    count INTEGER
);

INSERT INTO EmployeeBonuses (EmployeeID, BonusAmount,count) VALUES
(1, 5000.00 ,3),
(2, 3000.00,2),
(3, 2500.00,9);

--1
CREATE FUNCTION increase_value(val integer) RETURNS integer AS $$
BEGIN
RETURN val+10;
END; $$
LANGUAGE plpgsql;
SELECT increase_value(24);
--2
CREATE OR REPLACE FUNCTION compareto(
    val INTEGER,
    val2 INTEGER,
    OUT result VARCHAR)
    RETURNS VARCHAR AS $$
    BEGIN
        IF val>val2 THEN
            result :='Createst ' ;
        ELSIF
                val<val2 THEN
                result:='Lowest ';
        ELSIF val2=val THEN
            result:='Equal ';
            END IF;
    END;
    $$
LANGUAGE plpgsql;
SELECT compareto(37,27);
SELECT compareto(35,69);
SELECT compareto(89,89);
drop function compareto;
--3
CREATE FUNCTION number_series(number INTEGER)
    RETURNS SETOF INT
    AS $$
    BEGIN
        FOR i IN 1..number LOOP
            RETURN NEXT i;
            end loop;
        RETURN ;
    end;
    $$
LANGUAGE plpgsql;
SELECT * FROM number_series(14);
DROP FUNCTION number_series;
--4
CREATE FUNCTION find_employee (find_name VARCHAR )
RETURNS TABLE(
    find_employeeID INTEGER,
    find_salary NUMERIC,
    find_position VARCHAR
) AS $$
    BEGIN
        RETURN QUERY SELECT
                         EmployeeID,
                         Salary,
                         Position
        FROM employees
        WHERE Employees.Name ILIKE find_name;
    end;
    $$
LANGUAGE plpgsql;
DROP FUNCTION find_employee;
SELECT * FROM find_employee('Bob%');
--5
CREATE FUNCTION list_products(find_category VARCHAR)
RETURNS TABLE(
    find_name VARCHAR,
    find_price NUMERIC
) AS $$
    BEGIN
        RETURN QUERY SELECT
                         Products.Name,
                         Products.Price
        FROM Products
        WHERE Category ILIKE find_category;
    end;
    $$
LANGUAGE plpgsql;
SELECT * FROM list_products('Ele%');
--6
CREATE FUNCTION calculate_bonus(
    bonus_amount NUMERIC,
    count INTEGER
) RETURNS NUMERIC AS $$
    BEGIN
        RETURN  bonus_amount*count;
    end;
    $$
LANGUAGE plpgsql;
CREATE FUNCTION updateSalary(salary INTEGER,count INTEGER,bonusAmount INTEGER,OUT Result INTEGER) AS $$
    DECLARE
    calculated INTEGER;
    BEGIN
        calculated:=calculate_bonus(count,bonusAmount);
        Result:= salary + calculated;
    end;
    $$
LANGUAGE plpgsql;
select updateSalary(4500,24,900);
drop function calculate_bonus(bonus_amount NUMERIC, count INTEGER);
--7
CREATE FUNCTION complex_calculation(
    num INTEGER,
    str VARCHAR
) RETURNS VARCHAR AS $$
    DECLARE
    proc_str VARCHAR;
    calc_value INTEGER;
    fin_res varchar;
    BEGIN
        SELECT str || ' suffix' INTO proc_str;
        SELECT num *10 INTO calc_value;
        fin_res:=proc_str || ' calculated ' ||calc_value;
        RETURN fin_res;
    END ;
$$
language plpgsql;
SELECT complex_calculation(5,'TESTSTRING');
DROP TABLE EmployeeBonuses,Employees,Products,Categories;
CREATE FUNCTION re (name VARCHAR)
returns VARCHAR AS $$
    DECLARE
        X VARCHAR;
    BEGIN
        X:='HELLO ' || name;
        return X;
    end;
    $$
LANGUAGE plpgsql;
select re('rex');
drop function re(name VARCHAR);