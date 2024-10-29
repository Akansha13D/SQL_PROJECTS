-- 1) Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.name as Pizza_Name,
sum(order_details.quantity) as Total_Orders,
pizza_types.category as Pizza_Category

FROM pizza_types 
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id

join order_details
on order_details.pizza_id = pizzas.pizza_id

group by Pizza_Name, Pizza_Category
order by total_orders desc
;

-- 2) Determine the distribution of orders by hour of the day.

SELECT hour(order_time), count(order_id)
FROM orders
GROUP BY hour(order_time)
;

-- 3) Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, count(name) 
FROM pizza_types
GROUP BY category
;

-- 4) Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT round(AVG(Total_Orders),0) as Avg_Pizzas_per_day
FROM
(SELECT orders.order_date, 
sum(order_details.quantity) as Total_Orders
FROM orders 
JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date ) as Order_Quantity
;

-- 5) Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name, 
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types 
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id

join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3


