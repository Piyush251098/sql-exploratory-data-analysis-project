/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/



CREATE VIEW gold.report_products AS

WITH base_query AS (
/* BASE QUERY
1. Retreiving core columns from tables
*/
SELECT 
    f.order_number,
    p.product_name,
    p.product_key,
    p.product_number,
    p.category, 
    p.subcategory,
    p.cost,
    f.sales_amount,
    f.order_date,
    f.quantity,
    f.customer_key 
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL)

, product_aggregation AS (
/*
2. Aggregates product level metrics
*/
SELECT
    product_key,
    product_name,
    category,
    cost,
    subcategory,
    SUM(customer_key) AS total_customers,
    COUNT(DISTINCT (order_number)) AS total_orders,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity_sold,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
    ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF (quantity,0)),1) AS avg_sales_price

FROM base_query
GROUP BY product_name, product_key, cost, category, subcategory, sales_amount, quantity)

SELECT 
/* 
 3. Final Query: Combines all product results into one output
*/
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_order_date,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency_in_months,
    CASE
        WHEN total_sales > 50000 THEN 'High-Performers'
        WHEN total_sales >= 10000 THEN 'Mid-range'
        ELSE 'Low-Performers'
    END AS product_segment,
    lifespan, 
    total_orders,
    total_quantity_sold,
    total_sales,
    total_customers,
    avg_sales_price,
    -- AVERAGE ORDER REVENUE
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders 
    END AS average_order_revenue,

    -- AVERAGE MONTHLY REVENUE
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS average_monthly_revenue
FROM product_aggregation



