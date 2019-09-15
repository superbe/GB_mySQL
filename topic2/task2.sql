CREATE DATABASE example;
SHOW DATABASES;
USE example;
CREATE TABLE users (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(150) UNIQUE
);
SHOW TABLES;
INSERT INTO users (name) VALUES ("Аня"), ("Маня"), ("Ваня"), ("Таня");
SELECT * FROM users;