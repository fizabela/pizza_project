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

LOAD DATA INFILE "C:\Users....csv"
INTO TABLE orders
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE VIEW compiled_data AS
SELECT 
    order_id,
    order_date,
    order_time,
    quantity,
    unit_price,
    pizza_name
FROM
    orders
        LEFT JOIN
    pizzas ON orders.item_id = pizzas.pizza_id;
    
SELECT * FROM compiled_data;

-- What days and times do we tend to be busiest?

SELECT 
    DAYNAME(order_date) AS 'order_day', SUM(quantity) AS no_orders
FROM
    compiled_data
GROUP BY order_day
ORDER BY no_orders DESC
LIMIT 2;

SELECT 
    HOUR(order_time) AS 'order_hour', SUM(quantity) AS no_orders
FROM
    compiled_data
GROUP BY order_hour
ORDER BY no_orders DESC
LIMIT 2;


-- The busiests days: Friday, Saturday, Thursday
-- The busiests hours: 12, 13, 17, 18

-- How many pizzas are we making during peak periods?

SELECT SUM(no_pizzas) AS no_pizzas_12_13 FROM(
    SELECT HOUR(order_time) AS order_hour, SUM(quantity) AS no_pizzas
FROM
    compiled_data
GROUP BY order_hour
ORDER BY no_pizzas DESC
LIMIT 2) AS sold_12_13;

-- 12/13 : 13 189

SELECT SUM(no_pizzas) AS no_pizzas_17_18 FROM(
    SELECT HOUR(order_time) AS order_hour, SUM(quantity) AS no_pizzas
FROM
    compiled_data
GROUP BY order_hour
ORDER BY no_pizzas DESC
LIMIT 2,2) AS sold_17_18;

-- 17/18 : 10 628


-- What are our best and worst-selling pizzas?

SELECT 
    pizza_name, no_sold_pizzas
FROM
    ((SELECT 
        pizza_name, SUM(quantity) AS no_sold_pizzas
    FROM
        compiled_data
    GROUP BY pizza_name
    LIMIT 1) UNION (SELECT 
        pizza_name, SUM(quantity) AS no_sold_pizzas
    FROM
        compiled_data
    GROUP BY pizza_name
    ORDER BY no_sold_pizzas
    LIMIT 1)) AS best_worst_pizza;

-- The Best: The Hawaiian Pizza - 2422
-- The Worst: The Brie Pizza - 490


-- What's our average order value?

SELECT ROUND(AVG(order_val_total), 2) AS avg_order_val FROM(SELECT order_id, SUM(unit_price*quantity) AS order_val_total FROM compiled_data
GROUP BY order_id) AS total_order_value_grouped;

SELECT * FROM compiled_data;