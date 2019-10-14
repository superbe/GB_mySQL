-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе +
-- самый пожилой пользователь в группе +
-- общее количество пользователей в группе +
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

USE vk;

-- Количество пользователей по группам.
SELECT
	communities.id,
	communities.name,
    count(profiles.user_id)
FROM communities
	JOIN communities_users
		ON communities_users.community_id = communities.id
	JOIN profiles
		ON profiles.user_id = communities_users.user_id
GROUP BY communities.id;

-- Общее количество пользователей в системе.
SELECT count(profiles.user_id) FROM profiles;

SELECT DISTINCT
	communities.name,
	COUNT(profiles.user_id) OVER() / COUNT(communities.id) OVER() AS average,
	MIN(profiles.birthday) OVER w AS min,
	MAX(profiles.birthday) OVER w AS max,
	COUNT(profiles.user_id) OVER w AS total_by_communities,
	COUNT(profiles.user_id) OVER() AS total,
	COUNT(profiles.user_id) OVER w / COUNT(profiles.user_id) OVER() * 100 AS "%%"
FROM (communities
	JOIN communities_users
		ON communities_users.community_id = communities.id
	JOIN profiles
		ON profiles.user_id = communities_users.user_id)
WINDOW w AS (PARTITION BY communities.id);