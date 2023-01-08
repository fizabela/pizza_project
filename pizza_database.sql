CREATE DATABASE pizza_place;

CREATE TABLE orders (
    row_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    order_time DATETIME NOT NULL,
    quantity INT NOT NULL,
    pizza_size VARCHAR(50) NOT NULL,
    unit_price INT NOT NULL,
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
    ingred_id INT NOT NULL,
    ing_name VARCHAR(50) NOT NULL
);

CREATE TABLE recipes (
    row_id INT NOT NULL,
    recipe_id VARCHAR(50) NOT NULL,
    ingred_id INT NOT NULL,
    FOREIGN KEY (recipe_id)
        REFERENCES pizzas (pizza_name),
    FOREIGN KEY (ingred_id)
        REFERENCES ingredients (ing_name)
);


