 🛒 SQL E-Commerce Analytics Project

📌 Project Overview

This project analyzes an e-commerce sales dataset using SQL to extract meaningful business insights.
The goal of the project is to demonstrate how SQL can be used to answer real business questions such as customer behavior, revenue trends, and product performance.

The dataset contains information about customers, orders, products, and order items.


 🗂️ Database Schema

The database consists of four main tables:

* **customers** – stores customer information
* **products** – contains product details and categories
* **orders** – records order transactions
* **order_items** – stores product level details for each order

Relationship structure:

Customers → Orders → Order_Items → Products


 📊 Business Questions Solved

This project answers several key business questions:

1. What is the **total revenue generated** by the company?
2. Which **customers contribute the most revenue**?
3. What are the **best selling products in each category**?
4. What is the **monthly revenue trend**?
5. How much **revenue is lost due to discounts**?
6. What is the **customer repeat purchase rate**?

🧠 SQL Concepts Used

The project demonstrates multiple SQL techniques including:

* Joins
* Aggregations (SUM, COUNT)
* GROUP BY
* Common Table Expressions (CTE)
* Window Functions (ROW_NUMBER, RANK)
* Date functions
* Business metric calculations

📁 Project Structure

SQL-Ecommerce-Analytics

schema.sql
dataset.sql
analysis_queries.sql
README.md

**schema.sql** → database structure
**dataset.sql** → sample data inserts
**analysis_queries.sql** → business analysis queries

📈 Example Analysis

Example: Finding the top selling product in each category using CTE and window functions.


WITH product_sales AS (
SELECT
p.category,
p.product_name,
SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category, p.product_name
)

SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY category ORDER BY total_sold DESC) AS rank_num
FROM product_sales
) t
WHERE rank_num = 1;

🛠️ Tools Used

* MySQL
* SQL
* Git
* GitHub

🎯 Key Learnings

Through this project I practiced:

* Designing relational database schemas
* Writing analytical SQL queries
* Solving business problems using data
* Organizing SQL projects for version control using GitHub

👤 Author
Gaurav Rai
Data Analyst / Data Engineer interested in data analytics, SQL, and data pipelines.
