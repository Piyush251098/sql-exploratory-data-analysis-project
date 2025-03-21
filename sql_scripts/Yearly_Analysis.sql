/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

WITH yearly_product_sales AS(
SELECT 
    YEAR(f.order_date) as order_year,
    p.product_name,
    SUM(f.sales_amount) as current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE f.order_date is NOT NULL
GROUP BY YEAR(f.order_date), p.product_name)

SELECT order_year, product_name, current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name) as avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) as diff_from_avg, 
    CASE
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Average'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Average'
        ELSE 'Average'
    END as Avg_comparison,
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) as previous_year_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) as diff_py,
        CASE
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN  'Decrease'
        ELSE 'NoChange'
    END as py_change
FROM yearly_product_sales
ORDER BY product_name, order_year