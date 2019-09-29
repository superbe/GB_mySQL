-- Урок 6. Задание 1.
-- Проанализировать запросы, которые выполнялись на занятии, 
-- определить возможные корректировки и/или улучшения (JOIN пока не применять).

USE vk;

-- Обновляем данные для медиатипа.
update media_types set name = 'application' where id = 1;
update media_types set name = 'audio' where id = 2;
update media_types set name = 'example' where id = 3;
update media_types set name = 'image' where id = 4;
update media_types set name = 'message' where id = 5;
update media_types set name = 'model' where id = 6;
update media_types set name = 'multipart' where id = 7;
update media_types set name = 'text' where id = 8;
update media_types set name = 'video' where id = 9;


-- Задали переменную с именем пользователя.
SET @user_name = 'ashley.mccullough';

-- Определили идентификатор пользователя.
SET @user_id = (SELECT id FROM users WHERE name = @user_name);

-- Получаем данные пользователя.
SELECT 
	*
FROM
	users
WHERE
	id = @user_id;

SELECT
	first_name,
    last_name,
    'main_photo',
    'city'
FROM
	profiles
WHERE
	user_id = @user_id;


SELECT
	first_name,
	last_name,
	(SELECT
		filename
	FROM
		media
	WHERE
		id = (SELECT photo_id FROM profiles WHERE user_id = @user_id)
	) as filename,
	(SELECT
		hometown
	FROM
		profiles
	WHERE
		user_id = @user_id) as hometown
FROM
	profiles
WHERE
	user_id = @user_id;
    
-- Получаем фотографии пользователя    
SELECT * FROM media_types;

SELECT
	filename
FROM
	media
WHERE
	user_id = @user_id AND media_type_id = (SELECT id FROM media_types WHERE name = 'image');

-- Выбираем историю по добавлению фотографий пользователем
SELECT CONCAT(
	'Пользователь ', 
	(SELECT CONCAT(first_name, ' ', last_name) FROM profiles WHERE user_id = @user_id),
	' добавил фото ', 
	filename, ' ', 
	created_at) AS news 
FROM
	media 
WHERE user_id = @user_id AND media_type_id = (SELECT id FROM media_types WHERE name = 'image');

-- Найдём кому принадлежат 10 самых больших медиафайлов
SELECT 
	filename, 
	size,
	(SELECT CONCAT(first_name, ' ', last_name) FROM profiles u WHERE u.user_id = m.user_id) AS owner 
FROM
	media m
ORDER BY size DESC
LIMIT 10;

 -- Выбираем друзей пользователя
(SELECT friend_id FROM friendship WHERE user_id = @user_id)
UNION
(SELECT user_id FROM friendship WHERE friend_id = @user_id);

-- Выбираем только друзей с подтверждённым статусом

SELECT * FROM friendship_statuses;

(	SELECT
		friend_id 
	FROM
		friendship 
	WHERE
		user_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
)
UNION
(	SELECT
		user_id 
	FROM
		friendship 
	WHERE
		friend_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
);

-- Выбираем медиафайлы друзей
SELECT
	filename
FROM
	media
WHERE
	user_id IN ((
		SELECT
			friend_id 
		FROM
			friendship 
		WHERE
			user_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
	) UNION	(
		SELECT
			user_id 
		FROM
			friendship 
		WHERE
			friend_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
	)
);

-- Объединяем медиафайлы пользователя и его друзей для создания ленты новостей
SELECT
	filename, user_id, created_at 
FROM
	media WHERE user_id = @user_id
UNION
	SELECT
		filename, user_id, created_at 
	FROM
		media
	WHERE user_id IN ((
		SELECT
			friend_id 
		FROM
			friendship 
		WHERE
			user_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
	) UNION (
		SELECT
			user_id 
		FROM
			friendship 
		WHERE
			friend_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
	)
);

-- Определяем пользователей, общее занимаемое место медиафайлов которых превышает 30МБ.
SELECT
	user_id, SUM(size) AS total
FROM
	media
GROUP BY
	user_id
HAVING
	total > 30000000
ORDER BY
	total DESC;

-- Подсчитываем лайки для медиафайлов пользователя и его друзей
SELECT * FROM target_types;

SELECT
	target_id AS mediafile, COUNT(*) AS likes 
FROM
	likes 
WHERE target_id IN (
	SELECT
		id
	FROM
		media
	WHERE
		user_id = @user_id
        UNION
			SELECT
				id
			FROM
				media
			WHERE
				user_id IN ((
					SELECT
						friend_id 
					FROM
						friendship 
					WHERE user_id = @user_id AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
				) UNION (
					SELECT
						user_id 
					FROM
						friendship 
					WHERE user_id = @user_id AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
				))
	) AND target_type_id IN (1, 4, 5)
	GROUP BY target_id;
    
    --posts, communities, friendship, messages, profiles, media, users