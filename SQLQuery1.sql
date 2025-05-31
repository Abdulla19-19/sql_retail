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

---data exploration


--how many sales we have ?

select count(*) as total_sale 
from Retail_sales

--how many coustomer we have ?

select count(distinct customer_id)
from Retail_sales

select distinct category from Retail_sales

--- data analysis & bussiness key problems & ans
--My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
   select * from Retail_Sales
   where sale_date='2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM Retail_sales
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01'  AND quantiy >= 4;

  -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

  select distinct category,sum(total_sale) as total_sale
  from Retail_sales
  group by category
  
  -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
  select avg(age) as avg_age_customers
  from Retail_sales
  where category='Beauty'

  -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

  select * 
  from Retail_Sales
  where total_sale > 1000 

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

 select count(transactions_id) as total_num_transaction,gender,category
 from Retail_Sales
 group by gender,category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

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

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


select category,count(distinct customer_id) as unique_customers
from Retail_Sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
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
-- end project

