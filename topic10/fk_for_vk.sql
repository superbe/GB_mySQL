-- База данных VK.
use vk;

-- Таблица ролей пользователя.
show create table user_roles;

ALTER TABLE user_roles
DROP FOREIGN KEY user_roles_ibfk_1;

ALTER TABLE user_roles
DROP FOREIGN KEY user_roles_ibfk_2;

ALTER TABLE user_roles
ADD CONSTRAINT user_roles_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE user_roles
ADD CONSTRAINT user_roles_ibfk_2
FOREIGN KEY (role_id)
REFERENCES roles (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица медиафайлов.
show create table media;

ALTER TABLE media
DROP FOREIGN KEY media_ibfk_1;

ALTER TABLE media
DROP FOREIGN KEY media_ibfk_2;

ALTER TABLE media
ADD CONSTRAINT media_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE media
ADD CONSTRAINT media_ibfk_2
FOREIGN KEY (media_type_id)
REFERENCES media_types (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица профилей пользователя.
show create table profiles;

ALTER TABLE profiles
DROP FOREIGN KEY profiles_ibfk_1;

ALTER TABLE profiles
DROP FOREIGN KEY profiles_ibfk_2;

ALTER TABLE profiles
DROP FOREIGN KEY profiles_ibfk_3;

ALTER TABLE profiles
ADD CONSTRAINT profiles_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE profiles
ADD CONSTRAINT profiles_ibfk_2
FOREIGN KEY (region_id)
REFERENCES regions (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE profiles
ADD CONSTRAINT profiles_ibfk_3
FOREIGN KEY (photo_id)
REFERENCES media (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица сообщений.
show create table messages;

ALTER TABLE messages
DROP FOREIGN KEY messages_ibfk_1;

ALTER TABLE messages
DROP FOREIGN KEY messages_ibfk_2;

ALTER TABLE messages
ADD CONSTRAINT messages_ibfk_1
FOREIGN KEY (from_user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE messages
ADD CONSTRAINT messages_ibfk_2
FOREIGN KEY (to_user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица дружбы.
show create table friendship;

ALTER TABLE friendship
DROP FOREIGN KEY friendship_ibfk_1;

ALTER TABLE friendship
DROP FOREIGN KEY friendship_ibfk_2;

ALTER TABLE friendship
DROP FOREIGN KEY friendship_ibfk_3;

ALTER TABLE friendship
ADD CONSTRAINT friendship_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE friendship
ADD CONSTRAINT friendship_ibfk_2
FOREIGN KEY (friend_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE friendship
ADD CONSTRAINT friendship_ibfk_3
FOREIGN KEY (status_id)
REFERENCES friendship_statuses (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица связей пользователей и групп.
show create table communities_users;

ALTER TABLE communities_users
DROP FOREIGN KEY communities_users_ibfk_1;

ALTER TABLE communities_users
DROP FOREIGN KEY communities_users_ibfk_2;

ALTER TABLE communities_users
ADD CONSTRAINT communities_users_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE communities_users
ADD CONSTRAINT communities_users_ibfk_2
FOREIGN KEY (community_id)
REFERENCES communities (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица лайков.
show create table likes;

ALTER TABLE likes
DROP FOREIGN KEY likes_ibfk_1;

ALTER TABLE likes
DROP FOREIGN KEY likes_ibfk_2;

ALTER TABLE likes
ADD CONSTRAINT likes_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE likes
ADD CONSTRAINT likes_ibfk_2
FOREIGN KEY (target_type_id)
REFERENCES target_types (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;


-- Таблица новостей пользователя.
show create table posts;

ALTER TABLE posts
DROP FOREIGN KEY posts_ibfk_1;

ALTER TABLE posts
DROP FOREIGN KEY posts_ibfk_2;

ALTER TABLE posts
ADD CONSTRAINT posts_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE posts
ADD CONSTRAINT posts_ibfk_2
FOREIGN KEY (communitie_id)
REFERENCES communities (id)
ON DELETE NO ACTION
ON UPDATE CASCADE;