## Titanic Dataset Analysis Report

### data: https://www.kaggle.com/datasets/brendan45774/test-file

This project reports an exploratory data analysis performed on the Titanic dataset. 
The main objective was to clean the data, transform data types, engineer meaningful features, and prepare the dataset for analysis and modeling.

#### Handling Missing Values:
Age: Missing values were filled using the median age grouped by passenger(Pclass).
Cabin: Missing values were replaced with the label 'No Cabin'.

#### Data Type Standardization:
Columns were converted from object or int to category using .astype('category') to improve memory efficiency.
Split Full Name into 2 seperate columns and removed Prefix for better analysis.
Droped NA's

#### Family Based Features:
Created new column 'Family_Members' by using SibSp and Parch: Family_Members = SibSp + Parch + 1
Age and Fare Segmentation:
Passengers were categorized into meaningful life stages using conditional logic and passengers were categorized into fare categories.

### Key Insights:
Gender had a strong impact on survival
Passenger class (Pclass) strongly influenced survival
Infants and children had higher survival rates compared to adults.
Senior passengers had lower survival rates.
Family size mattered more than traveling alone
Cabin availability indicated survival advantage
