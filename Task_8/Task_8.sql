-- Droping the current table:
DROP TABLE IF EXISTS superstore;


-- Creating a table matching the CSV columns:
CREATE TABLE superstore (
    order_id text,
    order_date date,
    ship_date date,
    ship_mode text,
    customer_id text,
    customer_name text,
    segment text,
    country text,
    city text,
    state text,
    postal_code text,
    region text,
    product_id text,
    category text,
    sub_category text,
    product_name text,
    sales text,
    quantity text,
    discount text,
    profit text
);


-- BASIC QUERY:
SELECT COUNT(*) FROM superstore;


-- Sales:
SELECT
    sales,
    sales::numeric
FROM public.superstore
LIMIT 5;


-- Total Sales per Customer (GROUP BY):
SELECT
    customer_id,
    customer_name,
    SUM(sales::numeric) AS total_sales
FROM superstore
GROUP BY customer_id, customer_name;


-- Rank Customers by Sales per Region(ROW_NUMBER vs RANK vs DENSE_RANK):
SELECT
    region,
    customer_id,
    customer_name,
    SUM(sales::numeric) AS total_sales,

    ROW_NUMBER() OVER (
        PARTITION BY region
        ORDER BY SUM(sales::numeric) DESC
    ) AS row_number_rank,

    RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales::numeric) DESC
    ) AS rank_with_gaps,

    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(sales::numeric) DESC
    ) AS dense_rank_no_gaps

FROM superstore
GROUP BY region, customer_id, customer_name;


-- Running Total Sales (Window Function):
SELECT
    order_date,
    SUM(sales::numeric) AS daily_sales,
    SUM(SUM(sales::numeric)) OVER (
        ORDER BY order_date
    ) AS running_total_sales
FROM superstore
GROUP BY order_date
ORDER BY order_date;


-- Month-over-Month (MoM) Growth Using LAG:
WITH monthly_sales AS (
	SELECT 
		DATE_TRUNC('month', order_date)::DATE AS month,
		SUM(sales::numeric) AS total_sales
	FROM superstore 
	GROUP BY 1
)
SELECT 
	month, total_sales, 
	LAG(total_sales) OVER (ORDER BY total_sales) AS prev_month_sales,
	(total_sales * LAG(total_sales) OVER (ORDER BY total_sales)) / COALESCE(LAG(total_sales) OVER (ORDER BY total_sales), 0) AS mom
FROM monthly_sales
ORDER BY month;

/* 1. Few customers had contributed a large share of total revenue, indicating strong customer concentration risk.

   2. MoM growth analysis reveals seasonal spikes, with certain months consistently outperforming others. */