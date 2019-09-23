drop database if exists examples;
create database examples;
use examples;

create table object_types (
    id int unsigned not null auto_increment primary key,
    name varchar(255) not null unique,
    created_at timestamp default current_timestamp
);

show tables;
desc object_types;
select * from object_types;
insert into object_types values (1, 'media', now());
select * from object_types;
insert into object_types (name) values ('media');
select * from object_types;
insert into object_types values (default, 'post', now());
select * from object_types;
insert into object_types (name) values ('newsline'), ('user');
select * from object_types;
insert ignore into object_types (name) values ('media');
select * from object_types;
insert into object_types set name = 'community';
select * from object_types;
replace into object_types (name) values ('community');
select * from object_types;
select all * from object_types;
select distinct * from object_types;
select year(created_at) from object_types;
select distinct year(created_at) from object_types;
select all * from object_types limit 1;
update object_types set id = id * 10; -- Не случилось (
select * from object_types;
update object_types set name = 'group' where name = 'community';
select * from object_types;
update object_types set name = 'group' where name = 'user';
update ignore object_types set name = 'group' where name = 'user';
select * from object_types;
show warnings;
delete from object_types where name = 'group';
select * from object_types;
delete from object_types limit 1;
select * from object_types;
delete from object_types; -- Не случилось (
select * from object_types;
insert into object_types values (default, 'media', now());
select * from object_types;
truncate object_types;
select * from object_types;
insert into object_types values (default, 'media', now());
select * from object_types;