-- Урок 6. Задание 1.
-- Проанализировать запросы, которые выполнялись на занятии, 
-- определить возможные корректировки и/или улучшения (JOIN пока не применять).

USE vk;

-- Нашли пользователей с большим количеством картинок.
SELECT 
	user_id,
    count(user_id) as count_user_id
FROM
	media 
Where
	media_type_id = (SELECT id FROM media_types WHERE name = 'image')
group by
	user_id
order by
	count_user_id desc;

-- Задали переменную с именем пользователя.
SET @user_name = 'rkihn';

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
					WHERE friend_id = @user_id AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
				))
	) AND target_type_id IN (2, 3, 8, 10)
	GROUP BY target_id;
    
SELECT 
	* 
FROM
	likes 
WHERE
	target_id = @user_id AND target_type_id IN (2, 3, 8, 10) 
ORDER BY
	target_type_id;
    
-- Архив с правильной сортировкой новостей по месяцам
SELECT
	COUNT(id) AS news,
    MONTHNAME(created_at) AS month_news
FROM
	media
WHERE
	YEAR(created_at) = YEAR(NOW())
GROUP BY
	month_news
ORDER BY
	MONTH(month_news) DESC;
    
-- Выбираем сообщения от пользователя и к пользователю
SELECT
	from_user_id, to_user_id, body, delivered, created_at 
FROM
	messages
WHERE
	from_user_id = @user_id OR to_user_id = @user_id
ORDER BY
	created_at DESC;
    
-- Непрочитанные сообщения
SELECT
	from_user_id, to_user_id, body, 
	IF(delivered, 'delivered', 'not delivered') AS status 
FROM
	messages
WHERE
	(from_user_id = @user_id OR to_user_id = @user_id) AND delivered IS NOT TRUE
ORDER BY
	created_at DESC;
    
-- Выводим друзей пользователя с преобразованием пола и возраста 
SELECT 
	CONCAT(first_name, ' ', last_name) AS friend, 
	CASE (sex)
		WHEN 'm' THEN 'man'
		WHEN 'f' THEN 'women'
	END AS sex,
    TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age
FROM
	profiles
WHERE
	user_id IN (
	(
		SELECT
			friend_id 
		FROM
			friendship 
		WHERE user_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
	) UNION (
		SELECT
			user_id 
		FROM
			friendship 
		WHERE friend_id = @user_id AND confirmed_at IS NOT NULL AND status_id = (SELECT id FROM friendship_statuses WHERE name = 'friend')
	)          
);

-- Поиск пользователя по шаблонам имени  
SELECT
	CONCAT(first_name, ' ', last_name) AS fullname  
FROM
	profiles
HAVING
	fullname LIKE 'M%';
  
-- Используем регулярные выражения
SELECT
	CONCAT(first_name, ' ', last_name) AS fullname  
FROM
	profiles
HAVING
	fullname RLIKE '^M.*s$';
    
-- Урок 6. Задание 2.
-- Пусть задан некоторый пользователь.
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Задали переменную с именем пользователя.
SET @user_name = 'fpagac';

-- Определили идентификатор пользователя.
SET @user_id = (SELECT id FROM users WHERE name = @user_name);

SELECT
	from_user_id, to_user_id, body, delivered, created_at 
FROM
	messages
WHERE
    (from_user_id = 67 and  to_user_id IN ((
		SELECT
			friend_id 
		FROM
			friendship 
		WHERE user_id = 67 AND confirmed_at IS NOT NULL
	) UNION (
		SELECT
			user_id 
		FROM
			friendship 
		WHERE friend_id = 67 AND confirmed_at IS NOT NULL
	)))
	OR (to_user_id = 67 and  from_user_id IN ((
		SELECT
			friend_id 
		FROM
			friendship 
		WHERE user_id = 67 AND confirmed_at IS NOT NULL
	) UNION (
		SELECT
			user_id 
		FROM
			friendship 
		WHERE friend_id = 67 AND confirmed_at IS NOT NULL
	)))
;
	


SELECT 
	*
FROM
	profiles
WHERE
	user_id IN (
	(
		SELECT
			friend_id 
		FROM
			friendship 
		WHERE user_id = @user_id AND confirmed_at IS NOT NULL
	) UNION (
		SELECT
			user_id 
		FROM
			friendship 
		WHERE friend_id = @user_id AND confirmed_at IS NOT NULL
	)          
);