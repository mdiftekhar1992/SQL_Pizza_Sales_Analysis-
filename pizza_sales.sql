-- 13) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT name , revenue FROM 
(SELECT category, name, revenue, RANK() OVER(PARTITION BY category ORDER BY revenue DESC) as rn FROM 
(SELECT pizza_types.name,pizza_types.category, SUM(orders_details.quantity * pizzas.price) as revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizza_types.name,pizza_types.category) as a) as b
WHERE rn <=3;