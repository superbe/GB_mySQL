use vk;

-- SELECT media.filename, target_types.name, COUNT(*) AS total_likes, CONCAT(first_name, ' ', last_name) AS owner
-- FROM media
-- 	JOIN likes
-- 		ON media.id = likes.target_id
-- 	JOIN target_types
-- 		ON likes.target_type_id = target_types.id
-- 	JOIN users
-- 		ON users.id = media.user_id
-- WHERE users.id = 2 AND target_types.id = 1
-- GROUP BY media.id;

-- Адаптировал под свою структуру данных (поля first_name и last_name вынесены profiles).
SELECT media.filename, target_types.name, COUNT(*) AS total_likes, CONCAT(profiles.first_name, ' ', profiles.last_name) AS owner
FROM media
	JOIN likes
		ON media.id = likes.target_id
	JOIN target_types
		ON likes.target_type_id = target_types.id
	JOIN profiles
		ON profiles.user_id = media.user_id
WHERE profiles.user_id = 2 AND target_types.id = 1
GROUP BY media.id;

SELECT
-- Путь к файлу
media.filename,
-- Тип файла 
target_types.name,
-- Количество лайков
COUNT(*) AS total_likes,
-- Собственник (ФИО)
CONCAT(profiles.first_name, ' ', profiles.last_name) AS owner
-- Выбрали из таблиц собранных по INNER JOIN
FROM media
	JOIN likes
		ON media.id = likes.target_id
	JOIN target_types
		ON likes.target_type_id = target_types.id
	JOIN profiles
		ON profiles.user_id = media.user_id
-- Фильтруем по конкретному пользователю и типу медиа (пользователя и тип подобрал, 
-- чтобы число было побольше)
WHERE profiles.user_id = 86 AND target_types.id = 2
-- Грппируем по идентификатору файла
GROUP BY media.id;

-- Получается запрос про то, сколько раз лайканули тот или иной медиа 
-- файл (в данном случа картинку) у того или иного пользователя.
-- Денормализацию можно осуществить по типу медиа добавлением  нового поля
-- по типу медиа в таблицу media. Для повышения скорости запроса можно в media
-- добавить счетчик лайков.

-- Сколько media есть у конкретного пользователя.

SELECT
	media.filename,
	CONCAT(profiles.first_name, ' ', profiles.last_name) AS owner
FROM media
	JOIN profiles
		ON profiles.user_id = media.user_id AND profiles.user_id = 86
GROUP BY media.id;
-- У пользователя всего две картинки.
-- 'images/970042c8813bd95cf951e4fe0ea646aa.jpg', 'Laron Runte'
-- 'images/05e22e814d295dee094a81a4207021ff.jpg', 'Laron Runte'

-- Посчитали все лайки медиа пользователя.
SELECT
	media.id,
	media.filename,
    COUNT(likes.id) AS total_likes,
	CONCAT(profiles.first_name, ' ', profiles.last_name) AS owner
FROM media
	JOIN profiles
		ON profiles.user_id = media.user_id AND profiles.user_id = 86
	LEFT JOIN likes
		ON media.id = likes.target_id
GROUP BY media.id;
-- '335', 'images/970042c8813bd95cf951e4fe0ea646aa.jpg', '0', 'Laron Runte'
-- '86', 'images/05e22e814d295dee094a81a4207021ff.jpg', '10', 'Laron Runte'

-- Из залайканого медиа из-за того, что данные тестовые получается распределение по разным типам объектов.
-- Из всех залайканых только 1 как медиа.
SELECT * FROM likes WHERE likes.target_id = 335 OR likes.target_id = 86;
-- '946', '58', '86', '2', '2019-10-03 00:12:20'
-- '251', '70', '86', '3', '2019-10-03 00:12:20'
-- '339', '48', '86', '3', '2019-10-03 00:12:20'
-- '780', '33', '86', '3', '2019-10-03 00:12:20'
-- '931', '36', '86', '3', '2019-10-03 00:12:20'
-- '103', '55', '86', '4', '2019-10-03 00:12:20'
-- '819', '25', '86', '4', '2019-10-03 00:12:20'
-- '619', '77', '86', '6', '2019-10-03 00:12:20'
-- '336', '42', '86', '7', '2019-10-03 00:12:20'
-- '758', '83', '86', '8', '2019-10-03 00:12:20'

-- Посчитали лайки с учетом типа медиа в лайках.
SELECT
	media.filename,
    COUNT(likes.id) AS total_likes,
	CONCAT(profiles.first_name, ' ', profiles.last_name) AS owner
FROM media
	JOIN profiles
		ON profiles.user_id = media.user_id AND profiles.user_id = 86
	LEFT JOIN likes
		ON media.id = likes.target_id AND likes.target_type_id = 2
GROUP BY media.id;
-- 'images/970042c8813bd95cf951e4fe0ea646aa.jpg', '0', 'Laron Runte'
-- 'images/05e22e814d295dee094a81a4207021ff.jpg', '1', 'Laron Runte'

-- Посчитали лайки с учетом типа медиа в лайках и выводом этого медиа.
SELECT 
	media.filename, 
    target_types.name, 
    COUNT(likes.id) AS total_likes, 
    CONCAT(profiles.first_name, ' ', profiles.last_name) AS owner
FROM media
	JOIN profiles
		ON profiles.user_id = media.user_id AND profiles.user_id = 86
	LEFT JOIN likes
		ON media.id = likes.target_id AND likes.target_type_id = 2
	LEFT JOIN target_types
		ON likes.target_type_id = target_types.id
GROUP BY media.id;
-- 'images/970042c8813bd95cf951e4fe0ea646aa.jpg', NULL, '0', 'Laron Runte'
-- 'images/05e22e814d295dee094a81a4207021ff.jpg', 'media', '1', 'Laron Runte'