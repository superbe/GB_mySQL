-- Практическое задание по теме “Транзакции, переменные, представления”
-- Задание 1.
-- В базе данных shop и sample присутствуют одни и те же таблицы, 
-- учебной базы данных. Переместите запись id = 1 из таблицы shop.users 
-- в таблицу sample.users. Используйте транзакции.

-- Запустили транзакцию.
START TRANSACTION;

-- Удалили запись с идентификатором id = 1 из sample.users.
DELETE FROM sample.users AS su WHERE su.id = 1;

-- Копируем запись с идентификатором id = 1 из shop.users в sample.users.
INSERT INTO sample.users SELECT * FROM shop.users su WHERE su.id = 1;

-- Удалили запись с идентификатором id = 1 из sample.users.
DELETE FROM shop.users AS su WHERE su.id = 1;

-- Завершили транзакцию.
COMMIT;

-- Задание 2.
-- Создайте представление, которое выводит название name товарной позиции 
-- из таблицы products и соответствующее название каталога name из таблицы catalogs.
USE shop;

CREATE OR REPLACE VIEW products_view AS
SELECT 
	c.name AS 'Каталог',
	p.name AS 'Название',
    p.description AS 'Описание',
    p.price AS 'Цена' 
FROM 
	products AS p 
		JOIN 
			catalogs AS c 
		ON 
			p.catalog_id = c.id;
            
SELECT * FROM products_view;