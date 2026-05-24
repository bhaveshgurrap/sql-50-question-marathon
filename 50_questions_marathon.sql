-- ====================================================================
-- PROJECT: SQL 50 Questions Marathon
-- AUTHOR: Bhavesh Gurrap
-- PLATFORM OPTIMIZATION: T-SQL (MS SQL Server / SSMS)
-- ====================================================================

/*
***********************************************************************
***********************************************************************
   DATASET 1: EMPLOYEES & DEPARTMENTS
***********************************************************************
***********************************************************************
*/

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


/*
***********************************************************************
***********************************************************************
   DATASET 2: CUSTOMERS & ORDERS
***********************************************************************
***********************************************************************
*/

-- 1. DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- 2. CREATE TABLES
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount INT
);

-- 3. INSERT MOCK DATA
INSERT INTO Customers VALUES
(1,'Amit','Mumbai'),
(2,'Neha','Delhi'),
(3,'Raj','Pune'),
(4,'Priya','Mumbai'),
(5,'Karan','Delhi'),
(6,'Simran','Bangalore'),
(7,'Rohit','Pune'),
(8,'Anjali','Mumbai'),
(9,'Vikas','Delhi'),
(10,'Sneha','Bangalore'),
(11,'Arjun','Mumbai'),
(12,'Meena','Pune'),
(13,'Rahul','Delhi'),
(14,'Pooja','Mumbai'),
(15,'Nikhil','Bangalore'),
(16,'Kavita','Delhi'),
(17,'Deepak','Mumbai'),
(18,'Sonal','Pune'),
(19,'Manish','Delhi'),
(20,'Tina','Mumbai');

INSERT INTO Orders VALUES
(1,1,'2023-01-01',500),
(2,2,'2023-01-02',700),
(3,3,'2023-01-03',400),
(4,1,'2023-01-04',800),
(5,5,'2023-01-05',200),
(6,6,'2023-01-06',900),
(7,7,'2023-01-07',300),
(8,8,'2023-01-08',1000),
(9,9,'2023-01-09',600),
(10,10,'2023-01-10',750),
(11,11,'2023-01-11',500),
(12,12,'2023-01-12',650),
(13,13,'2023-01-13',700),
(14,14,'2023-01-14',850),
(15,15,'2023-01-15',950),
(16,16,'2023-01-16',300),
(17,17,'2023-01-17',400),
(18,18,'2023-01-18',550),
(19,19,'2023-01-19',600),
(20,20,'2023-01-20',700),
(21,1,'2023-01-21',650),
(22,2,'2023-01-22',800),
(23,3,'2023-01-23',450),
(24,4,'2023-01-24',900),
(25,5,'2023-01-25',350);


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Table Joins & SUM Aggregations
-- ================================================================
-- Q11. Find total order amount per customer.
SELECT c.name, SUM(o.amount) AS total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Left Joins & Orphan Identification (IS NULL)
-- ================================================================
-- Q12. Find customers who never placed orders.
SELECT c.name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Sorted Top-Tier Aggregations
-- ================================================================
-- Q13. Get top 5 customers by total spending.
SELECT TOP 5 c.name, SUM(o.amount) AS total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY SUM(o.amount) DESC;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Row Counting & HAVING Constraints
-- ================================================================
-- Q14. Find customers with more than 2 orders.
SELECT o.customer_id, c.name, COUNT(*) AS Order_Count
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(*) > 2;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Analytical Partitions within Derived Tables
-- ================================================================
-- Q15. Find highest order amount per city.
SELECT city, amount
FROM (
    SELECT c.city, RANK() OVER (PARTITION BY c.city ORDER BY o.amount DESC) AS Rnk, o.amount
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
) a
WHERE Rnk = 1;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Explicit Datatype Casting & Daily Trends
-- ================================================================
-- Q16. Find daily total sales.
SELECT CAST(order_date AS DATE) AS Order_Date, SUM(amount) AS Total_Amount
FROM Orders
GROUP BY CAST(order_date AS DATE);


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Non-correlated Scalar Subqueries in HAVING
-- ================================================================
-- Q17. Get customers whose total spending is above average.
SELECT customer_id, SUM(amount) AS Total
FROM Orders
GROUP BY customer_id
HAVING SUM(amount) > (SELECT AVG(amount) AS avg_amount FROM Orders);


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Lag Window Calculations & Time Differentials
-- ================================================================
-- Q18. Find consecutive order dates.
SELECT *
FROM (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS Previous_date
    FROM Orders
) a
WHERE DATEDIFF(day, Previous_date, order_date) = 1;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Multi-step Global Ranking Layouts
-- ================================================================
-- Q19. Rank customers by spending.
WITH CTE_Customerspend AS ( 
    SELECT customer_id, SUM(amount) AS Total_Spend
    FROM Orders
    GROUP BY customer_id
)
SELECT customer_id, Total_Spend, RANK() OVER (ORDER BY Total_Spend DESC) AS Ranking
FROM CTE_Customerspend;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Boundary Date Scans (MIN Value Extraction)
-- ================================================================
-- Q20. Find first order date per customer.
SELECT customer_id, MIN(order_date) AS first_order
FROM Orders
GROUP BY customer_id;


/*
***********************************************************************
***********************************************************************
   DATASET 3: BANKING SYSTEM
***********************************************************************
***********************************************************************
*/

-- 1. DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Bank_Transactions;
DROP TABLE IF EXISTS Bank_Accounts;
DROP TABLE IF EXISTS Bank_Customers;

-- 2. CREATE TABLES
CREATE TABLE Bank_Customers (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Bank_Accounts (
    account_id INT PRIMARY KEY,
    cust_id INT,
    account_type VARCHAR(20),
    balance INT
);

CREATE TABLE Bank_Transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    txn_type VARCHAR(10),
    amount INT
);

-- 3. INSERT MOCK DATA
INSERT INTO Bank_Customers VALUES
(1,'Amit','Mumbai'),
(2,'Neha','Delhi'),
(3,'Raj','Pune'),
(4,'Priya','Mumbai'),
(5,'Karan','Delhi'),
(6,'Simran','Bangalore'),
(7,'Rohit','Pune'),
(8,'Anjali','Mumbai'),
(9,'Vikas','Delhi'),
(10,'Sneha','Bangalore'),
(11,'Arjun','Mumbai'),
(12,'Meena','Pune'),
(13,'Rahul','Delhi'),
(14,'Pooja','Mumbai'),
(15,'Nikhil','Bangalore'),
(16,'Kavita','Delhi'),
(17,'Deepak','Mumbai'),
(18,'Sonal','Pune'),
(19,'Manish','Delhi'),
(20,'Tina','Mumbai');

INSERT INTO Bank_Accounts VALUES
(101,1,'Savings',50000),
(102,2,'Current',60000),
(103,3,'Savings',40000),
(104,4,'Savings',70000),
(105,5,'Current',30000),
(106,6,'Savings',80000),
(107,7,'Savings',45000),
(108,8,'Current',90000),
(109,9,'Savings',55000),
(110,10,'Savings',65000),
(111,11,'Current',50000),
(112,12,'Savings',60000),
(113,13,'Savings',70000),
(114,14,'Current',75000),
(115,15,'Savings',85000),
(116,16,'Savings',30000),
(117,17,'Current',40000),
(118,18,'Savings',50000),
(119,19,'Savings',60000),
(120,20,'Current',70000);

INSERT INTO Bank_Transactions VALUES
(1,101,'2023-01-01','credit',10000),
(2,101,'2023-01-03','debit',5000),
(3,102,'2023-01-02','credit',15000),
(4,102,'2023-01-05','debit',7000),
(5,103,'2023-01-04','credit',8000),
(6,103,'2023-01-06','debit',2000),
(7,104,'2023-01-01','credit',20000),
(8,104,'2023-01-07','debit',10000),
(9,105,'2023-01-03','credit',5000),
(10,105,'2023-01-08','debit',3000),
(11,106,'2023-01-02','credit',25000),
(12,106,'2023-01-09','debit',12000),
(13,107,'2023-01-04','credit',7000),
(14,107,'2023-01-10','debit',4000),
(15,108,'2023-01-05','credit',30000),
(16,108,'2023-01-11','debit',15000),
(17,109,'2023-01-06','credit',9000),
(18,109,'2023-01-12','debit',5000),
(19,110,'2023-01-07','credit',11000),
(20,110,'2023-01-13','debit',6000),
(21,101,'2023-01-10','credit',4000),
(22,101,'2023-01-12','debit',2000),
(23,102,'2023-01-11','credit',6000),
(24,102,'2023-01-13','debit',3000),
(25,103,'2023-01-14','credit',5000);


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Relational Database Merges & Balance Inquiries
-- ================================================================
-- Q21. Find total balance per customer.
SELECT a.cust_id, c.cust_name, SUM(a.balance) AS total_balance
FROM Bank_Accounts a
JOIN Bank_Customers c ON a.cust_id = c.cust_id
GROUP BY a.cust_id, c.cust_name;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Multi-Account Type Flags (HAVING Evaluators)
-- ================================================================
-- Q22. List customers having more than one account type.
SELECT c.cust_name, a.cust_id, COUNT(a.account_type) AS Acc
FROM Bank_Accounts a
JOIN Bank_Customers c ON a.cust_id = c.cust_id
GROUP BY a.cust_id, c.cust_name
HAVING COUNT(a.account_type) > 1;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Conditional Matrix Generation (CASE WHEN Structures)
-- ================================================================
-- Q23. Find total credit and debit amount per account.
SELECT account_id,
       SUM(CASE WHEN txn_type = 'credit' THEN amount ELSE 0 END) AS Credit_Amount,
       SUM(CASE WHEN txn_type = 'debit' THEN amount ELSE 0 END) AS Debit_Amount
FROM Bank_Transactions
GROUP BY account_id;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Three-Table Complex Inner Jumps
-- ================================================================
-- Q24. Find customers whose total transaction amount exceeds 20,000.
SELECT c.cust_id, c.cust_name, SUM(t.amount) AS Total_Txn
FROM Bank_Accounts a
JOIN Bank_Customers c ON a.cust_id = c.cust_id
JOIN Bank_Transactions t ON a.account_id = t.account_id
GROUP BY c.cust_id, c.cust_name
HAVING SUM(t.amount) > 20000;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Time Boundaries (MAX Tracking per Account)
-- ================================================================
-- Q25. Find the latest transaction for each account.
SELECT account_id, MAX(txn_date) AS Latest_Transaction
FROM Bank_Transactions
GROUP BY account_id;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Conditional Counts & Filtering via Aggregations
-- ================================================================
-- Q26. Find accounts with no debit transactions.
SELECT account_id
FROM Bank_Transactions
GROUP BY account_id
HAVING SUM(CASE WHEN txn_type = 'debit' THEN 1 ELSE 0 END) = 0;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Dynamic Signed Totals & Running Balances
-- ================================================================
-- Q27. Calculate running balance per account.
SELECT *,
       SUM(OG_Amount) OVER (PARTITION BY account_id ORDER BY txn_date) AS Running_balance
FROM (
    SELECT account_id, txn_date, txn_type, amount,
           CASE WHEN txn_type = 'debit' THEN -amount
                WHEN txn_type = 'credit' THEN amount
                ELSE amount
           END AS OG_Amount
    FROM Bank_Transactions
) a;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Transaction Delta Shifts (Self-Referential Windowing)
-- ================================================================
-- Q28. Find difference between current and previous transaction amount.
SELECT account_id, txn_date, amount,
       LAG(amount) OVER (PARTITION BY account_id ORDER BY txn_date) AS Pre_amount,
       amount - (LAG(amount) OVER (PARTITION BY account_id ORDER BY txn_date)) AS Pre_Amount_diff
FROM Bank_Transactions;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Multi-row Gap Identifiers
-- ================================================================
-- Q29. Detect consecutive transactions.
SELECT *
FROM (
    SELECT account_id, txn_date,
           LAG(txn_date) OVER (PARTITION BY account_id ORDER BY txn_date) AS Pre_dates
    FROM Bank_Transactions
) a
WHERE DATEDIFF(day, Pre_dates, txn_date) = 1;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Inline Sort Orders using Global Window Ranks
-- ================================================================
-- Q30. Rank customers based on total balance.
SELECT c.cust_id, c.cust_name, a.balance,
       RANK() OVER (ORDER BY a.balance DESC) AS Ranking
FROM Bank_Customers c
JOIN Bank_Accounts a ON c.cust_id = a.cust_id;


/*
***********************************************************************
***********************************************************************
   DATASET 4: FOOD DELIVERY APPLICATION
***********************************************************************
***********************************************************************
*/

-- 1. DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Food_Orders;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS App_Users;

-- 2. CREATE TABLES
CREATE TABLE App_Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Food_Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    order_date DATE,
    amount INT
);

-- 3. INSERT MOCK DATA
INSERT INTO App_Users VALUES
(1,'Amit','Mumbai'),
(2,'Neha','Delhi'),
(3,'Raj','Pune'),
(4,'Priya','Mumbai'),
(5,'Karan','Delhi'),
(6,'Simran','Bangalore'),
(7,'Rohit','Pune'),
(8,'Anjali','Mumbai'),
(9,'Vikas','Delhi'),
(10,'Sneha','Bangalore'),
(11,'Arjun','Mumbai'),
(12,'Meena','Pune'),
(13,'Rahul','Delhi'),
(14,'Pooja','Mumbai'),
(15,'Nikhil','Bangalore'),
(16,'Kavita','Delhi'),
(17,'Deepak','Mumbai'),
(18,'Sonal','Pune'),
(19,'Manish','Delhi'),
(20,'Tina','Mumbai');

INSERT INTO Restaurants VALUES
(1,'Dominos','Mumbai'),
(2,'KFC','Delhi'),
(3,'BurgerKing','Pune'),
(4,'Subway','Mumbai'),
(5,'PizzaHut','Delhi'),
(6,'McDonalds','Bangalore'),
(7,'BarbequeNation','Pune'),
(8,'Haldirams','Mumbai'),
(9,'Bikanervala','Delhi'),
(10,'WowMomos','Bangalore');

INSERT INTO Food_Orders VALUES
(1,1,1,'2023-01-01',500),
(2,2,2,'2023-01-02',700),
(3,3,3,'2023-01-03',400),
(4,1,4,'2023-01-04',800),
(5,5,5,'2023-01-05',200),
(6,6,6,'2023-01-06',900),
(7,7,7,'2023-01-07',300),
(8,8,8,'2023-01-08',1000),
(9,9,9,'2023-01-09',600),
(10,10,10,'2023-01-10',750),
(11,11,1,'2023-01-11',500),
(12,12,3,'2023-01-12',650),
(13,13,5,'2023-01-13',700),
(14,14,4,'2023-01-14',850),
(15,15,6,'2023-01-15',950),
(16,16,2,'2023-01-16',300),
(17,17,8,'2023-01-17',400),
(18,18,7,'2023-01-18',550),
(19,19,9,'2023-01-19',600),
(20,20,1,'2023-01-20',700),
(21,1,2,'2023-01-21',650),
(22,2,3,'2023-01-22',800),
(23,3,4,'2023-01-23',450),
(24,4,5,'2023-01-24',900),
(25,5,6,'2023-01-25',350);


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Frequency Tracking via COUNT Transactions
-- ================================================================
-- Q31. Find total orders per user.
SELECT user_id, COUNT(*) AS Total_count
FROM Food_Orders
GROUP BY user_id;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Financial Revenue Consolidation (SUM Descents)
-- ================================================================
-- Q32. Find total revenue per restaurant.
SELECT r.restaurant_name, fo.restaurant_id, SUM(fo.amount) AS total_revenue
FROM Food_Orders fo
JOIN Restaurants r ON fo.restaurant_id = r.restaurant_id
GROUP BY fo.restaurant_id, r.restaurant_name
ORDER BY SUM(fo.amount) DESC;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Cardinality Discrepancy Scans (COUNT DISTINCT Evaluators)
-- ================================================================
-- Q33. Find users who ordered from more than 2 restaurants.
SELECT au.user_name, fo.user_id, COUNT(DISTINCT fo.restaurant_id) AS Count_Restaurants
FROM Food_Orders fo
JOIN App_Users au ON fo.user_id = au.user_id
GROUP BY fo.user_id, au.user_name
HAVING COUNT(DISTINCT fo.restaurant_id) > 2;



-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Volume Threshold Scans (Top Operational Volume)
-- ================================================================
-- Q34. Find most popular restaurant.
SELECT TOP 1 r.restaurant_name, fo.restaurant_id, COUNT(fo.order_id) AS Count_orders
FROM Food_Orders fo
JOIN Restaurants r ON fo.restaurant_id = r.restaurant_id
GROUP BY fo.restaurant_id, r.restaurant_name
ORDER BY COUNT(fo.order_id) DESC;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Numeric Limit Filters inside Virtual Sub-Inquiries
-- ================================================================
-- Q35. Find top 3 highest spending users.
SELECT *
FROM (
    SELECT user_id, SUM(amount) AS total_amount,
           RANK() OVER (ORDER BY SUM(amount) DESC) AS Ranking
    FROM Food_Orders
    GROUP BY user_id
) a
WHERE Ranking < 4;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Outer Join Audits (Null Target Matching)
-- ================================================================
-- Q36. Find users who never ordered food.
SELECT u.user_name
FROM App_Users u
LEFT JOIN Food_Orders o ON u.user_id = o.user_id
WHERE o.restaurant_id IS NULL;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Regional Metrics (Partitioned Geographic Rankings)
-- ================================================================
-- Q37. Rank restaurants within each city based on revenue.
SELECT city, Total_revenue, restaurant_name,
       RANK() OVER (PARTITION BY city ORDER BY Total_revenue DESC) AS Ranking
FROM (
    SELECT a.city, SUM(o.amount) AS Total_revenue, r.restaurant_name
    FROM Food_Orders o
    JOIN App_Users a ON o.user_id = a.user_id
    JOIN Restaurants r ON o.restaurant_id = r.restaurant_id
    GROUP BY a.city, r.restaurant_name
) a;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Cohort Timelines (Chronological Boundaries)
-- ================================================================
-- Q38. Find first order per user.
SELECT u.user_name, MIN(o.order_date) AS first_order
FROM Food_Orders o
JOIN App_Users u ON o.user_id = u.user_id
GROUP BY u.user_name;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Chronological Sequence Maps (Consequential Intervals)
-- ================================================================
-- Q39. Find users who ordered on consecutive days.
SELECT *
FROM (
    SELECT user_id, order_date,
           LAG(order_date) OVER (PARTITION BY user_id ORDER BY order_date) AS Pre_date
    FROM Food_Orders
) a
WHERE DATEDIFF(day, Pre_date, order_date) = 1;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Transaction Accumulations (Progressive Series Windows)
-- ================================================================
-- Q40. Find running total of spending per user.
SELECT user_id, amount,
       SUM(amount) OVER (PARTITION BY user_id ORDER BY order_date) AS running_total
FROM Food_Orders;


/*
***********************************************************************
***********************************************************************
   DATASET 5: SUBSCRIPTION PLATFORM
***********************************************************************
***********************************************************************
*/

-- 1. DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS Users_Sub;

-- 2. CREATE TABLES
CREATE TABLE Users_Sub (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Subscriptions (
    sub_id INT PRIMARY KEY,
    user_id INT,
    start_date DATE,
    end_date DATE,
    plan_type VARCHAR(20)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    user_id INT,
    payment_date DATE,
    amount INT
);

-- 3. INSERT MOCK DATA
INSERT INTO Users_Sub VALUES
(1,'Amit','2023-01-01'),
(2,'Neha','2023-01-02'),
(3,'Raj','2023-01-03'),
(4,'Priya','2023-01-04'),
(5,'Karan','2023-01-05'),
(6,'Simran','2023-01-06'),
(7,'Rohit','2023-01-07'),
(8,'Anjali','2023-01-08'),
(9,'Vikas','2023-01-09'),
(10,'Sneha','2023-01-10'),
(11,'Arjun','2023-01-11'),
(12,'Meena','2023-01-12'),
(13,'Rahul','2023-01-13'),
(14,'Pooja','2023-01-14'),
(15,'Nikhil','2023-01-15'),
(16,'Kavita','2023-01-16'),
(17,'Deepak','2023-01-17'),
(18,'Sonal','2023-01-18'),
(19,'Manish','2023-01-19'),
(20,'Tina','2023-01-20');

INSERT INTO Subscriptions VALUES
(1,1,'2023-01-01','2023-01-31','Basic'),
(2,1,'2023-02-01','2023-02-28','Premium'),
(3,2,'2023-01-02','2023-01-31','Basic'),
(4,3,'2023-01-03','2023-01-20','Basic'),
(5,3,'2023-01-21','2023-02-15','Premium'),
(6,4,'2023-01-04','2023-01-25','Basic'),
(7,5,'2023-01-05','2023-01-30','Premium'),
(8,6,'2023-01-06','2023-01-31','Basic'),
(9,7,'2023-01-07','2023-01-31','Basic'),
(10,8,'2023-01-08','2023-01-20','Basic'),
(11,8,'2023-01-21','2023-02-10','Premium'),
(12,9,'2023-01-09','2023-01-31','Basic'),
(13,10,'2023-01-10','2023-01-25','Premium'),
(14,11,'2023-01-11','2023-01-31','Basic'),
(15,12,'2023-01-12','2023-01-31','Basic'),
(16,13,'2023-01-13','2023-01-31','Premium'),
(17,14,'2023-01-14','2023-01-31','Basic'),
(18,15,'2023-01-15','2023-01-31','Premium'),
(19,16,'2023-01-16','2023-01-31','Basic'),
(20,17,'2023-01-17','2023-01-31','Basic'),
(21,18,'2023-01-18','2023-01-31','Premium'),
(22,19,'2023-01-19','2023-01-31','Basic'),
(23,20,'2023-01-20','2023-01-31','Premium');

INSERT INTO Payments VALUES
(1,1,'2023-01-01',100),
(2,1,'2023-02-01',200),
(3,2,'2023-01-02',100),
(4,3,'2023-01-03',100),
(5,3,'2023-01-21',200),
(6,4,'2023-01-04',100),
(7,5,'2023-01-05',200),
(8,6,'2023-01-06',100),
(9,7,'2023-01-07',100),
(10,8,'2023-01-08',100),
(11,8,'2023-01-21',200),
(12,9,'2023-01-09',100),
(13,10,'2023-01-10',200),
(14,11,'2023-01-11',100),
(15,12,'2023-01-12',100),
(16,13,'2023-01-13',200),
(17,14,'2023-01-14',100),
(18,15,'2023-01-15',200),
(19,16,'2023-01-16',100),
(20,17,'2023-01-17',100),
(21,18,'2023-01-18',200),
(22,19,'2023-01-19',100),
(23,20,'2023-01-20',200),
(24,1,'2023-03-01',200),
(25,3,'2023-02-20',200);


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Future Value Evaluation (LEAD Analytic Functions)
-- ================================================================
-- Q41. Find users who upgraded from Basic to Premium.
SELECT user_id, start_date, end_date, plan_type, lead_plan
FROM (
    SELECT user_id, start_date, end_date, plan_type,
           LEAD(plan_type) OVER (PARTITION BY user_id ORDER BY end_date) AS lead_plan
    FROM Subscriptions
) a
WHERE plan_type = 'Basic' AND lead_plan = 'Premium';


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Content Continuances & Zero-Gap Boundary Scans
-- ================================================================
-- Q42. Find users with continuous subscriptions.
SELECT user_id, start_date, end_date, lag_date, day_diff
FROM (
    SELECT user_id, start_date, end_date,
           LAG(end_date) OVER (PARTITION BY user_id ORDER BY start_date) AS lag_date,
           DATEDIFF(day, LAG(end_date) OVER (PARTITION BY user_id ORDER BY start_date), start_date) AS day_diff
    FROM Subscriptions
) a
WHERE day_diff <= 1;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Yield & Gross Platforms Consolidation
-- ================================================================
-- Q43. Find total revenue per user.
SELECT user_id, SUM(amount) AS Total_revenue
FROM Payments
GROUP BY user_id;


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Frequency Group Metrics with Limit Filters
-- ================================================================
-- Q44. Find users who made more than 2 payments.
SELECT user_id, COUNT(payment_id) AS Payment_count
FROM Payments
GROUP BY user_id
HAVING COUNT(payment_id) > 2;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Platform Churn Logic via Current Server Clocks
-- ================================================================
-- Q45. Find churned users.
WITH CTE_Renew AS (
    SELECT user_id, start_date, end_date,
           LEAD(start_date) OVER (PARTITION BY user_id ORDER BY start_date) AS Lead_dates
    FROM Subscriptions 
)
SELECT DISTINCT user_id
FROM CTE_Renew
WHERE Lead_dates IS NULL AND end_date < GETDATE();


-- ================================================================
-- LEVEL: Easy
-- CONCEPT: Aggregate Volumetric Group Tracking
-- ================================================================
-- Q46. Find users who have more than one subscription.
SELECT user_id, COUNT(*) AS Subscription_count
FROM Subscriptions
GROUP BY user_id
HAVING COUNT(*) > 1;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Data Integrity & Chronological Collision Detection
-- ================================================================
-- Q47. Find overlapping subscriptions.
SELECT DISTINCT user_id
FROM (
    SELECT user_id, start_date, end_date,
           LAG(end_date) OVER (PARTITION BY user_id ORDER BY start_date) AS prev_end_date
    FROM Subscriptions
) a
WHERE start_date <= prev_end_date;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Latest State Assignment via ROW_NUMBER Partitioning
-- ================================================================
-- Q48. Find the latest subscription plan for each user.
SELECT user_id, start_date, plan_type
FROM (
    SELECT user_id, start_date, plan_type,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY start_date DESC) AS Ranking
    FROM Subscriptions
) a
WHERE Ranking = 1;


-- ================================================================
-- LEVEL: Advanced
-- CONCEPT: Running Value Aggregations Over Time Matrix
-- ================================================================
-- Q49. Calculate running revenue per user.
SELECT user_id, amount,
       SUM(amount) OVER (PARTITION BY user_id ORDER BY payment_date) AS running_revenue
FROM Payments;


-- ================================================================
-- LEVEL: Intermediate
-- CONCEPT: Exclusion Logic using Left Joins & Orphans Checks
-- ================================================================
-- Q50. Find users who have made payments but do not have any subscription.
SELECT DISTINCT p.user_id
FROM Payments p
LEFT JOIN Subscriptions s ON p.user_id = s.user_id
WHERE s.user_id IS NULL;