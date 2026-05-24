-- ====================================================================
-- PROJECT: SQL 50 Questions Marathon
-- DATASET 3 : Banking System
-- AUTHOR: Bhavesh Gurrap
-- PLATFORM OPTIMIZATION: T-SQL (MS SQL Server / SSMS)
-- ====================================================================

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