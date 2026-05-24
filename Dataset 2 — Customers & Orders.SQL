-- ====================================================================
-- PROJECT: SQL 50 Questions Marathon
-- DATASET 2 : Customers & Orders
-- AUTHOR: Bhavesh Gurrap
-- PLATFORM OPTIMIZATION: T-SQL (MS SQL Server / SSMS)
-- ====================================================================

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
