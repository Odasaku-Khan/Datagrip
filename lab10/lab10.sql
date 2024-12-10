CREATE DATABASE lab10;
CREATE TABLE Books(
    books_id INTEGER PRIMARY KEY ,
    title VARCHAR,
    author VARCHAR,
    price DECIMAL,
    quamtity INTEGER
);
CREATE TABLE Orders(
    order_id INTEGER PRIMARY KEY ,
    books_id INTEGER REFERENCES Books(books_id),
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER
);
CREATE TABLE Customers(
    custoer_id INTEGER PRIMARY KEY ,
    name VARCHAR,
    email VARCHAR
);
INSERT INTO Books VALUES (1,'Database 101','A.Smith',40,10),
                         (2,'Learn SQL','B. Johnson',35,15),
                         (3,'Advanced DB','C. Lee',50,5);
INSERT INTO Customers VALUES (101,'John Doe','johndoe@gmail.com'),
                             (102,'jane Doe','jamedoe@gmail.com');

--1
BEGIN TRANSACTION;
INSERT INTO Orders  VALUES (1,1,101,NOW(),2);
UPDATE Books
SET quamtity=quamtity-2
WHERE books_id=1;
COMMIT ;
END;
SELECT * FROM Orders WHERE order_id=1;
SELECT * FROM Books WHERE books_id=1;
--2
BEGIN TRANSACTION;
DO $$
    DECLARE
    available INTEGER;
BEGIN
    SELECT Books.quamtity INTO available
    FROM Books
    WHERE books_id=3;
    IF available<10 THEN
        RAISE EXCEPTION 'quantity less than in request:%',available ;
    ELSE
        INSERT INTO Orders VALUES (2,3,102,NOW(),10);
        UPDATE Books
        SET quamtity=quamtity-10
        WHERE books_id=3;
        END IF;
end;
$$;
COMMIT ;
END ;
--3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED ;
UPDATE Books
    SET price=price+5
WHERE books_id=2;
BEGIN TRANSACTION ISOLATION LEVEL  READ COMMITTED ;
SELECT Books.price
    FROM Books
        WHERE books_id=2;
COMMIT ;
ROLLBACK ;
COMMIT ;
END;
END ;
--4
BEGIN TRANSACTION ;
UPDATE Customers
    SET email='newemail@gmail.com'
WHERE custoer_id=102;
COMMIT;
--IDK HOW TO RESTART DATABASE SERVER
SELECT * FROM Customers
    WHERE custoer_id=102;
DROP TABLE Orders,Customers,Books;