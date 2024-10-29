-- 1) Calculate the percentage contribution of each pizza type to total revenue.

SELECT pizza_types.category,
round(sum(order_details.quantity * pizzas.price)) / (

SELECT 
round(sum(order_details.quantity * pizzas.price),2) as Total_Sales
from order_details 
join pizzas
on pizzas.pizza_id = order_details.pizza_id) * 100 as revenue

FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id

JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue 
DESC
;


-- 2) Analyze the cumulative revenue generated over time. 

-- ( cumulative amount -
-- todays income + remaining income fom yesterday
-- 200 200
-- 300  200+300 = 500
-- 450  450 +500 = 900)

SElECT order_date,
sum(revenue) over(order by order_date) as cum_revenue
FROM
(SELECT orders.order_date,
round(sum(order_details.quantity * pizzas.price),2) as revenue
FROM order_details 
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id

join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales
;



-- 3) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT category, name, revenue
FROM
(
SELECT category, name, revenue,
rank() over( partition by category order by revenue desc) as Rnk
FROM
(
select pizza_types.category, pizza_types.name, 
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types 
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id

join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name
) as A
) as B
WHERE Rnk <= 3
;







