-- employees.sql
-- Employees database
-- Author Eric Armstrong
-- Date 9/24/19
-- Note for Eric: mysqlsh -u root -p --sql

-- create database employees

CREATE DATABASE employees;

USE employees;

-- create table departments

create table departments (
    code CHAR(2) PRIMARY KEY ,
    `desc` VARCHAR(25)
); 

-- populate table departments
INSERT INTO Departments VALUES ( 'HR', 'Human Resources');
INSERT INTO Departments VALUES ( 'IT', 'Information Technology');
INSERT INTO Departments VALUES ( 'SL', 'Sales');

-- create table employees
create table Employees (
    id      INT     AUTO_INCREMENT PRIMARY KEY  ,
    name    VARCHAR(40) NOT NULL,
    sal        INT         NOT NULL,
    deptCode CHAR(2),
    FOREIGN KEY (deptCode) REFERENCES Departments(code)
); 

-- populate table Employees
INSERT INTO Employees (name, sal, deptCode) VALUES ('Sam Mai Tai', 50000, 'HR');
INSERT INTO Employees (name, sal, deptCode) VALUES ('James Brady', 55000, 'HR');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Whisky Strauss', 60000, 'HR');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Romeo Curacau', 65000, 'IT');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Jose Caipirinha', 65000, 'IT');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Tony Gin and Tonic', 80000, 'SL');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Debby Derby', 85000, 'SL');
INSERT INTO Employees (name, sal, deptCode) VALUES ('Morbid Mojito', 150000, Null);

-- Use left join when attributes do not match 

SELECT *    FROM Employees A
LEFT JOIN Depatments B
ON A.deptCode = B.code;

-- show employees that do not relate with departments

SELECT *    FROM Employees A
LEFT JOIN Depatments B
ON A.deptCode = B.code
where B.code IS NULL;

-- 

SELECT *    FROM Employees A
RIGHT JOIN Depatments B
ON A.deptCode = B.code
where B.deptCode IS NULL;

--a) List all rows in Departments
SELECT * FROM Departments;

--b) list only the codesin Departments
SELECT code FROM Departments

--c) list all rows in Employees 
SELECT * from Employees;

--d) list only the names of Employees in alphebetical order
SELECT name from Employees ORDER BY name;

--e) list only the names and salaries in Employees, from the highest to lowest salary.
SELECT name, sal FROM Employees ORDER BY sal;

--f) list the cartesian productof Employees and Departments.
SELECT * FROM Employees, Departments;

--g)do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product: do you know why? 
-- (Cause they have no shared values)
SELECT * FROM Employees NATURAL JOIN Departments;

--i) (Can drop "INNER" word on this b/c for SQL "INNER JOIN" is just a regular JOIN in sql syntax. "JOIN" is an OUTER JOIN)
SELECT * FROM Employees INNER JOIN Departments B ON A.deptCode = B.code;

--j) same as previous query but project name and salary of the employees plus the description of their departments.
SELECT name, sal, `desc` FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code;

--k)same as previous query but only the employees that earn less than 60000.
SELECT name, sal, `desc` FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code WHERE sal < 60000;

--l) same query as "i" but only employees that earn more than 'Jose Caipirinha' (we use a variable here)
SET @salCaipirina := (SELECT sal FROM Employees WHERE name = 'Jose Caiphirinha');
SELECT * FROM Employees A INNER JOIN Departments B ON A.deptCode = B.code WHERE sal > @salCaipirinha;

--m) List the outer left join of Employees and Departments (use the ON clause to match by department code); 
-- how does the result of thie query differ from query 'i'?
SELECT * FROM Employees A LEFT JOIN Departments B ON A.deptCode = B.code WHERE deptCode;

--n) query 'm', how would you do the left anti-join?
SELECT * FROM Employees A LEFT JOIN Departments B ON A.deptCode = B.code WHERE deptCode IS NULL;

--o) show the number of employees per department
SELECT deptCode, COUNT(*) FROM Employees GROUP by deptCode ;
SELECT deptCode AS Department, COUNT(*) AS Total FROM Employees WHERE deptCode IS NOT NULL GROUP by deptCode; 

--p) same qs query 'o' but I want to see the description of each department (not just their codes)
SELECT B.desc, A.total FROM (SELECT deptCode, COUNT(*) AS total FROM Employees Group by deptCode HAVING deptCode IS NOT NULL) A INNER JOIN Departments B ON A.deptCode = B.code;