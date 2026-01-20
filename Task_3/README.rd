# Superstore Dataset Analysis

This project analyzes a sample **Superstore Sales dataset** using PostgreSQL.  
Steps like table creation, CSV import, basic and advanced SQL queries, and exporting query results to CSV files for reporting.

**Dataset:** `Super.csv`  
**Total Rows:** 9,994  

---

## Database Setup

1. **Database:** `superstore_dataset`
2. **Table:** `superstore_sales`
3. **Columns:**

| Column Name      | Data Type       |
|-----------------|----------------|
| Order_ID        | VARCHAR(50)    |
| Order_Date      | DATE           |
| Ship_Date       | DATE           |
| Ship_Mode       | VARCHAR(50)    |
| Customer_ID     | VARCHAR(50)    |
| Customer_Name   | VARCHAR(50)    |
| Segment         | VARCHAR(50)    |
| Country         | VARCHAR(50)    |
| City            | VARCHAR(50)    |
| State           | VARCHAR(50)    |
| Postal_Code     | VARCHAR(20)    |
| Region          | VARCHAR(50)    |
| Product_ID      | VARCHAR(50)    |
| Category        | VARCHAR(100)   |
| Sub_Category    | VARCHAR(100)   |
| Product_Name    | TEXT           |
| Sales           | DECIMAL(10,4)  |
| Quantity        | INT            |
| Discount        | DECIMAL(10,4)  |
| Profit          | DECIMAL(10,5)  |

---


1. **Basic Checks**
```sql
SELECT COUNT(*) FROM superstore_sales;
SELECT * FROM superstore_sales LIMIT 5;

chris_sales_report.csv	- Sales summary for customers whose names start with "Chris"
category_sales_report.csv	 - Total and average sales by category
top10_products.csv	- Top 10 products by sales
region_sales_report.csv	- Total sales grouped by region
aug2017_sales.csv	- Total profit and number of orders for August 2017
