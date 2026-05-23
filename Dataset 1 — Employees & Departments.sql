-- ====================================================================
-- PROJECT: SQL 50 Questions Marathon
-- DATASET 1 : EMPLOYEES & DEPARTMENTS
-- AUTHOR: Bhavesh Gurrap
-- PLATFORM OPTIMIZATION: T-SQL (MS SQL Server / SSMS)
-- ====================================================================

-- 1. DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- 2. CREATE TABLES
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    hire_date DATE,
    manager_id INT NULL
);

-- 3. INSERT MOCK DATA
INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing');

INSERT INTO Employees VALUES
(1, 'Amit', 2, 60000, '2020-01-15', NULL),
(2, 'Neha', 1, 50000, '2019-03-10', 1),
(3, 'Raj', 2, 70000, '2021-06-20', 1),
(4, 'Priya', 3, 65000, '2018-07-11', NULL),
(5, 'Karan', 4, 40000, '2022-02-05', 6),
(6, 'Simran', 4, 80000, '2017-09-23', NULL),
(7, 'Rohit', 2, 72000, '2020-11-01', 1),
(8, 'Anjali', 1, 52000, '2021-12-12', 2),
(9, 'Vikas', 3, 68000, '2019-05-30', 4),
(10, 'Sneha', 5, 55000, '2020-08-19', NULL),
(11, 'Arjun', 5, 60000, '2021-01-01', 10),
(12, 'Meena', 1, 48000, '2018-04-14', 2),
(13, 'Rahul', 2, 75000, '2017-03-22', 1),
(14, 'Pooja', 3, 62000, '2022-06-10', 4),
(15, 'Nikhil', 4, 45000, '2023-01-25', 6),
(16, 'Kavita', 5, 58000, '2019-09-09', 10),
(17, 'Deepak', 2, 71000, '2020-02-17', 1),
(18, 'Sonal', 3, 64000, '2021-03-03', 4),
(19, 'Manish', 4, 42000, '2022-11-11', 6),
(20, 'Tina', 1, 51000, '2020-10-10', 2),
(21, 'Ajay', 2, 73000, '2019-12-12', 1),
(22, 'Riya', 5, 57000, '2023-03-15', 10),
(23, 'Sameer', 3, 69000, '2018-08-08', 4),
(24, 'Divya', 4, 46000, '2021-07-07', 6),
(25, 'Gaurav', 2, 72000, '2022-05-05', 1);



-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Basic Filtering (WHERE Clause)
-- ================================================================
-- Q1. Find all employees working in the IT department.
SELECT emp_id, emp_name
FROM Employees
WHERE dept_id = 2;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Date Filtering
-- ================================================================
-- Q2. List employees hired after 2020.
SELECT emp_id, emp_name
FROM Employees
WHERE hire_date > '2020-12-31';


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Table Joins & GROUP BY Aggregation
-- ================================================================
-- Q3. Count employees in each department.
SELECT e.dept_id, d.dept_name, COUNT(e.dept_id) AS Employee_Count
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY e.dept_id, d.dept_name;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Aggregation Functions (AVG)
-- ================================================================
-- Q4. Find average salary per department.
SELECT d.dept_name, AVG(salary) AS Avg_salary_deptwise
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY e.dept_id, d.dept_name;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Common Table Expressions (CTEs) & Right Joins
-- ================================================================
-- Q5. Find employees earning more than the average salary of their department.
WITH CTE_deptwise_Avg AS (
    SELECT dept_id, AVG(salary) AS Avg_salary_deptwise
    FROM Employees
    GROUP BY dept_id
)
SELECT e.emp_name, e.salary, c.Avg_salary_deptwise
FROM CTE_deptwise_Avg c
RIGHT JOIN Employees e ON c.dept_id = e.dept_id
WHERE e.salary > c.Avg_salary_deptwise;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Self Joins (Hierarchical Data Structure)
-- ================================================================
-- Q6. List employees along with their manager names.
SELECT
    e.emp_id,
    e.emp_name AS employee_name,
    m.emp_name AS manager_name
FROM Employees e
LEFT JOIN Employees m ON e.manager_id = m.emp_id;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: GROUP BY Filters (HAVING Clause)
-- ================================================================
-- Q7. Find departments with more than 4 employees.
SELECT e.dept_id, d.dept_name, COUNT(*) AS emp_count
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY e.dept_id, d.dept_name
HAVING COUNT(*) > 4;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Top Filtering & Descending Sorts
-- ================================================================
-- Q8. Get top 3 highest paid employees.
SELECT TOP 3 emp_name, salary
FROM Employees
ORDER BY salary DESC;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Subqueries & Window Ranking Functions (RANK)
-- ================================================================
-- Q9. Find the second highest salary in the company.
SELECT emp_name, salary
FROM (
    SELECT emp_name, RANK() OVER (ORDER BY salary DESC) AS Ranking, salary 
    FROM Employees
) g
WHERE Ranking = 2;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Window Functions with Partition Tracking
-- ================================================================
-- Q10. Rank employees within each department based on salary.
SELECT d.dept_name, e.emp_name, e.salary, RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS Ranking
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;
