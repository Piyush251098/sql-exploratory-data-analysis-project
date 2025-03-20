/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.
===============================================================================
*/

WITH categoy_sales AS(

SELECT
p.category,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
GROUP BY category
)

SELECT
category,
total_sales,
SUM(total_sales) OVER() overall_sales,
CONCAT(ROUND((CAST (total_sales AS FLOAT) /SUM(total_sales) OVER()) * 100, 2), '%') AS percent_total_sales
FROM categoy_sales
ORDER BY total_sales DESC