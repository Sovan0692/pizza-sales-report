SELECT * FROM [test].[dbo].[pizza_sales]

-- sum
select sum(total_price)as total_ravenue from [test].[dbo].[pizza_sales] 

-- average order values
select sum(total_price)/count(distinct order_id) as average_order_value from [test].[dbo].[pizza_sales]
-- '38.307262295081635'

-- total pizza sold
select sum(quantity) as total_pizza_sold from  [test].[dbo].[pizza_sales]
-- 49574

-- Total orders
select count(distinct order_id) as total_orders from [test].[dbo].[pizza_sales]
-- '21350'

-- average pizzas per order
select sum(quantity)/count(distinct order_id) as average_pizzas_per_order from [test].[dbo].[pizza_sales]
-- '2.3220'

-- chart requirements

-- daily trend for total orders
select datename(DW,order_date) as erder_day , count(distinct order_id) as total_order
from [test].[dbo].[pizza_sales]
group by datename(dw,order_date)

-- monthly trend for total orders
select datename(MONTH,order_date) as erder_day , count(distinct order_id) as total_order
from [test].[dbo].[pizza_sales]
group by datename(MONTH,order_date)

-- percentage of sales by pizza category
SELECT pizza_category, cast(SUM(total_price) as decimal(10,2)) as total_revenue,
cast(SUM(total_price) * 100 / (SELECT SUM(total_price) from [test].[dbo].[pizza_sales]) as decimal(10,2)) AS PCT
FROM [test].[dbo].[pizza_sales]
GROUP BY pizza_category


-- percentage of sales by pizza size
SELECT 
    pizza_size,
    cast(SUM(total_price) as decimal(10,2)) as total_ravenue,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM [test].[dbo].[pizza_sales]) AS DECIMAL(10, 2)) AS percentage_of_total_quantity
FROM 
    [test].[dbo].[pizza_sales]
GROUP BY 
    pizza_size

-- total pizza sold by pizza cetegory
SELECT 
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM 
    [test].[dbo].[pizza_sales]
GROUP BY 
    pizza_category

-- top 5 best seller by ravenue 
SELECT TOP 5
    pizza_name,
   cast(sum(total_price) as decimal(10,2)) as top_5
FROM 
    [test].[dbo].[pizza_sales]
GROUP BY 
    pizza_name
order by
	sum (total_price) desc

-- bottom 5 best seller by ravenue 
SELECT TOP 5
    pizza_name,
	cast(sum(quantity) as decimal(10,2)) as bottom_5
from [test].[dbo].[pizza_sales]
group by pizza_name
order by sum(quantity) asc

--top 5 by qunatity
SELECT TOP 5
    pizza_name,
	cast(sum(quantity) as decimal(10,2)) as bottom_5
from [test].[dbo].[pizza_sales]
group by pizza_name
order by sum(quantity) desc

--bottom 5 by quantity
SELECT TOP 5
    pizza_name,
	cast(sum(quantity) as decimal(10,2)) as bottom_5
from [test].[dbo].[pizza_sales]
group by pizza_name
order by sum(quantity) asc

-- top 5 by total_orders
SELECT TOP 5
    pizza_name,
	count(distinct order_id) as top_5
from [test].[dbo].[pizza_sales]
group by pizza_name
order by count(distinct order_id) desc

-- bottom 5 by total_orders
SELECT TOP 5
    pizza_name,
	count(distinct order_id) as bottom_5
from [test].[dbo].[pizza_sales]
group by pizza_name
order by count(distinct order_id) asc
