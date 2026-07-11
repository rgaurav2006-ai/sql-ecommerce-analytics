CREATE DATABASE ecommerce_project;
USE ecommerce_project;

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(30),
city VARCHAR(20),
signup_date DATE
);

CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50)
);


CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
order_status VARCHAR(20),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items(
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
price DECIMAL(10,2),
discount DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);
