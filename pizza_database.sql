CREATE DATABASE pizza_place;
USE pizza_place;

CREATE TABLE orders (
    row_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    quantity INT NOT NULL,
    pizza_size VARCHAR(50) NOT NULL,
    unit_price DECIMAL(4,2) NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (item_id)
        REFERENCES pizzas (pizza_id)
);

CREATE TABLE pizzas (
    pizza_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    pizza_cactegory VARCHAR(50) NOT NULL,
    pizza_name VARCHAR(50) NOT NULL
);

CREATE TABLE ingredients (
    ing_id INT NOT NULL,
    ing_name VARCHAR(50) NOT NULL
);

CREATE TABLE recipes (
    row_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    recipe_id INT,
    ingred_id VARCHAR(50) NOT NULL,
    FOREIGN KEY (recipe_id)
        REFERENCES pizzas(pizza_id),
    FOREIGN KEY (ingred_id) REFERENCES ingredients(ingred_id));
-- );

SELECT * FROM orders;

-- What days and times do we tend to be busiest?

SELECT 
    DAYNAME(order_date) AS 'order_day', SUM(quantity) AS busiest_days
FROM
    orders
GROUP BY order_day
ORDER BY busiest_days DESC;

SELECT 
    HOUR(order_time) AS 'order_hour', SUM(quantity) AS busiest_hours
FROM
    orders
GROUP BY order_hour
ORDER BY busiest_hours DESC;

SELECT 
    DAYNAME(order_date) AS 'order_day',
    HOUR(order_time) AS 'order_hour',
    COUNT(*) AS busiest_hours
FROM
    orders
GROUP BY order_day , order_hour
ORDER BY busiest_hours DESC;

-- The busiests days: Friday, Saturday, Thursday
-- The busiests hours: 12, 13, 17, 18

-- How many pizzas are we making during peak periods?

SELECT * FROM orders;

SELECT 
    HOUR(order_time) AS 'order_hour', SUM(quantity), COUNT(*)  AS busiest_hours
FROM
    orders
GROUP BY order_hour HAVING order_hour IN (12,13,17,18)
ORDER BY busiest_hours DESC;

-- 12 - 13 : 13 189, 
-- 17 - 18 : 10 502



SELECT 
    HOUR(order_time) AS 'order_hour',
    SUM(quantity) OVER(PARTITION BY HOUR(order_time)) AS the_most
FROM orders
ORDER BY the_most;