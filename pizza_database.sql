-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/rtgBP6
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` int  NOT NULL ,
    `order_time` datetime  NOT NULL ,
    `quantity` int  NOT NULL ,
    `pizza_size` VARCHAR(50)  NOT NULL ,
    `unit_price` INT  NOT NULL ,
    `item_id` INT  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `pizzas` (
    `pizza_id` INT  NOT NULL ,
    `pizza_cactegory` VARCHAR(50)  NOT NULL ,
    `pizza_name` VARCHAR(50)  NOT NULL ,
    PRIMARY KEY (
        `pizza_id`
    )
);

CREATE TABLE `ingredients` (
    `ingred_id` INT  NOT NULL ,
    `ing_name` VARCHAR(50)  NOT NULL 
);

CREATE TABLE `recipes` (
    `row_id` INT  NOT NULL ,
    `recipe_id` VARCHAR(50)  NOT NULL ,
    `ingred_id` INT  NOT NULL 
);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_item_id` FOREIGN KEY(`item_id`)
REFERENCES `pizzas` (`pizza_id`);

ALTER TABLE `recipes` ADD CONSTRAINT `fk_recipes_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `pizzas` (`pizza_name`);

ALTER TABLE `recipes` ADD CONSTRAINT `fk_recipes_ingred_id` FOREIGN KEY(`ingred_id`)
REFERENCES `ingredients` (`ing_name`);

