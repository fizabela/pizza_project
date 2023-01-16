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

