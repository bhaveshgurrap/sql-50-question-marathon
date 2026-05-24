-- ====================================================================
-- PROJECT: SQL 50 Questions Marathon
-- DATASET 4 : Food Delivery Application
-- AUTHOR: Bhavesh Gurrap
-- PLATFORM OPTIMIZATION: T-SQL (MS SQL Server / SSMS)
-- ====================================================================

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