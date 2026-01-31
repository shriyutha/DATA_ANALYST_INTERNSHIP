DROP TABLE IF EXISTS superstore;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_geography;
DROP TABLE IF EXISTS dim_shipment;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS fact_sales;


CREATE TABLE superstore (
    order_id TEXT,
    order_date DATE,
    ship_date DATE,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);


-- Basic queries:
SELECT COUNT(*)
FROM superstore;


-- Dimension Tables:
CREATE TABLE dim_customer (
  customer_key SERIAL PRIMARY KEY,
  customer_id VARCHAR(20),
  customer_name VARCHAR(100),
  segment VARCHAR(50)
);

CREATE TABLE dim_product (
  product_key SERIAL PRIMARY KEY,
  product_id VARCHAR(20),
  product_name VARCHAR(150),
  category VARCHAR(50),
  sub_category VARCHAR(50)
);


CREATE TABLE dim_geography (
  geography_key SERIAL PRIMARY KEY,
  country VARCHAR(50),
  state VARCHAR(50),
  city VARCHAR(50),
  postal_code VARCHAR(20),
  region VARCHAR(50)
);

CREATE TABLE dim_shipment (
  shipment_key SERIAL PRIMARY KEY,
  ship_mode VARCHAR(50)
);

CREATE TABLE dim_date (
  date_key SERIAL PRIMARY KEY,
  full_date DATE,
  year INT,
  quarter INT,
  month INT,
  month_name VARCHAR(20),
  day INT,
  weekday VARCHAR(10)
);


-- Fact Table:
CREATE TABLE fact_sales (
  sales_key SERIAL PRIMARY KEY,
  order_id VARCHAR(20),
  order_date_key INT,
  ship_date_key INT,
  customer_key INT,
  product_key INT,
  geography_key INT,
  shipment_key INT,
  sales DECIMAL(10,2),
  quantity INT,
  discount DECIMAL(5,2),
  profit DECIMAL(10,2)
);


-- Insert DISTINCT Values into Dimensions:
-- Customer:
INSERT INTO dim_customer (customer_id, customer_name, segment)
SELECT DISTINCT customer_id, customer_name, segment
FROM superstore;

SELECT COUNT(*) FROM dim_customer;
SELECT * FROM dim_customer LIMIT 5;

-- Product:
INSERT INTO dim_product (product_id, product_name, category, sub_category)
SELECT DISTINCT product_id, product_name, category, sub_category
FROM superstore;

SELECT COUNT(*) FROM dim_product;
SELECT * FROM dim_product LIMIT 5;

-- Geography:
INSERT INTO dim_geography (country, state, city, postal_code, region)
SELECT DISTINCT country, state, city, postal_code, region
FROM superstore;

SELECT COUNT(*) FROM dim_geography;
SELECT * FROM dim_geography LIMIT 5;

-- Ship Mode:
INSERT INTO dim_shipment (ship_mode)
SELECT DISTINCT ship_mode
FROM superstore;

SELECT COUNT(*) FROM dim_shipment;
SELECT * FROM dim_shipment LIMIT 5;


-- Load Fact Table:
INSERT INTO fact_sales (
  order_id,
  order_date_key,
  ship_date_key,
  customer_key,
  product_key,
  geography_key,
  shipment_key,
  sales, quantity, discount, profit
)
SELECT
  s.order_id,
  d1.date_key,
  d2.date_key,
  c.customer_key,
  p.product_key,
  g.geography_key,
  sm.shipment_key,
  s.sales,
  s.quantity,
  s.discount,
  s.profit
FROM superstore s
JOIN dim_customer c ON s.customer_id = c.customer_id
JOIN dim_product p ON s.product_id = p.product_id
JOIN dim_geography g ON s.country = g.country
 AND s.state = g.state
 AND s.city = g.city
 AND s.postal_code = g.postal_code
JOIN dim_shipment sm ON s.ship_mode = sm.ship_mode
JOIN dim_date d1 ON s.order_date = d1.full_date
JOIN dim_date d2 ON s.ship_date = d2.full_date;

SELECT COUNT(*) FROM fact_sales;
SELECT * FROM fact_sales LIMIT 5;


-- Indexes:
CREATE INDEX idx_fact_customer ON fact_sales(customer_key);
CREATE INDEX idx_fact_product ON fact_sales(product_key);
CREATE INDEX idx_fact_date ON fact_sales(order_date_key);
CREATE INDEX idx_fact_geo ON fact_sales(geography_key);


-- Sales by Region:
SELECT g.region, SUM(f.sales) AS total_sales
FROM fact_sales f
JOIN dim_geography g ON f.geography_key = g.geography_key
GROUP BY g.region;


-- Profit Trend:
SELECT d.year, d.month, SUM(f.profit) AS profit
FROM fact_sales f
JOIN dim_date d ON f.order_date_key = d.date_key
GROUP BY d.year, d.month;


-- Validation Queries: Missing FK Check:
SELECT COUNT(*)
FROM fact_sales
WHERE customer_key IS NULL;
-- Record Count Reconciliation:
SELECT COUNT(*) FROM superstore;
SELECT COUNT(*) FROM fact_sales;