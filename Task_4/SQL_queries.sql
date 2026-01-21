
SELECT * 
FROM customer
LIMIT 5;

-- 1. Write an inner join query to combine orders with customer details and validate output by checking if order counts match.
SELECT COUNT(*) AS Total_count
FROM invoice;	 --  Total count = 412

SELECT i.invoice_id, i.invoice_date, c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Full_name
FROM invoice i
INNER JOIN customer c
ON i.customer_id = c.customer_id;   -- Total rows = 412

SELECT COUNT(*) AS Total_count
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id;      --  Total count = 412

-- 2. Write a left join query to find customers who never place any orders since these users are often important for business marketing.
FROM customer c
LEFT JOIN invoice i
ON c.customer_id = i.customer_id
WHERE i.invoice_id IS NULL;        -- No one

-- 3. Perform join between orders and product to calculate total revenue per product and identify high-performing SKUs.
SELECT t.track_id, t.name, SUM(il.quantity * il.unit_price) AS Total_revenue
FROM invoice_line il
JOIN track t
ON il.track_id = t.track_id
GROUP BY t.track_id, t.name
ORDER BY Total_revenue DESC;      -- track_id:2868, name:"Walkabout", total_revenue:$3.98


-- 4. Add conditions on joined tables using WHERE to answer business questions like sales in region X between dates Y and Z.
SELECT i.invoice_id, i.invoice_date, c.country, SUM(il.quantity * il.unit_price) AS Revenue
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE c.country = 'USA' AND i.invoice_date BETWEEN '2021-01-01' AND '2023-12-22'
GROUP BY i.invoice_id, i.invoice_date, c.country
ORDER BY Revenue DESC;        -- 54 Rows selected, with highest revenue $18.86 followed by $15.86



-- 5. Join categories with products to generate category-wise revenue distribution used in product strategy discussion
SELECT g.name, SUM(il.quantity * il.unit_price) AS Revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY Revenue DESC;       -- Total count = 24, Name:Rock, Revenue:$826.65

-- Top 5 tracks contributed to the total revenue, indicating demand concentration.
-- Rock genre was the highest revenue, making it the strongest category.
-- A small subset of customers drive repeat purchases, highlighting loyalty behavior.
-- The USA customers within the selected date range, has highest invoice revenue was $18.86, followed by $15.86