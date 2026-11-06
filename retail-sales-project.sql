--- SQL Retail Sales Analysis - P1
Create DATABASE sql_project_p2;

Create Table retail_sales (
transaction_Id INT PRIMARY KEY,
sale_date DATE ,
sale_time Time ,
customer_id INT,
gender VARCHAR(50),
age INT,
category VARCHAR(25),
quantity INT ,
price_per_unit FLOAT,
coge FLOAT,
total_sales FLOAT
);

SELECT * FROM retail_sales ;

SELECT COUNT(*) FROM retail_sales ;

--- Identify NUll values

SELECT * FROM retail_sales
WHERE Sale_time IS NULL

--- Multiple Condition Check 

SELECT * FROM retail_sales
WHERE Sale_time IS NULL 
OR sale_date IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR Quantity IS NULL
OR price_per_unit IS NULL
OR Coge IS NULL
OR total_sales IS NULL

DELETE FROM  retail_sales

WHERE Sale_time IS NULL 
OR sale_date IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR Quantity IS NULL
OR price_per_unit IS NULL
OR Coge IS NULL
OR total_sales IS NULL


-- Data Exploration
-- How Many sales we have ?

SELECT COUNT(*) AS Total_sales FROM retail_sales

-- How Many Unique Customers we have ?

SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problem & Answers

-- Q1. Write a SQL query a retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales 
WHERE Sale_date = '2022-11-05'

--- Q2. Write a SQL query to retrieve all transactions where the category i
-- "Clothing" and the quantity sold is more than 10 in every month on Nov-22.

SELECT *FROM retail_sales
WHERE category = 'Clothing'
	AND 
		TO_CHAR(sale_date,'yyyy-mm') = '2022-11'
    AND 
	Quantity >= 4

--- Q3. Write a SQL Query Calculate the total sales (total_sales ) for each category

SELECT category , SUM (total_sales ) AS net_sale,
COUNT (*) AS Total_orders
FROM retail_sales
GROUP BY 1

--- Q4. Write a SQL Query to Find the Avergae age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age)) AS Avg_age 
FROM retail_sales 
WHERE category = 'Beauty'

--- Q5. Write a SQL Query to find all transactions where the total_sales is greater than

SELECT * FROM retail_sales 
Where total_sales >1000

--- Q6. Write a Sql Query to find the total number of transactions (transaction_id ) made by each gender in each category

SELECT category , gender , COUNT (*) total_values
FROM retail_sales 
GROUP BY category, gender

--- Q7. Write a SQL Query to Calculate the average sale for each month , find out best selling month ineach year

SELECT year,
		month,
		AVG_sale
FROM
(
SELECT 
     EXTRACT (year FROM sale_date) As Year,
	 EXTRACT (month FROM sale_date) As Year,
	 AVG(total_sales) As avg_sale,
	 RANK () OVER (PARTITION BY EXTRACT (Year FROM sale_date )ORDER BY AVG(total_sale)DESC)AS Rank
FROM retail_Sales
GROUP BY 1, 2
) AS t1
WHERE rank = 1
)
--- Q8. Write a SQL Query to find top5 customers based on the highest total_sales

SELECT customer_id , sum(total_sales) As total_sales 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--- Q9. Write a SQL query to find the number of unique customers who purchased items from each Category.

SELECT COUNT(DISTINCT customer_id) AS unique , Category
FROM retail_sales 
GROUP BY Category 

--- Q10. Write a SQL Query to create each Shift and number of orders (E.g. Morining <=12, Afternoon 12 & 17 , Evening >17)

SELECT * , CASE 
      WHEN EXTRACT (HOUR FROM sale_time ) < 12 THEN 'Morning'
	  WHEN  EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	  ELSE 'Evening'
	  END AS shift
FROM retail_sales