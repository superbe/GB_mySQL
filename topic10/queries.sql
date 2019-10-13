-- Индексируем справочник состояния дружбы пользователей.
DROP INDEX friendship_statuses_name_uq ON friendship_statuses;
CREATE UNIQUE INDEX friendship_statuses_name_uq ON friendship_statuses(name);

-- Индексируем справочник типа медиа.
DROP INDEX media_types_name_uq ON media_types;
CREATE UNIQUE INDEX media_types_name_uq ON media_types(name);

-- Индексируем справочник типа целевого объекта.
DROP INDEX target_types_name_uq ON target_types;
CREATE UNIQUE INDEX target_types_name_uq ON target_types(name);

-- Индексируем медиа.
-- DROP INDEX media_user_id_media_type_id_idx ON media;
-- CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);

-- Индексируем медиа.
DROP INDEX media_created_at_idx ON media;
CREATE INDEX media_created_at_idx ON media(created_at);

-- Индексируем профиль пользователя.
DROP INDEX profiles_first_name_last_name_idx ON profiles;
CREATE INDEX profiles_first_name_last_name_idx ON profiles(first_name, last_name);

-- Индексируем профиль пользователя.
DROP INDEX profiles_birthday_idx ON profiles;
CREATE INDEX profiles_birthday_idx ON profiles(birthday);

-- Индексируем профиль пользователя.
DROP INDEX profiles_hometown_idx ON profiles;
CREATE INDEX profiles_hometown_idx ON profiles(hometown);

-- Индексируем друзей пользователя.
DROP INDEX friendship_user_id_confirmed_at_status_id_idx ON friendship;
CREATE INDEX friendship_user_id_confirmed_at_status_id_idx ON friendship(user_id, confirmed_at, status_id);

-- Индексируем друзей пользователя.
-- DROP INDEX friendship_friend_id_confirmed_at_status_id_idx ON friendship;
-- CREATE INDEX friendship_friend_id_confirmed_at_status_id_idx ON friendship(friend_id, confirmed_at, status_id);

-- Индексируем друзей лайки.
DROP INDEX likes_target_id_target_type_id_idx ON likes;
CREATE INDEX likes_target_id_target_type_id_idx ON likes(target_id, target_type_id);

-- Индексируем лайки друзей.
-- DROP INDEX likes_user_id_idx ON likes;
-- CREATE INDEX likes_user_id_idx ON likes(user_id);

-- Индексируем сообщения.
DROP INDEX messages_from_user_id_to_user_id_created_at_idx ON messages;
CREATE INDEX messages_from_user_id_to_user_id_created_at_idx ON messages(from_user_id, to_user_id, created_at);

-- Индексируем сообщения.
DROP INDEX messages_from_user_id_to_user_id_delivered_created_at_idx ON messages;
CREATE INDEX messages_from_user_id_to_user_id_delivered_created_at_idx ON messages(from_user_id, to_user_id, delivered, created_at);

-- Индексируем учетную запись пользователя.
DROP INDEX users_name_idx ON users;
CREATE INDEX users_name_idx ON users(name);

-- Индексируем учетную запись пользователя.
DROP INDEX users_email_uq ON users;
CREATE UNIQUE INDEX users_email_uq ON users(email);

-- Индексируем группы пользователя.
-- DROP INDEX communities_users_user_id_idx ON communities_users;
-- CREATE INDEX communities_users_user_id_idx ON communities_users(user_id);

-- Индексируем посты пользователя.
-- DROP INDEX posts_user_id_idx ON posts;
-- CREATE INDEX posts_user_id_idx ON posts(user_id);