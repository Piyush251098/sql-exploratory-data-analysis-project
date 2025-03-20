WITH product_segment AS (
SELECT 
product_key,
product_name,
cost,
CASE when cost < 100 THEN 'Below 100'
    WHEN cost BETWEEN 100 and 500 THEN '100-500'
    WHEN cost BETWEEN 500 and 1000 THEN '500-1000' 
    ELSE 'Above 1000'
END as cost_range
FROM gold.dim_products)

SELECT 
cost_range,
COUNT(product_key) as total_products
FROM product_segment
Group by cost_range
ORDER BY total_products DESC