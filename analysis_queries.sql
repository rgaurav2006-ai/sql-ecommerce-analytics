
SELECT 
c.customer_name,p.product_name,oi.price,oi.quantity,oi.discount,o.order_date,
SUM(oi.price * oi.quantity) AS revenue,
CASE
    WHEN (oi.quantity * oi.price) > 50000 THEN 'High Value'
    WHEN (oi.quantity * oi.price) BETWEEN 10000 AND 50000 THEN 'Medium Value'
    ELSE 'Low Value'
END AS order_category
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY 
c.customer_name,p.product_name,oi.price,oi.quantity,oi.discount,o.order_date;
select round(sum(Quantity*Price)) as total_revenue
from order_items;


select round(sum(Quantity*discount)) as total_discount_loss
from order_items;


select p.category,sum(oi.price*oi.quantity) as revenue
from products p
join order_items oi
on p.product_id=oi.product_id  
group by p.category
order by revenue desc;


WITH product_sales AS(
SELECT 
p.category,
p.product_name,
SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category,p.product_name)
select *
from(
select *,
row_number() over(partition by category order by revenue desc) as rank_num
from product_sales)t
where rank_num= 1;


/*Repeat Purchase Rate*/
SELECT 
COUNT(DISTINCT customer_id) AS total_customers,
COUNT(DISTINCT CASE 
WHEN order_count > 1 THEN customer_id
END) AS repeat_customers
FROM(
SELECT 
customer_id,
COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
)t;


/* customer lifetime value*/
SELECT 
c.customer_id,
c.customer_name,
SUM(oi.quantity * (oi.price - oi.discount)) AS customer_lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.customer_name
ORDER BY customer_lifetime_value DESC;


/* Discount Effectiveness Analysis */
-- Analyze revenue and discount impact by product category

WITH category_sales AS (

SELECT 
p.category,
SUM(oi.quantity * oi.price) AS gross_revenue,
SUM(oi.quantity * oi.discount) AS total_discount,
SUM(oi.quantity * (oi.price - oi.discount)) AS net_revenue

FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.category

)

SELECT 
category,
gross_revenue,
total_discount,
net_revenue,
ROUND((total_discount / gross_revenue) * 100,2) AS discount_percentage

FROM category_sales
ORDER BY discount_percentage DESC;
