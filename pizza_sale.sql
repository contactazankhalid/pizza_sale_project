create table orders(
order_id int primary key,
order_date date,
order_time time
);
create table pizza_type(
pizza_type_id varchar(50) primary key,
pizza_name varchar(50),
category varchar(50),
ingredients varchar(110)
);
create table pizzas(
pizza_id int primary key,
pizza_type_id varchar(50)
pizza_size varchar(10), 
price float,
foreign key (pizza_type_id) references piz
)
                                   bussiness questions.
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most common pizza size ordered.
List the top 5 most ordered pizza types along with their quantities.
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.
Calculate the percentage contribution of each pizza type to total revenue.
Analyze the cumulative revenue generated over time.
Determine the top 3 most ordered pizza types based on revenue for each pizza category.*/

--1Retrieve the total number of orders placed.
select
count(*) 
from orders

--2Calculate the total revenue generated from pizza sales.
select 
round(sum(pa.price*p.quantity)::numeric,2) 
from order_details p 
inner join pizzas pa on p.pizza_id=pa.pizza_id

--3Identify the highest-priced pizza.
select pizza_type.pizza_name,pizzas.price
from pizzas
inner join pizza_type
on pizzas.pizza_type_id=pizza_type.pizza_type_id
order by 2
desc limit 1

--4Identify the most common pizza size ordered.

select pizzas.pizza_size,count(order_details)
from order_details 
inner join pizzas 
on order_details.pizza_id=pizzas.pizza_id
group by 1
order by 2 desc

--5List the top 5 most ordered pizza types along with their quantities.
select 
	pizza_type.pizza_type_id,sum(order_details.quantity)
	from pizzas
	inner join order_details on pizzas.pizza_id=order_details.pizza_id 
	inner join 
	pizza_type on pizza_type.pizza_type_id=pizzas.pizza_type_id
group by 1
order by 2 desc
limit 5;

--6 Join the necessary tables to find the total quantity of each pizza category ordered
select 
pt.category,
sum(od.quantity ) as most_sold
from order_details od 
inner join pizzas pi 
on od.pizza_id = pi.pizza_id 
inner join
pizza_type pt 
on pt.pizza_type_id=pi.pizza_type_id
group by 1
order by 2 desc;

--7Determine the distribution of orders by hour of the day.

select
extract(hour from order_time ) as hours ,count(order_id) 
from orders
group by 1

--8Join relevant tables to find the category-wise distribution of pizzas.
select category,count(pizza_name)
from pizza_type group by 1

--9Group the orders by date and calculate the average number of pizzas ordered per day
select 
round(avg(quantity)::numeric,0) as avg_order_per_day 
from 
(select 
orders.order_date,
sum(order_details.quantity) as quantity 
from orders 
inner join
order_details on orders.order_id=order_details.order_id 
group by 1) as order_quantity

--10Determine the top 3 most ordered pizza types based on revenue.

select
pt.pizza_name,round(sum(od.quantity*pi.price)::numeric,0) as revenue
from pizza_type pt 
inner join pizzas pi 
on pi.pizza_type_id=pt.pizza_type_id
inner join order_details od 
on pi.pizza_id=od.pizza_id 
group by 1
order by 2 desc
limit 3;

--11Calculate the percentage contribution of each pizza type to total revenue.

WITH TotalRevenue AS (
    SELECT SUM(od.quantity * p.price) AS total_val
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
)
SELECT 
    pt.category,
    ROUND(
        (SUM(od.quantity * p.price) / (SELECT total_val FROM TotalRevenue) * 100)::numeric, 
        2
    ) AS revenue_percentage
FROM pizza_type pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY revenue_percentage DESC;

--12Analyze the cumulative revenue generated over time.
select order_date,sum(revenue) over(order by order_date)
from
(select
orders.order_date, 
sum(order_details.quantity*pizzas.price) as revenue
from order_details 
inner join pizzas 
on order_details.pizza_id=pizzas.pizza_id 
inner join orders 
on orders.order_id=order_details.order_id
group by 1)

--13Determine the top 3 most ordered pizza types based on revenue for each pizza category.*/
select * from 
(select category,pizza_name,revenue,rank () over(partition by category order by revenue desc) as rank
from 
(select pizza_type.category,pizza_type.pizza_name,sum(order_details.quantity*pizzas.price) as revenue
from pizza_type inner join pizzas on pizza_type.pizza_type_id=pizzas.pizza_type_id inner join
order_details on order_details.pizza_id=pizzas.pizza_id group by 1,2 order by category)) 
where rank<=3;











