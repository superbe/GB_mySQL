-- Создаем базу данных VK.
drop database if exists vk;
create database vk;
use vk;

-- Создаем справочник ролей пользователей.
drop table if exists roles;
create table roles (
    id int unsigned not null auto_increment primary key,
    name varchar(256) not null,
    created_at timestamp,
    updated_at timestamp default current_timestamp
);

-- Создаем таблицу зарегистрированных пользователей.
drop table if exists users;
create table users (
    id int unsigned not null auto_increment primary key,
    name varchar(256) not null,
    email varchar(256) not null,
    email_confirmed bit not null,
    phone varchar(64) not null,
    phone_confirmed bit not null,
    password_hash varchar(1024),
    blocked bit not null,
    created_at timestamp,
    updated_at timestamp default current_timestamp
);

-- Создаем таблицу ролей пользователя.
drop table if exists user_roles;
create table user_roles (
    user_id int unsigned not null,
    role_id int unsigned not null,
    primary key (user_id, role_id),
    foreign key (user_id) references users (id),
    foreign key (role_id) references roles (id)
);

-- Таблица типов медиафайлов
drop table if exists media_types;
create table media_types (
    id int unsigned not null auto_increment primary key,
    name varchar(255) not null unique,
    created_at timestamp,
    updated_at timestamp default current_timestamp
);

-- Таблица медиафайлов
drop table if exists media;
create table media (
    id int unsigned not null auto_increment primary key,
    media_type_id int unsigned not null,
    user_id int unsigned not null,
    filename varchar(255) not null,
    size int not null,
    metadata JSON,
    created_at timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (user_id) references users (id),
    foreign key (media_type_id) references media_types (id)
);

-- Таблица профилей пользователя.
drop table if exists profiles;
create table profiles (
    user_id int unsigned not null primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    sex char(1) not null,
    birthday date,
    hometown varchar(100),
    photo_id int unsigned not null,
    created_at timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (user_id) references users (id),
    foreign key (photo_id) references media (id)
);

-- Таблица сообщений
drop table if exists messages;
create table messages (
    id int unsigned not null auto_increment primary key, 
    from_user_id int unsigned not null,
    to_user_id int unsigned not null,
    body text not null,
    important boolean,
    delivered boolean,
    created_at timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (from_user_id) references users (id),
    foreign key (to_user_id) references users (id)
);

-- Таблица статусов дружеских отношений
drop table if exists friendship_statuses;
create table friendship_statuses (
    id int unsigned not null auto_increment primary key,
    name varchar(150) not null unique,
    created_at timestamp,
    updated_at timestamp default current_timestamp
);

-- Таблица дружбы
drop table if exists friendship;
create table friendship (
    user_id int unsigned not null,
    friend_id int unsigned not null,
    status_id int unsigned not null,
    requested_at datetime default now(),
    confirmed_at datetime,
    primary key (user_id, friend_id),
    foreign key (user_id) references users (id),
    foreign key (friend_id) references users (id),
    foreign key (status_id) references friendship_statuses (id)
);

-- Таблица групп
drop table if exists communities;
create table communities (
    id int unsigned not null auto_increment primary key,
    name varchar(150) not null unique,
    created_at timestamp,
    updated_at timestamp default current_timestamp
);

-- Таблица связи пользователей и групп
drop table if exists communities_users;
create table communities_users (
    community_id int unsigned not null,
    user_id int unsigned not null,
    primary key (community_id, user_id),
    foreign key (user_id) references users (id),
    foreign key (community_id) references communities (id)
);

-- Типы объектов рейтинга.
drop table if exists object_type;
create table object_type (
    id int unsigned not null auto_increment primary key,
    name varchar(256) not null,
    created_at timestamp,
    updated_at timestamp default current_timestamp
);

-- Лайки.
drop table if exists likes;
create table likes (
    object_id int unsigned not null,
    object_type_id int unsigned not null,
    user_id int unsigned not null,
    value int null,
    primary key (object_id, object_type_id, user_id),
    foreign key (user_id) references users (id),
    foreign key (object_type_id) references object_type (id)
);