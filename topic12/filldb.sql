-- Вспомогательная база данных по формированию понятных тестовых данных.

drop database if exists filldb;
create database filldb;
use filldb;

DROP TABLE IF EXISTS male_first_names;
CREATE TABLE male_first_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор имени",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Имя",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Мужские имена";

DROP TABLE IF EXISTS male_middle_names;
CREATE TABLE male_middle_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор отчества",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Отчество",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Мужские отчества";

DROP TABLE IF EXISTS male_last_names;
CREATE TABLE male_last_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор фимилии",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Фимилия",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Мужские фимилии";

DROP TABLE IF EXISTS female_first_names;
CREATE TABLE female_first_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор имени",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Имя",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Женские имена";

DROP TABLE IF EXISTS female_middle_names;
CREATE TABLE female_middle_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор отчества",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Отчество",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Женские отчества";

DROP TABLE IF EXISTS female_last_names;
CREATE TABLE female_last_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор фимилии",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Фимилия",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Женские фимилии";

INSERT INTO male_first_names (name, frequency) VALUES
('Иван',0.2354),
('Петр',0.7354);

SELECT * FROM male_first_names;
