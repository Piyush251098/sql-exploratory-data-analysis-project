# sql-exploratory-data-analysis-project

## Overview
This project involves analyzing customer, product, and sales data using SQL. The dataset includes three main databases:
- **Customer Database**: Contains customer details such as names, ages, and transaction history.
- **Product Database**: Includes product information like names, categories, subcategories, and costs.
- **Sales Database**: Records sales transactions, including order details, sales amounts, and quantities.

# 📊 SQL Data Analysis Exploratory Project  
**Analyzing customer, product, and sales data to uncover actionable insights.**  

---

## 🧑💻 **Customer Analysis**  
**Purpose**: Profile customers by behavior, spending, and demographics.  
**Highlights**:  
- Segments customers into **VIP, Regular, or New** based on loyalty and spending.  
- Groups customers into **age brackets** (Under 20, 20-29, etc.) for demographic insights.  
- Tracks **recency** (months since last order) and **lifespan** (customer engagement duration).  
- Calculates **average order value** and **monthly spending trends**.  

---

## 🛍️ **Product Analysis**  
**Purpose**: Evaluate product performance and revenue drivers.  
**Highlights**:  
- Classifies products as **High-Performers, Mid-Range, or Low-Performers** by revenue.  
- Tracks **total sales**, **unique customers**, and **quantity sold** per product.  
- Computes **average monthly revenue** and **sales price trends**.  
- Identifies **product recency** (months since last sale).  

---

## 📅 **Date Range Exploration**  
**Purpose**: Understand dataset temporal boundaries.  
**Highlights**:  
- Identifies **first/last order dates** and total historical range in months.  
- Determines the **oldest/youngest customer ages** from birthdates.  

---

## 📈 **Performance Analysis (YoY/MoM)**  
**Purpose**: Track growth trends and benchmark performance.  
**Highlights**:  
- Compares yearly sales with **lagged metrics** to identify growth/decline.  
- Flags products as **Above/Below Average** using moving averages.  
- Highlights **year-over-year trends** (Increase/Decrease/No Change).  

---

## 🔍 **Magnitude Analysis**  
**Purpose**: Quantify sales distribution across categories.  
**Highlights**:  
- Breaks down **total sales by product category**.  
- Calculates **% contribution** of each category to overall revenue.  

---

## 🧩 **Data Segmentation**  
**Purpose**: Group data into actionable segments.  
**Highlights**:  
- Segments customers by **spending behavior** (VIP/Regular/New).  
- Counts customers per segment for targeted strategy design.  

---

## 🌐 **Dimensions Exploration**  
**Purpose**: Explore key dimensions for data integrity.  
**Highlights**:  
- Lists **unique countries** of customer origin.  
- Maps **product hierarchies** (category → subcategory → product).  

---

## 🚀 **How to Use**  
1. Run the SQL scripts to generate **`gold.report_customers`** and **`gold.report_products`** views.  
2. Execute exploratory queries (e.g., performance analysis) directly in your SQL environment.  

**Tools Used**: SQL Server (for `GETDATE()`, `DATEDIFF`), CTEs, Window Functions.  

--- 

**Unlock insights, optimize strategies, and drive growth!** 🚀  
