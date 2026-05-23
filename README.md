# SQL 50 Questions Marathon 🏃‍♂️💨

A comprehensive SQL practice repository containing 50 real-world business scenario questions with solutions using structured datasets and analytical SQL queries.

This project focuses on strengthening SQL problem-solving skills through practical case studies covering data analysis, reporting, ranking, window functions, transaction analysis, and business insights.

---
## 📌 Table of Contents
- <a href="Project Overview">Project Overview</a>
- <a href="SQL Difficulty Levels">SQL Difficulty Levels</a>
- <a href="Datasets & Question Index">Datasets & Question Index</a>
- <a href="Complete Marathon File">Complete Marathon File</a>
- <a href="SQL Concepts Demonstrated">SQL Concepts Demonstrated</a>
- <a href="Repository Structure">Repository Structure</a>
- <a href="Tools Used">Tools Used</a>
- <a href="Author & Contact">Author & Contact</a>

## <a class="anchor" id="Project Overview"></a>>📌 Project Overview

This repository includes:
* **50 SQL Questions with Solutions** across various business domains.
* **5 Real-World Business Datasets** built from scratch.
* **Beginner to Advanced SQL Problems** categorized by complexity.
* **Business Scenario-Based Querying** focusing on operational KPIs.
* **Window Functions & CTEs** for complex data engineering tasks.
* **Ranking & Analytical Queries** for performance metrics.
* **Churn & Gap Analysis** simulating real-world user behavior.

The project is designed to simulate real business use cases commonly encountered in **Data Analyst**, **SQL Developer**, and **Business Intelligence** roles.

---

## <a class="anchor" id="SQL Difficulty Levels"></a>>📊 SQL Difficulty Levels

### 🟢 Easy Level
* **Topics:** `SELECT`, `WHERE` Clauses, `ORDER BY`, `GROUP BY`, `HAVING`, Aggregate Functions, Basic `JOINS`.
* **Questions:** Q1 to Q8, Q11 to Q16, Q20 to Q26, Q31 to Q36.

### 🟡 Intermediate Level
* **Topics:** Subqueries, CTEs (Common Table Expressions), Self Joins, Conditional Aggregation, Multi-table Analysis, Ranking Functions.
* **Questions:** Q9 to Q10, Q17 to Q19, Q27 to Q30, Q37 to Q40, Q41 to Q46.

### 🔴 Advanced Level
* **Topics:** Window Functions (`RANK()`, `ROW_NUMBER()`, `LAG()`, `LEAD()`), Running Totals, Gap Analysis, Churn Analysis, Consecutive Date Tracking.
* **Questions:** Q47 to Q50.

---

## <a class="anchor" id="Datasets & Question Index"></a>💾 Datasets & Question Index

### 🏢 Dataset 1 — Employees & Departments
* **Tables:** 
  * `Departments` (dept_id, dept_name, location)
  * `Employees` (emp_id, name, salary, hire_date, manager_id, dept_id)

<details>
<summary><b>View Dataset 1 Questions (Q1 - Q10)</b></summary>

* **Q1.** Find all employees working in the IT department.
* **Q2.** List employees hired after 2020.
* **Q3.** Count employees in each department.
* **Q4.** Find average salary per department.
* **Q5.** Find employees earning more than the average salary of their department.
* **Q6.** List employees along with their manager names.
* **Q7.** Find departments with more than 4 employees.
* **Q8.** Get top 3 highest paid employees.
* **Q9.** Find the second highest salary in the company.
* **Q10.** Rank employees within each department based on salary.
</details>

**Solutions:** [🔗 View T-SQL Answers](Dataset%201%20—%20Employees%20&%20Departments.sql)

### 🛒 Dataset 2 — Customers & Orders
* **Tables:** 
  * `Customers` (customer_id, customer_name, city)
  * `Orders` (order_id, customer_id, order_date, order_amount)

<details>
<summary><b>View Dataset 2 Questions (Q11 - Q20)</b></summary>

* **Q11.** Find total order amount per customer.
* **Q12.** Find customers who never placed orders.
* **Q13.** Get top 5 customers by total spending.
* **Q14.** Find customers with more than 2 orders.
* **Q15.** Find highest order amount per city.
* **Q16.** Find daily total sales.
* **Q17.** Get customers whose total spending is above average.
* **Q18.** Find consecutive order dates.
* **Q19.** Rank customers by spending.
* **Q20.** Find first order date per customer.
</details>

**Solutions:** [🔗 View T-SQL Answers](Dataset%202%20—%20Customers%20&%20Orders.SQL)

### 🏦 Dataset 3 — Banking System
* **Tables:** 
  * `Bank_Customers` (customer_id, name, join_date)
  * `Bank_Accounts` (account_id, customer_id, account_type, balance)
  * `Bank_Transactions` (transaction_id, account_id, transaction_type, amount, transaction_date)

<details>
<summary><b>View Dataset 3 Questions (Q21 - Q30)</b></summary>

* **Q21.** Find total balance per customer.
* **Q22.** List customers having more than one account type.
* **Q23.** Find total credit and debit amount per account.
* **Q24.** Find customers whose total transaction amount exceeds 20,000.
* **Q25.** Find the latest transaction for each account.
* **Q26.** Find accounts with no debit transactions.
* **Q27.** Calculate running balance per account.
* **Q28.** Find difference between current and previous transaction amount.
* **Q29.** Detect consecutive transactions.
* **Q30.** Rank customers based on total balance.
</details>

**Solutions:** [🔗 View T-SQL Answers](Dataset%203%20—%20Banking%20System.sql)

### 🛵 Dataset 4 — Food Delivery Application
* **Tables:** 
  * `App_Users` (user_id, name, city)
  * `Restaurants` (restaurant_id, name, city, cuisine)
  * `Food_Orders` (order_id, user_id, restaurant_id, order_amount, order_date)

<details>
<summary><b>View Dataset 4 Questions (Q31 - Q40)</b></summary>

* **Q31.** Find total orders per user.
* **Q32.** Find total revenue per restaurant.
* **Q33.** Find users who ordered from more than 2 restaurants.
* **Q34.** Find most popular restaurant.
* **Q35.** Find top 3 highest spending users.
* **Q36.** Find users who never ordered food.
* **Q37.** Rank restaurants within each city based on revenue.
* **Q38.** Find first order per user.
* **Q39.** Find users who ordered on consecutive days.
* **Q40.** Find running total of spending per user.
</details>

**Solutions:** [🔗 View T-SQL Answers](Dataset%204%20—%20Food%20Delivery%20Application.sql)

### 📺 Dataset 5 — Subscription Platform
* **Tables:** 
  * `Users_Sub` (user_id, name, email)
  * `Subscriptions` (subscription_id, user_id, plan_name, start_date, end_date)
  * `Payments` (payment_id, user_id, amount, payment_date)

<details>
<summary><b>View Dataset 5 Questions (Q41 - Q50)</b></summary>

* **Q41.** Find users who upgraded from Basic to Premium.
* **Q42.** Find users with continuous subscriptions.
* **Q43.** Find total revenue per user.
* **Q44.** Find users who made more than 2 payments.
* **Q45.** Find churned users.
* **Q46.** Find users who have more than one subscription.
* **Q47.** Find overlapping subscriptions.
* **Q48.** Find the latest subscription plan for each user.
* **Q49.** Calculate running revenue per user.
* **Q50.** Find users who have made payments but do not have any subscription.
</details>

**Solutions:** [🔗 View T-SQL Answers](Dataset%205%20—%20Subscription%20Platform.sql)

## <a class="anchor" id="Complete Marathon File"></a> 🚀 Complete Marathon File

* [📥 View Complete 50 SQL Questions & Solutions with datasets](50_questions_marathon.sql)

---

## <a class="anchor" id="SQL Concepts Demonstrated"></a>💡 SQL Concepts Demonstrated

* **Querying & Filtering:** `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`
* **Aggregation:** `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
* **Joins:** `INNER JOIN`, `LEFT JOIN`, `SELF JOIN`
* **Intermediate SQL:** Subqueries, CTEs, `CASE WHEN` Statements
* **Window Functions:** `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`, `LEAD()`, Running Totals
* **Advanced Analytics:** Gap Analysis, Churn Detection, Consecutive Date Analysis, Revenue Funnels

---

## <a class="anchor" id="Repository Structure"></a>📂 Repository Structure

```bash
```sql-50-questions-marathon/
LocalRepo
│
├── README.md                                 # Project documentation & interactive question catalog
├── 50_questions_marathon.sql                 # Global master script containing all tables, mock data, and 50 solutions
│
├── Dataset 1 - Employees & Departments.sql   # Schema setup, mock data, and solutions for Questions 1-10
├── Dataset 2 - Customers & Orders.sql        # Schema setup, mock data, and solutions for Questions 11-20
├── Dataset 3 - Banking System.sql            # Schema setup, mock data, and solutions for Questions 21-30
├── Dataset 4 - Food Delivery Application.sql  # Schema setup, mock data, and solutions for Questions 31-40
└── Dataset 5 - Subscription Platform.sql     # Schema setup, mock data, and solutions for Questions 41-50
```
## <a class="anchor" id="Tools Used"></a>🛠️ Tools Used
- Database Engine: Microsoft SQL Server (T-SQL)
- Interface: SSMS (SQL Server Management Studio)
- GitHub

## <a class="anchor" id="Author & Contact">🧑‍💼 Author & Contact
<b>🧑‍💼 Vinod Badrinath</b>
Aspiring Data Analyst skilled in:
- SQL
- Power BI
- Data Analysis
- Business Intelligence

<b>🔗 Contact</b>
- ✉️ Email: bhaveshgurrap11@gmail.com
- 💼 [LinkedIn](http://linkedin.com/in/bhavesh-gurrap-024503213/)
