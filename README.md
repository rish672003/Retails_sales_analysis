# Retail Sales Analysis SQL Project

## Project Overview

**Project Title:** Retails_Sales_analysis  
**Level:** Beginner  `

This project demonstrates fundamental SQL skills through the exploration, cleaning, and analysis of retail sales data. The workflow includes setting up a database, performing exploratory data analysis (EDA), and addressing business questions via SQL queries.

---

## Objectives

- **Database Setup:** Build and populate a retail sales database.
- **Data Cleaning:** Identify and remove records with missing/null values.
- **Exploratory Data Analysis (EDA):** Understand the sales dataset.
- **Business Analysis:** Use SQL to answer business questions and derive insights.

## Project Structure

- `database_setup.sql` - SQL for creating and populating the database & table.
- `analysis_queries.sql` - SQL queries for EDA and business analysis.
---

## How to Use

1. **Clone the Repository**
    ```bash
    git clone https://github.com/YOUR-USERNAME/retail-sales-analysis-sql.git
    cd retails-sales-analysis-sql
    ```

2. **Set Up the Database**
    - Run the SQL script in `database_setup.sql` to create the database and table, then load your data.

3. **Run Analysis Queries**
    - Use the queries provided in `analysis_queries.sql` to perform EDA and business analysis.

4. **Explore & Modify**
    - Modify or extend the queries to explore more aspects of the dataset.
  
## Steps are given: 

-- Create Database
CREATE DATABASE p1_retail_db;

-- Use the database (depends on your SQL dialect, e.g., PostgreSQL/SQL Server: \c p1_retail_db)
-- USE p1_retail_db;

-- Create Table
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- INSERT INTO retail_sales (...) VALUES (...);
-- (Add your data loading script or instructions here)



-- Record Count
SELECT COUNT(*) FROM retail_sales;

-- Customer Count
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Category Count
SELECT DISTINCT category FROM retail_sales;

-- Null Value Check
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Remove Null Records
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;




-- 1. Sales on a specific date
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- 2. Clothing category, quantity >= 4, November 2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;

-- 3. Total sales per category
SELECT category, SUM(total_sale) as net_sale, COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- 4. Average age for 'Beauty' category purchasers
SELECT ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Transactions with total_sale > 1000
SELECT * FROM retail_sales WHERE total_sale > 1000;

-- 6. Transactions by gender and category
SELECT category, gender, COUNT(*) as total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- 7. Best selling month in each year (average sale)
SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
    FROM retail_sales
    GROUP BY year, month
) as t1
WHERE rank = 1;

-- 8. Top 5 customers by total sales
SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 9. Unique customers per category
SELECT category, COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- 10. Orders by shift (morning, afternoon, evening)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END as shift
    FROM retail_sales
)
SELECT shift, COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;



--End of this Project

