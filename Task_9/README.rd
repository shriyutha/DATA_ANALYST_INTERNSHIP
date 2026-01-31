## Task_9

FOR SOURCE TABLE:
Order_ID, Order_Date, Ship_Date, Ship_Mode,
Customer_ID, Customer_Name, Segment,
Country, City, State, Postal_Code, Region,
Product_ID, Category, Sub_Category, Product_Name,
Sales, Quantity, Discount, Profit


FOR CUSTOMER TABLE:
Customer_ID
Customer_Name
Segment

FOR PRODUCT TABLE:
Product_ID
Category
Sub_Category
Product_Name

FOR LOCATION/GEOGRAPH TABLE:
Country
State
City
Postal_Code
Region

FOR DATE TABLE:
Order_Date
Ship_Date

FOR SHIMPENT TABLE:
Ship_Mode


FOR FACT TABLE
Column	          Type	            Description
sales_key	        PK	              Surrogate key
order_id	        Degenerate	      Original Order_ID
order_date_key	  FK	              Order date
ship_date_key	    FK	              Ship date
customer_key	    FK	              Customer
product_key	      FK	              Product
geography_key	    FK	              Location
ship_mode_key	    FK	              Shipping
sales	            Measure	          Revenue
quantity	        Measure	          Units sold
discount	        Measure	          Discount
profit	          Measure	          Profit

## Simple Visual:

           dim_customer
                |
dim_product — fact_sales — dim_geography
                |
           dim_date
                |
          dim_ship_mode
