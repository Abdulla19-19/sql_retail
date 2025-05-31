# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.


### 2. Data Exploration & Cleaning

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select * from Retail_sales


--Data cleaning
delete from Retail_Sales
where 
transactions_id is null
or 
sale_date is null
or
sale_time is null
or 
customer_id is null
or 
gender is null
or 
age is null
or
category is null
or
quantiy is null
or 
price_per_unit is null
or
cogs is null
or 
total_sale is null

select * from Retail_Sales

```
**how many sales we have**
```sql

select count(*) as total_sale 
from Retail_sales
```
**how many coustomer we have**
```sql
select count(distinct customer_id)
from Retail_sales
```
### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
   select * from Retail_Sales
   where sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM Retail_sales
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01'  AND quantiy >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
 select distinct category,sum(total_sale) as total_sale
  from Retail_sales
  group by category
  
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select avg(age) as avg_age_customers
  from Retail_sales
  where category='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
 select * 
  from Retail_Sales
  where total_sale > 1000 
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
 select count(transactions_id) as total_num_transaction,gender,category
 from Retail_Sales
 group by gender,category
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select 
    year,
    month,
    avg_sale
from (
    select 
    year(sale_date) as year,
    month(sale_date) as month,
    avg(total_sale) as avg_sale,
    rank() over (partition by year(sale_date) order by avg(total_sale) desc) as rnk
    from retail_sales
    group by year(sale_date), month(sale_date)) as sub
where rnk = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select customer_id, total_sales
from (
    select 
        customer_id,
        sum(total_sale) as total_sales,
        row_number() over (order by sum(total_sale) desc) as rn
    from retail_sales
    group by customer_id
) as ranked
where rn <= 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select category,count(distinct customer_id) as unique_customers
from Retail_Sales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
select  case 
       when datepart(hour, sale_time) < 12 then 'Morning'
       when datepart(hour, sale_time) BETWEEN 12 AND 17 then'Afternoon'
       else 'Evening'
    end as shift,
    count(*)as total_orders
from retail_sales
group by case
        when datepart(hour, sale_time) < 12 then 'Morning'
        when datepart(hour, sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



