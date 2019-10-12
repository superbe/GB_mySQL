USE vk;

-- Задали переменную с именем пользователя.
SET @user_name = 'fpagac';

-- Определили идентификатор пользователя.
SET @user_id = (SELECT id FROM users WHERE name = @user_name);

-- Урок 6. Задание 2.
-- Пусть задан некоторый пользователь.
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Не совсем понял как "Оформить такие сложные условия стоит более структурированно".

SELECT
	CONCAT('Самый болтливый друг: ', p.first_name, ' ', p.last_name) AS chatterer
FROM
	profiles p	JOIN
		messages m JOIN
			friendship f
			ON 
				(m.to_user_id = p.user_id AND (m.from_user_id = @user_id AND ((f.user_id = m.to_user_id AND f.friend_id = @user_id) OR (f.user_id = @user_id AND f.friend_id = m.to_user_id))))
			OR 
				(m.from_user_id = p.user_id AND (m.to_user_id = @user_id and ((f.user_id = m.from_user_id AND f.friend_id = @user_id) OR (f.user_id = @user_id AND f.friend_id = m.from_user_id))))
GROUP BY 
	p.user_id
ORDER BY 
	count(p.user_id) DESC
LIMIT 1;

-- Урок 6. Задание 3.
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT
	SUM(cnt)
FROM
	(SELECT 
		COUNT(p.user_id) AS cnt
	FROM 
			likes l
		JOIN
			profiles p
		JOIN
			target_types tt
		ON
			l.target_id = p.user_id AND l.target_type_id = tt.id AND tt.name = 'users'
	GROUP BY 
		p.user_id
	ORDER BY 
		p.birthday DESC
	LIMIT 10) AS res;

-- Исправленное.

SELECT
	SUM(cnt)
FROM (
	SELECT COUNT(DISTINCT l.user_id) AS cnt
	FROM profiles p
		LEFT JOIN likes l
			ON l.target_id = p.user_id            
		JOIN target_types tt
			ON l.target_type_id = tt.id AND tt.name = 'users'
	GROUP BY p.user_id
	ORDER BY p.birthday DESC
	LIMIT 10
) AS res;

-- Урок 6. Задание 4.
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	p.sex, COUNT(p.sex) AS cnt
FROM profiles p
    JOIN likes l
		ON l.user_id = p.user_id
GROUP BY p.sex
ORDER BY cnt DESC
LIMIT 1;   

-- Урок 6. Задание 5.
-- Найти 10 пользователей, которые проявляют наименьшую 
-- активность в использовании социальной сети.

SELECT
	p.user_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name
FROM
		profiles p
    JOIN
		media m
    JOIN
		messages ms
    JOIN
		friendship f
    JOIN
		communities_users cu
    JOIN
		likes l
    JOIN
		posts ps
    ON
		p.user_id = m.user_id OR
        p.user_id = ms.from_user_id OR
        p.user_id = f.user_id OR
        p.user_id = cu.user_id OR
        p.user_id = l.user_id OR
        p.user_id = p.user_id
GROUP BY
	p.user_id
ORDER BY 
	COUNT(p.user_id)
LIMIT 10;

-- Исправленное. Ошибка была в строке p.user_id = p.user_id (строка 108), надо было p.user_id = ps.user_id

SELECT
	p.user_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    COUNT(p.user_id) AS count
FROM profiles p
    LEFT JOIN media m
		ON p.user_id = m.user_id
    LEFT JOIN messages ms
	 	ON p.user_id = ms.from_user_id
    LEFT JOIN friendship f
	 	ON p.user_id = f.user_id
    LEFT JOIN communities_users cu
	 	ON p.user_id = cu.user_id
    LEFT JOIN likes l
	 	ON p.user_id = l.user_id
    LEFT JOIN posts ps
	 	ON p.user_id = ps.user_id
GROUP BY
	p.user_id
ORDER BY 
	count
LIMIT 10;