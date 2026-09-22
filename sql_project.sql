/*
===============================================================================
                    SQL SALES & PRODUCT SUPPLIER ANALYSIS
===============================================================================

PROJECT TYPE:
Data Analysis using MySQL

DATA SOURCE:
Kaggle Dataset

DATABASE NAME:
sales_db

TABLES USED:
1. orders
2. product_supplier

===============================================================================
                            PROJECT OVERVIEW
===============================================================================

PROJECT DESCRIPTION:

This project focuses on analyzing sales and product supplier data using
MySQL. The objective is to explore customer purchasing behavior, product
performance, supplier contributions, revenue, estimated costs, profit,
and delivery trends.

The analysis uses SQL queries to transform raw business data into
meaningful information that can support business understanding and
decision-making.

===============================================================================
                         DATASET INFORMATION
===============================================================================

Database Name : sales_db

Table 1       : orders
Records       : 185,013

Table 2       : product_supplier
Records       : 5,504

===============================================================================
                         PROJECT OBJECTIVES
===============================================================================

1. Analyze total orders and customer activity.
2. Identify popular products and product categories.
3. Examine sales revenue and estimated profit.
4. Evaluate supplier performance and product portfolios.
5. Understand monthly and yearly sales trends.
6. Analyze order delivery times.
7. Identify high-spending customers.
8. Discover products that have not received any orders.
9. Compare customer statuses based on sales.
10. Generate meaningful business insights from the data.

===============================================================================
                       SQL ANALYSIS STRUCTURE
===============================================================================

SECTION 1  : Basic Data Exploration
SECTION 2  : Sales and Revenue Analysis
SECTION 3  : Customer Analysis
SECTION 4  : Product Performance Analysis
SECTION 5  : Sales Classification
SECTION 6  : Time-Based Sales Analysis
SECTION 7  : Delivery Performance Analysis
SECTION 8  : Supplier Analysis
SECTION 9  : Product and Supplier Joins
SECTION 10 : Advanced Analysis Using Subqueries
SECTION 11 : Estimated Cost and Profit Analysis
SECTION 12 : Business Insights and Findings
SECTION 13 : Final Conclusion

===============================================================================
                           START OF ANALYSIS
===============================================================================
*/

USE sales_db;


-- Q1. How many total order records are present?

SELECT COUNT(*) AS total_orders FROM orders;


-- Q2. How many unique customers have placed orders?

SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM orders;


-- Q3. How many unique products have been ordered?

SELECT COUNT(DISTINCT product_id) AS unique_products_ordered FROM orders;


-- Q4. What customer statuses are present?

SELECT DISTINCT customer_status FROM orders ORDER BY customer_status;


-- Q5. Show the first 20 orders.

SELECT * FROM orders LIMIT 20;


-- Q6. Which orders have quantity greater than 5?

SELECT order_id, customer_id, product_id, quantity_ordered
FROM orders
WHERE quantity_ordered > 5
ORDER BY quantity_ordered DESC;


-- Q7. Which orders have retail value greater than 1000?

SELECT order_id, customer_id, product_id, total_retail_price
FROM orders
WHERE total_retail_price > 1000
ORDER BY total_retail_price DESC;


 -- Q8. What are the 10 highest-value orders?

SELECT order_id, customer_id, product_id, quantity_ordered, total_retail_price
FROM orders
ORDER BY total_retail_price DESC
LIMIT 10;


--  Q9. What are the 10 lowest-value orders?

SELECT order_id, customer_id, product_id, total_retail_price
FROM orders
ORDER BY total_retail_price ASC
LIMIT 10;


-- Q10. What is the total quantity ordered?

SELECT SUM(quantity_ordered) AS total_quantity_ordered FROM orders;


-- Q11. What is the total retail sales value?

SELECT SUM(total_retail_price) AS total_sales FROM orders;


-- Q12. What is the average order value?

SELECT AVG(total_retail_price) AS average_order_value FROM orders;


-- Q13. What is the highest order value?

SELECT MAX(total_retail_price) AS highest_order_value FROM orders;


-- Q14. What is the lowest order value?

SELECT MIN(total_retail_price) AS lowest_order_value FROM orders;


-- Q15. How many orders are placed by each customer status?

SELECT customer_status, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_status
ORDER BY total_orders DESC;


-- Q16. What is total sales by customer status?

SELECT customer_status, SUM(total_retail_price) AS total_sales
FROM orders
GROUP BY customer_status
ORDER BY total_sales DESC;


-- Q17. What is average order value by customer status?

SELECT customer_status, AVG(total_retail_price) AS average_order_value
FROM orders
GROUP BY customer_status
ORDER BY average_order_value DESC;


-- Q18. What is total quantity ordered for each product?

SELECT product_id, SUM(quantity_ordered) AS total_quantity
FROM orders
GROUP BY product_id
ORDER BY total_quantity DESC;


-- Q19. What are the top 10 products by sales revenue?

SELECT product_id, SUM(total_retail_price) AS total_sales
FROM orders
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;


-- Q20. Which products have more than 100 order records?

SELECT product_id, COUNT(*) AS order_count
FROM orders
GROUP BY product_id
HAVING COUNT(*) > 100
ORDER BY order_count DESC;


-- Q21. How can orders be classified by retail value?

SELECT order_id, total_retail_price,
CASE
    WHEN total_retail_price < 100 THEN 'Low Value'
    WHEN total_retail_price < 500 THEN 'Medium Value'
    ELSE 'High Value'
END AS order_value_category
FROM orders;


/* Q22. How can orders be classified by quantity?
CONCEPT: CASE, BETWEEN */
SELECT order_id, quantity_ordered,
CASE
    WHEN quantity_ordered = 1 THEN 'Single Item'
    WHEN quantity_ordered BETWEEN 2 AND 5 THEN 'Small Order'
    ELSE 'Bulk Order'
END AS quantity_category
FROM orders;


-- Q23. How many orders fall into each retail-value category?

SELECT
CASE
    WHEN total_retail_price < 100 THEN 'Low Value'
    WHEN total_retail_price < 500 THEN 'Medium Value'
    ELSE 'High Value'
END AS order_value_category,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_value_category
ORDER BY total_orders DESC;


-- Q24. How can products be classified by total quantity sold?

SELECT product_id, SUM(quantity_ordered) AS total_quantity,
CASE
    WHEN SUM(quantity_ordered) >= 1000 THEN 'High Volume'
    WHEN SUM(quantity_ordered) >= 500 THEN 'Medium Volume'
    ELSE 'Low Volume'
END AS sales_volume_category
FROM orders
GROUP BY product_id
ORDER BY total_quantity DESC;


-- Q25. What is the earliest order date?

SELECT MIN(date_order_was_placed) AS first_order_date FROM orders;


-- Q26. What is the latest order date?

SELECT MAX(date_order_was_placed) AS latest_order_date FROM orders;


-- Q27. How many orders were placed in each year?

SELECT YEAR(date_order_was_placed) AS order_year, COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(date_order_was_placed)
ORDER BY order_year;


-- Q28. What are the monthly sales trends?

SELECT YEAR(date_order_was_placed) AS order_year,
       MONTH(date_order_was_placed) AS order_month,
       SUM(total_retail_price) AS total_sales
FROM orders
GROUP BY YEAR(date_order_was_placed), MONTH(date_order_was_placed)
ORDER BY order_year, order_month;


-- Q29. How many orders were placed each month?

SELECT YEAR(date_order_was_placed) AS order_year,
       MONTH(date_order_was_placed) AS order_month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(date_order_was_placed), MONTH(date_order_was_placed)
ORDER BY order_year, order_month;


-- Q30. What is the average delivery time in days?

SELECT AVG(DATEDIFF(delivery_date, date_order_was_placed)) AS average_delivery_days
FROM orders;


-- Q31. What is the maximum delivery time?

SELECT MAX(DATEDIFF(delivery_date, date_order_was_placed)) AS maximum_delivery_days
FROM orders;


-- Q32. What product categories are present?

SELECT DISTINCT product_category
FROM product_supplier
ORDER BY product_category;


-- Q33. How many products are present in each category?

SELECT product_category, COUNT(*) AS total_products
FROM product_supplier
GROUP BY product_category
ORDER BY total_products DESC;


-- Q34. How many products are associated with each supplier?

SELECT supplier_name, COUNT(*) AS product_count
FROM product_supplier
GROUP BY supplier_name
ORDER BY product_count DESC;


-- Q35. Which supplier countries have the most products?

SELECT supplier_country, COUNT(*) AS product_count
FROM product_supplier
GROUP BY supplier_country
ORDER BY product_count DESC;


-- Q36. How many products are present in each product line?

SELECT product_line, COUNT(*) AS product_count
FROM product_supplier
GROUP BY product_line
ORDER BY product_count DESC;


-- Q37. Can orders be combined with product names?

SELECT o.order_id, o.customer_id, o.product_id,
       p.product_name, o.quantity_ordered, o.total_retail_price
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id;


-- Q38. What is total sales by product category?

SELECT p.product_category,
       SUM(o.total_retail_price) AS total_sales
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_sales DESC;


-- Q39. What is total quantity sold by product category?

SELECT p.product_category,
       SUM(o.quantity_ordered) AS total_quantity
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_quantity DESC;


-- Q40. What are the top 10 products by revenue with names?

SELECT p.product_id, p.product_name,
       SUM(o.total_retail_price) AS total_revenue
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Q41. What is total sales generated by each supplier?

SELECT p.supplier_name,
       SUM(o.total_retail_price) AS total_sales
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.supplier_name
ORDER BY total_sales DESC;


-- Q42. What are the top 10 suppliers by sales?

SELECT p.supplier_name,
       SUM(o.total_retail_price) AS total_sales
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.supplier_name
ORDER BY total_sales DESC
LIMIT 10;


-- Q43. Which product categories generate more than 1,000,000 in sales?

SELECT p.product_category,
       SUM(o.total_retail_price) AS total_sales
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.product_category
HAVING SUM(o.total_retail_price) > 1000000
ORDER BY total_sales DESC;


-- Q44. Which suppliers have more than 10 products?

SELECT supplier_name, COUNT(*) AS product_count
FROM product_supplier
GROUP BY supplier_name
HAVING COUNT(*) > 10
ORDER BY product_count DESC;


-- Q45. Which products have total sales above average product sales?

SELECT product_id, SUM(total_retail_price) AS total_sales
FROM orders
GROUP BY product_id
HAVING SUM(total_retail_price) >
(
    SELECT AVG(product_sales)
    FROM
    (
        SELECT product_id, SUM(total_retail_price) AS product_sales
        FROM orders
        GROUP BY product_id
    ) AS product_summary
)
ORDER BY total_sales DESC;


-- Q46. Which customers have spending above average customer spending?

SELECT customer_id, SUM(total_retail_price) AS total_spending
FROM orders
GROUP BY customer_id
HAVING SUM(total_retail_price) >
(
    SELECT AVG(customer_spending)
    FROM
    (
        SELECT customer_id, SUM(total_retail_price) AS customer_spending
        FROM orders
        GROUP BY customer_id
    ) AS customer_summary
)
ORDER BY total_spending DESC;


-- Q47. Which product category has the highest average order value?

SELECT p.product_category,
       AVG(o.total_retail_price) AS average_order_value
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.product_category
ORDER BY average_order_value DESC
LIMIT 1;


-- Q48. Which products are in the catalog but have no orders?

SELECT p.product_id, p.product_name,
       p.product_category, p.supplier_name
FROM product_supplier AS p
LEFT JOIN orders AS o
    ON p.product_id = o.product_id
WHERE o.product_id IS NULL
ORDER BY p.product_name;


-- Q49. Who are the top 10 customers by total spending?

SELECT customer_id, SUM(total_retail_price) AS total_spending
FROM orders
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;


-- Q50. What are revenue, estimated cost and estimated profit by product?

SELECT product_id,
       SUM(total_retail_price) AS revenue,
       SUM(quantity_ordered * cost_price_per_unit) AS estimated_cost,
       SUM(total_retail_price)
       - SUM(quantity_ordered * cost_price_per_unit) AS estimated_profit
FROM orders
GROUP BY product_id
ORDER BY estimated_profit DESC;


-- Q51. What is estimated profit by product category?

SELECT p.product_category,
       SUM(o.total_retail_price) AS revenue,
       SUM(o.quantity_ordered * o.cost_price_per_unit) AS estimated_cost,
       SUM(o.total_retail_price)
       - SUM(o.quantity_ordered * o.cost_price_per_unit) AS estimated_profit
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id
GROUP BY p.product_category
ORDER BY estimated_profit DESC;


-- Q52. What is the overall estimated profit?

SELECT SUM(total_retail_price) AS total_revenue,
       SUM(quantity_ordered * cost_price_per_unit) AS total_estimated_cost,
       SUM(total_retail_price)
       - SUM(quantity_ordered * cost_price_per_unit) AS total_estimated_profit
FROM orders;


/* =========================================================
/*
===============================================================================
                   BUSINESS INSIGHTS & FINDINGS
===============================================================================

This section summarizes the major findings obtained from the SQL analysis.
The following insights are based on the results recorded in the project.

===============================================================================
INSIGHT 1: CUSTOMER STATUS AND SALES
===============================================================================

Finding:
Silver customer status generates the highest total sales of
12,884,922.29.

===============================================================================
INSIGHT 2: TOP 10 PRODUCTS BY REVENUE
===============================================================================

Finding:
The top revenue-generating products include:

1. Family Holiday 4
2. Hurricane 4
3. Family Holiday 6
4. Expedition Dome 3
5. Comfort Shelter
6. Big Guy Men's Air Tuned Sirocco Shoes
7. Lucky Tech Integral Wp/B Rain Pants
8. Weston F4 Men's Hockey Skates
9. Twain Women's Evolution 8.0 T Ski Boots
10. Basic 10, Left, Yellow/Black

===============================================================================
INSIGHT 3: HIGHEST-SELLING PRODUCT CATEGORY
===============================================================================

Finding:
Outdoors is the leading product category, with total sales of
5,688,483.11.

===============================================================================
INSIGHT 4: HIGHEST QUANTITY SOLD
===============================================================================

Finding:
Petanque Balls Chromium 8-pack is the most sold product by quantity,
with 1,700 units sold.

===============================================================================
INSIGHT 5: SUPPLIER SALES PERFORMANCE
===============================================================================

Finding:
Eclipse Inc generates the highest sales, amounting to 3,681,765.17.

===============================================================================
INSIGHT 6: LARGEST SUPPLIER PRODUCT PORTFOLIO
===============================================================================

Finding:
Eclipse Inc has the largest product portfolio, with 1,115 products.

===============================================================================
INSIGHT 7: MONTHLY SALES TRENDS
===============================================================================

Finding:
Highest sales:
December 2021 - 930,156.18

Lowest sales:
September 2017 - 210,577.34

===============================================================================
INSIGHT 8: DELIVERY PERFORMANCE
===============================================================================

Finding:
Average delivery time: 1.0568 days.

The recorded analysis identifies delivery times of approximately
25–30 days among orders taking longer than average.

Longest delivery time:
30 days

Order ID:
123352157

===============================================================================
INSIGHT 9: HIGHEST ESTIMATED PROFIT
===============================================================================

Finding:
Family Holiday 4 generates the highest estimated profit,
amounting to 282,460.50.

===============================================================================
INSIGHT 10: HIGH-SPENDING CUSTOMERS
===============================================================================

Finding:
Customer ID 7766 has recorded spending of 6,826.30,
which is identified in the project as above average.

===============================================================================
                    END OF BUSINESS INSIGHTS
===============================================================================
*/

/*
===============================================================================
                          PROJECT CONCLUSION
===============================================================================

CONCLUSION:

This SQL Sales and Product Supplier Analysis project demonstrates how
MySQL can be used to explore and analyze business data.

The analysis covers customer activity, product performance, supplier
contributions, sales revenue, estimated costs, profit, and delivery
trends.

The results identify important patterns, including differences in sales
across customer statuses, products, categories, and suppliers. The project
also examines customer spending behavior and delivery performance.

Through this project, practical experience was gained in writing SQL
queries, filtering and grouping data, joining tables, using aggregate
functions, applying conditional logic, and performing subquery-based
analysis.

Overall, this project demonstrates the use of SQL to convert structured
business data into useful information for reporting and business analysis.

===============================================================================
                         END OF SQL PROJECT
===============================================================================
*/