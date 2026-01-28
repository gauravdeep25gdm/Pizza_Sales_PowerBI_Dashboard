select * from pizza_sales

-- Total Revenue
select SUM(total_price) as Total_Revenue from pizza_sales;

-- Average order value
select (sum(total_price)/count(Distinct order_id)) as Average_Order_Value from pizza_sales;

--total pizza sold
select Sum(quantity) as Total_pizza_sold from pizza_sales;

--total orders
select count(Distinct order_id) as Total_Orders from pizza_sales;

-- average pizza per order
SELECT 
  CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) as average_pizza_per_order
FROM pizza_sales;

-- weekely days trend of total orders
select DATENAME(DW, order_date) as order_day, count(DIstinct order_id) as total_orders_daily
FROM pizza_sales
group by DATENAME(DW, order_date);

-- monthly trend of orders
select DATENAME (Month, order_date) as Month_Name, count(Distinct order_id) as Monthly_orders
from pizza_sales
group by DATENAME (Month, order_date)
Order by Monthly_orders DESC

-- percentage of sales by pizza category
select pizza_category, sum (total_price) as Total_sales,sum(total_price)*100 / 
(select sum(total_price) from pizza_sales Where Month(order_date)=1) as Percentage_Total_Sales
from pizza_sales
Where Month(order_date) = 1
group by pizza_category

-- percentage of sale by pizza size
select pizza_size, cast(sum (total_price) as decimal(10,2)) as Total_sales,CAST(sum(total_price)*100 / 
(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1) as decimal(10,2)) as Percentage_Total_Sales
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by Percentage_Total_Sales DESC


--top 5 and bottom 5 pizza by revenue
select TOP 5 pizza_name,sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue


--top 5 and bottom 5 pizza by quantity
select TOP 5 pizza_name,sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Revenue desc


--top 5 and bottom 5 pizza by count
select TOP 5 pizza_name,count(Distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders desc
