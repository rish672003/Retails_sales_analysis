select * from retails_sales;

select count(*) from retails_sales;

--DATA CLEANING
select * from retails_sales 
	WHERE 
	  transactions_id  is NULL
	  OR
	  sale_date is NULL
	  OR 
	  sale_time is NULL
	  OR
	  customer_id is NULL
	  OR 
	  gender is NULL
	  OR
	  age is NULL
	  OR
	  category is NULL
	  OR
	  quantiy is NULL
	  OR
	  price_per_unit is NULL
	  OR
	  cogs is NULL
	  OR
	  total_sale is NULL
	  ;



DELETE  FROM retails_sales
WHERE 
  transactions_id  is NULL
	  OR
	  sale_date is NULL
	  OR 
	  sale_time is NULL
	  OR
	  customer_id is NULL
	  OR 
	  gender is NULL
	  OR
	  age is NULL
	  OR
	  category is NULL
	  OR
	  quantiy is NULL
	  OR
	  price_per_unit is NULL
	  OR
	  cogs is NULL
	  OR
	  total_sale is NULL
	  ;


	  --DATA EXPLORATION



	  -- HOW MANY SALES WE HAVE
	  select COUNT(*) as total_sale from retails_sales;

	  --HOW MANY CUSTOMER WE HAVE
	 SELECT COUNT(DISTINCT customer_id )from retails_sales;

	 SELECT COUNT(DISTINCT category) AS total_sales FROM retails_sales;

--DATA ANALYSIS AND BUSINESS KEY PROBLEMS

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

	 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

   SELECT * FROM retails_sales WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

   
SELECT * FROM retails_sales
WHERE 
category = 'Clothing'
and 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' 
and
quantiy >= 4;



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each cate

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retails_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
	AVG(age) as avg_age
	from retails_sales
	where category = 'Beauty';




	SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retails_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select transactions_id from retails_sales where total_sale > 1000;

SELECT * FROM retails_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT count(transactions_id) , gender from retails_sales Group BY gender ; 

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retails_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;


	

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retails_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retails_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retails_sales
GROUP BY category



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retails_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- End of project








	  