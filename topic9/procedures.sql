-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Задание 1.
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
-- фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
-- "Доброй ночи".
USE shop;

DELIMITER //

-- DROP PROCEDURE IF EXISTS hello//
-- CREATE PROCEDURE hello(OUT value TEXT)
-- BEGIN
-- 	DECLARE hour INT;
--     SET hour = HOUR(NOW());
--     CASE
-- 		WHEN hour BETWEEN 0 AND 5 THEN
-- 			SET value = "Доброй ночи!";
-- 		WHEN hour BETWEEN 6 AND 11 THEN
-- 			SET value = "Доброе утро!";
-- 		WHEN hour BETWEEN 12 AND 17 THEN
-- 			SET value = "Доброй день!";
-- 		WHEN hour BETWEEN 18 AND 23 THEN
-- 			SET value = "Добрый вечер!";
-- 	END CASE;
-- END//
-- SET @greeting = ""//
-- CALL hello(@greeting)//
-- SELECT @greeting//

-- Исправленное.

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS TINYTEXT
DETERMINISTIC
BEGIN
	DECLARE hour INT;
    SET hour = HOUR(NOW());
    CASE
		WHEN hour BETWEEN 0 AND 5 THEN
			RETURN "Доброй ночи!";
		WHEN hour BETWEEN 6 AND 11 THEN
			RETURN "Доброе утро!";
		WHEN hour BETWEEN 12 AND 17 THEN
			RETURN "Доброй день!";
		WHEN hour BETWEEN 18 AND 23 THEN
			RETURN "Добрый вечер!";
	END CASE;
END//

SELECT NOW(), hello()//

-- Задание 2.
-- В таблице products есть два текстовых поля: name с названием товара и description 
-- с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, 
-- когда оба поля принимают неопределенное значение NULL неприемлема. Используя 
-- триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS check_insert_products//
CREATE TRIGGER check_insert_products BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
  END IF;
END//

DROP TRIGGER IF EXISTS check_update_products//
CREATE TRIGGER check_update_products BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
  END IF;
END//

INSERT INTO products
  (name, price)
VALUES
  ("ASUS X570", 1931)//

SELECT * FROM products//

INSERT INTO products
  (description, price)
VALUES
  ("ASUS X570", 1931)//

SELECT * FROM products//
  
-- INSERT INTO products
--   (price)
-- VALUES
--   (1931)//

-- SELECT * FROM products//

UPDATE products SET name = null WHERE id = 2//

SELECT * FROM products//

UPDATE products SET description = null WHERE id = 2//

SELECT * FROM products//
