-- Database setup:
SELECT current_database();


--Droping existing TABLE:
DROP TABLE IF EXISTS superstore_sales;


-- CREATING NEW TABLE called superstore_sales:
CREATE TABLE superstore_sales(
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(50),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product_Name TEXT,
    Sales DECIMAL(10,4),
    Quantity INT,
    Discount DECIMAL(10,4),
    Profit DECIMAL(10,5)
);


-- IMPORTED CSV FILE TO DATABASE FOR ANALYSIS --


-- Basic check to confirm imported sucessfully:
SELECT * 
FROM superstore_sales;


-- Just first 5 rows:
SELECT * 
FROM superstore_sales 
LIMIT 5;


-- Counting total values/records to confirm CSV row count:
SELECT COUNT(*) AS Total_Counts 
FROM superstore_sales;


-- Top 10 sales items:
SELECT Product_Name, Sales
FROM superstore_sales
ORDER BY Sales DESC
LIMIT 10;


-- Sales greater than 5000 using filter:
SELECT Product_Name, Sales
FROM superstore_sales
WHERE Sales > 5000
ORDER BY Sales DESC;


-- Total sales by category:
SELECT Category, ROUND(SUM(Sales), 2) AS Total_Sales, ROUND(AVG(Sales), 2) AS Avg_Sales, COUNT(*) AS Num_Orders
FROM superstore_sales
GROUP BY Category
ORDER BY Category;


-- Sub_Categories with total sales greater than 10K:
SELECT Sub_Category, SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY Sub_Category
HAVING SUM(Sales) > 10000
ORDER BY Total_Sales DESC;


-- Monthly sales report:
SELECT SUM(Profit) AS Total_Profit, COUNT(*) AS Num_Orders
FROM superstore_sales
WHERE Order_Date BETWEEN '2017-08-01' AND '2017-08-30';


-- Using LIKE clause, searching customer's name:
SELECT Customer_Name, SUM(Sales) AS total_sales, SUM(Quantity) AS Total_Items
FROM superstore_sales
WHERE Customer_Name LIKE 'Chris%'
GROUP BY Customer_Name;