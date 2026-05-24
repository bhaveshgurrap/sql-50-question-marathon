-- ====================================================================
-- PROJECT: SQL 50 Questions Marathon
-- DATASET 5 : Subscription Platform
-- AUTHOR: Bhavesh Gurrap
-- PLATFORM OPTIMIZATION: T-SQL (MS SQL Server / SSMS)
-- ====================================================================

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