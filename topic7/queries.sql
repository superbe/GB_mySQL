use shop;

SHOW TABLES;

TRUNCATE orders;
INSERT INTO orders (user_id) VALUES
  ('1'),
  ('1'),
  ('2'),
  ('3'),
  ('5'),
  ('2'),
  ('5'),
  ('5'),
  ('3'),
  ('1'),
  ('2'),
  ('1'),
  ('3'),
  ('2');

-- Урок 7. Задание 1. Составьте список пользователей users, 
-- которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
	* 
FROM 
	users
WHERE
	id IN (SELECT DISTINCT user_id FROM orders);
    
-- Урок 7. Задание 2. Выведите список товаров products и разделов 
-- catalogs, который соответствует товару.

SELECT 
	(SELECT name FROM catalogs c WHERE p.catalog_id = c.id) AS 'Каталог',
    p.name AS 'Название',
    p.desription AS 'Описание',
    p.price AS 'Цена'
FROM 
	products p;