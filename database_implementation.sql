# create and use database
CREATE DATABASE fastfood_nutrition;
USE fastfood_nutrition;


# create tables as described in wiki
CREATE TABLE restaurant ( 
restaurant_id INT AUTO_INCREMENT PRIMARY KEY, 
restaurant VARCHAR(45) 
);

CREATE TABLE item ( 
item_id INT AUTO_INCREMENT PRIMARY KEY, 
item VARCHAR(100), restaurant_id INT, 
FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id) 
);

CREATE TABLE nutrition_info ( 
item_id INT PRIMARY KEY, 
calories INT, 
cal_fat INT, 
total_fat INT, 
sat_fat INT, 
trans_fat INT, 
cholesterol INT, 
sodium INT, 
total_carb INT, 
fiber INT, 
sugar INT, 
protein INT, 
vit_a INT, 
vit_c INT, 
calcium INT, 
FOREIGN KEY (item_id) REFERENCES item(item_id)
);

# uploaded the data into one big table called big_table with import wizard 

# error in uploading (Mcdonalds spelled incorrectly)
UPDATE big_table
SET restaurant="Mcdonalds"
WHERE restaurant="Mcdo0lds";

# eliminate duplicates (there are a couple)
CREATE TABLE big_table_u AS 
SELECT DISTINCT * FROM big_table;

# insert the data into created tables
INSERT INTO restaurant (restaurant_id, restaurant) 
SELECT DISTINCT NULL, restaurant FROM big_table_u;

INSERT INTO item (item_id, item, restaurant_id) 
SELECT DISTINCT NULL, item, r.restaurant_id FROM big_table_u bt 
JOIN restaurant r ON bt.restaurant = r.restaurant;

INSERT INTO nutrition_info 
(item_id, calories, cal_fat, total_fat, sat_fat, trans_fat, cholesterol, sodium, total_carb, fiber, sugar, protein, vit_a, vit_c, calcium) 
SELECT 
i.item_id, calories, cal_fat, total_fat, sat_fat, trans_fat, cholesterol, sodium, total_carb, fiber, sugar, protein, vit_a, vit_c, calcium 
FROM big_table_u bt 
JOIN restaurant r ON bt.restaurant = r.restaurant
JOIN item i ON bt.item = i.item AND i.restaurant_id = r.restaurant_id;

# Get rid of unnecessary tables
DROP TABLE big_table;
DROP TABLE big_table_u;