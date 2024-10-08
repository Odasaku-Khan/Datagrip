CREATE DATABASE Lab4;

CREATE TABLE Warehouses(
    "code integer" SERIAL PRIMARY KEY ,
    "location character varying(255)" VARCHAR,
    "capacity integer" INTEGER
);

INSERT INTO Warehouses
VALUES (1 ,'Chicago',3),
       (2,'Chicago',4),
       (3,'New York',7),
       (4,'Los Angeles',2),
       (5,'San Francisco',8);

CREATE TABLE Boxes(
    "code character" CHARACTER(4),
    "contents character varying " VARCHAR(255),
    "value real" INTEGER,
    "warehouse integer" INTEGER
);

INSERT INTO Boxes
VALUES ('0MN7','Rocks',180,3),
       ('4H8P','Rocks',250,1),
       ('4RT3','Scissors',190,4),
       ('7G3H','Rocks',200,1),
       ('8JN6','Papers',75,1),
       ('8Y6U','Papers',50,3),
       ('9J6F','Papers',175,2),
       ('LL08','Rocks',140,4),
       ('P0H6','Scissors',125 ,1),
       ('P2T6','Scissors',150,2),
       ('TU55','Papers',90,5);

SELECT *
FROM Warehouses;

SELECT *
FROM Boxes
WHERE "value real">150;

SELECT
    DISTINCT "contents character varying "
FROM Boxes;

SELECT
    "warehouse integer",
    COUNT(*)
FROM Boxes
GROUP BY "warehouse integer"
ORDER BY "warehouse integer" ;

SELECT
    "warehouse integer",
    COUNT(*) AS num
FROM Boxes
GROUP BY "warehouse integer"
HAVING COUNT(*)>2
ORDER BY "warehouse integer" ;

INSERT INTO Warehouses
VALUES (6,'New York',3);

INSERT INTO Boxes
VALUES ('H5RT','Papers',200,2);

SELECT "value real"
FROM (
    SELECT "value real"
    FROM Boxes
    ORDER BY "value real" DESC
    LIMIT 3
     ) AS Z
ORDER BY Z."value real" ASC
LIMIT 1;


UPDATE Boxes
SET "value real"="value real" * 0.85
WHERE "value real"=
      (SELECT "value real"
       FROM (
           SELECT "value real"
           FROM Boxes
           ORDER BY "value real" DESC
           LIMIT 3
           )AS Z
       ORDER BY Z."value real" ASC
       LIMIT 1
       )
RETURNING *;

DELETE FROM Boxes
WHERE "value real"<150
RETURNING *;

DELETE FROM Boxes
USING  Warehouses
WHERE "warehouse integer"="code integer" AND
      "location character varying(255)"='New York'
RETURNING *;