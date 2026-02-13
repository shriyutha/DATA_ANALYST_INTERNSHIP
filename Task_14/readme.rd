ETL Steps
Extract:
Loaded raw CSV dataset Created folder structure (raw, processed, output)

Transform:
Standardized column names Removed duplicate records Handled missing values Converted data types Created derived columns: Profit, Revenue, Order_type

Split:
Created dimensional datasets: Customers Orders Products

Load:
Exported clean CSV files Loaded structured tables into SQLite database

Validation:
Verified record counts before & after cleaning Ensured no duplicate primary keys Validated foreign key consistency Confirmed revenue totals integrity

Business Value:
Improved data quality Enabled dimensional modeling Prepared data for analytics and dashboarding Demonstrated production-style ETL process
