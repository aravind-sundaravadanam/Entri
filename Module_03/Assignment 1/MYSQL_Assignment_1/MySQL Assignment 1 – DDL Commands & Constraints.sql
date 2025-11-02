-- TO CREATE Employee Database
CREATE DATABASE Employee;
use Employee;

CREATE TABLE Departments (
    Department_ID INT,
    Department_Name VARCHAR(100)
);

CREATE TABLE Location (
    Location_ID INT,
    Location VARCHAR(30)
);

CREATE TABLE Employees (
    Employee_ID INT,
    Employee_Name VARCHAR(30),
    Gender ENUM('M','F'),
    Age INT,
    Hire_Date DATE,
    Designation VARCHAR(100),
    Department_ID INT,
    Location_ID INT,
    Salary DECIMAL(10,2)
);

    -- Table Alteration (ALTER) --
 -- ADD Column --
 ALTER TABLE Employees
 ADD COLUMN Email VARCHAR(30);
 
 -- Modify Column --
 ALTER TABLE Employees
 Modify Column Designation VARCHAR(110);
 
-- Drop the Column  --
ALTER TABLE Employees
DROP COLUMN Age;

-- Rename the column Name --
ALTER TABLE Employees
RENAME COLUMN Hire_Date TO Date_of_Joining;

    -- Table Renaming (RENAME) --
ALTER TABLE departments
RENAME TO departments_info;

ALTER TABLE Location
RENAME TO Locations;

    -- Table Truncation (TRUNCATE) --
TRUNCATE TABLE Employees;

    -- Database & Table Dropping (DROP)--
-- DROP table --
DROP TABLE Employees;

-- DROP Database --
DROP DATABASE employee;

DROP DATABASE IF EXISTS Employee;
CREATE DATABASE Employee;
use Employee;

CREATE DATABASE Employee;
USE Employee;

CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    Location VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Employees (
    Employee_id INT PRIMARY KEY,
    Employee_name VARCHAR(30) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M','F')),
    Age INT CHECK (age >= 18),
    Hire_Date DATE DEFAULT (CURRENT_DATE),
    Designation VARCHAR(100),
    Department_id INT,
    Location_id INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_ID) REFERENCES Departments (Department_ID),
    FOREIGN KEY (Location_ID) REFERENCES Location (Location_ID)
);
