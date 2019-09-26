-- Задание 1.1. Пусть в таблице users поля created_at и updated_at 
-- оказались незаполненными. Заполните их текущими датой и временем.

drop database if exists topic5;
create database topic5;
use topic5;

drop table if exists users;
create table users (
	id serial primary key,
	name varchar(255),
	birthday_at date,
	created_at datetime,
	updated_at datetime
);

insert into users (name, birthday_at) values
	('Геннадий', '1990-10-05'),
	('Наталья', '1984-11-12'),
	('Александр', '1985-05-20'),
	('Сергей', '1988-02-14'),
	('Иван', '1998-01-12'),
	('Мария', '1992-08-29');

select * from users;

UPDATE
	users 
SET 
	created_at = now()
where
	created_at is null;

select * from users;

UPDATE
	users 
SET 
    updated_at = now()
where
	updated_at is null;

select * from users;

-- Задание 1.2. Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате 
-- "20.10.2017 8:10". Необходимо преобразовать поля к типу 
-- DATETIME, сохранив введеные ранее значения.

drop table if exists users;
create table users (
	id serial primary key,
	name varchar(255),
	birthday_at date,
	created_at varchar(16),
	updated_at varchar(16)
);

truncate users;
insert into users (name, birthday_at, created_at, updated_at) values
	('Геннадий', '1990-10-05', "20.10.2017 8:10", "20.10.2017 8:10"),
	('Наталья', '1984-11-12', "20.10.2017 8:10", "20.10.2017 8:10"),
	('Александр', '1985-05-20', "20.10.2017 8:10", "20.10.2017 8:10"),
	('Сергей', '1988-02-14', "20.10.2017 8:10", "20.10.2017 8:10"),
	('Иван', '1998-01-12', "20.10.2017 8:10", "20.10.2017 8:10"),
	('Мария', '1992-08-29', "20.10.2017 8:10", "20.10.2017 8:10");

select * from users;

create table temp (
	id serial primary key,
	name varchar(255),
	birthday_at date,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

insert into 
	temp
select 
	id, 
    name, 
	birthday_at, 
    str_to_date(created_at, "%d.%m.%Y %H:%i:00"), 
    str_to_date(updated_at, "%d.%m.%Y %H:%i:00")
from
	users;

select * from temp;

drop table users;
rename table temp to users;

select * from users;

-- Задание 1.3. В таблице складских запасов storehouses_products 
-- в поле value могут встречаться самые разные цифры: 0, если 
-- товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они 
-- выводились в порядке увеличения значения value. Однако, 
-- нулевые запасы должны выводиться в конце, после всех записей.
-- PS: честно слизал с разбора на уроке.

drop table if exists storehouses_products;
create table storehouses_products (
	id serial primary key,
	storehouse_id int unsigned,
	product_id int unsigned,
	value int unsigned,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp
);

insert into storehouses_products (storehouse_id, product_id, value) values
	(34, 12345, 0),
	(2345, 234, 65),
	(234, 257, 24),
	(234, 956, 0),
	(346, 43795, 348),
	(3465, 39587, 2345);
    
select
	*
from 
	storehouses_products
order by
	value = 0,
    value;

-- Задание 2.1. Подсчитайте средний возраст пользователей в таблице users.

select
	avg(timestampdiff(year, birthday_at, now()))
from
	users;

-- Задание 2.2. Подсчитайте количество дней рождения, которые приходятся 
-- на каждый из дней недели. Следует учесть, что необходимы дни недели 
-- текущего года, а не года рождения.

select
	weekday(adddate(birthday_at, interval year(now()) - year(birthday_at) year)) + 1 as week_day,
    count(id)
from
	users
group by
	week_day
order by
	week_day;