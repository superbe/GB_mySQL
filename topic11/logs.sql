-- Создайте таблицу logs типа Archive. Пусть при каждом создании 
-- записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, 
-- идентификатор первичного ключа и содержимое поля name.

USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания',
  target_table VARCHAR(255) COMMENT 'Целевая таблица',
  target_id int COMMENT 'Идентификатор целевой записи',
  content_name VARCHAR(255) COMMENT 'Поле name в целевой записи'
) COMMENT = 'Журнал событий' ENGINE=ARCHIVE;

DELIMITER //

DROP TRIGGER IF EXISTS insert_record_users//
CREATE TRIGGER insert_record_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs (target_table, target_id, content_name) VALUES ('users', NEW.id,  NEW.name);
END//

DROP TRIGGER IF EXISTS insert_record_catalogs//
CREATE TRIGGER insert_record_catalogs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
  INSERT INTO logs (target_table, target_id, content_name) VALUES ('catalogs', NEW.id,  NEW.name);
END//

DROP TRIGGER IF EXISTS insert_record_products//
CREATE TRIGGER insert_record_products AFTER INSERT ON products
FOR EACH ROW BEGIN
  INSERT INTO logs (target_table, target_id, content_name) VALUES ('products', NEW.id,  NEW.name);
END//
DELIMITER ;

INSERT INTO users (name, birthday_at) VALUES
  ('Василий', '1988-10-05'),
  ('Петр', '1988-11-12');

INSERT INTO users (name, birthday_at) VALUES
  ('Василиса', '1988-10-05'),
  ('Анфиса', '1988-11-12');
  
INSERT INTO catalogs VALUES (NULL, 'Вентиляторы');
INSERT INTO catalogs VALUES (NULL, 'Телевизоры');
INSERT INTO catalogs VALUES (NULL, 'Кофеварки');
INSERT INTO catalogs VALUES
  (NULL, 'Колонки'),
  (NULL, 'Микрофоны');

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i7-9100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 37890.00, 1),
  ('Gigabyte H310M S2HMX', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4690.00, 2);

SELECT * FROM logs;