DROP DATABASE IF EXISTS callcenter;
CREATE DATABASE callcenter;
USE callcenter;

CREATE TABLE calls(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор",
    ID_USER INT UNSIGNED NOT NULL COMMENT "Идентификатор пользователя",
    DT_CALL_START DATETIME NOT NULL COMMENT "Дата и время начала звонка",
    DT_CALL_END DATETIME NOT NULL COMMENT "Дата и время окончания звонка"
) COMMENT = "Звонки";

INSERT INTO calls (ID_USER, DT_CALL_START, DT_CALL_END) VALUES
(1, '2019-1-15 09:00:00',	'2019-1-15 09:02:00'),
(1, '2019-1-15 09:09:00',	'2019-1-15 09:09:00'),
(1, '2019-1-15 09:15:00',	'2019-1-15 09:20:00'),
(1, '2019-1-15 09:25:00',	'2019-1-15 09:28:00'),
(2, '2019-1-15 09:01:00',	'2019-1-15 09:01:00'),
(2, '2019-1-15 09:05:00',	'2019-1-15 09:05:00'),
(2, '2019-1-15 09:12:00',	'2019-1-15 09:16:00'),
(2, '2019-1-15 09:18:00',	'2019-1-15 09:22:00'),
(2, '2019-1-15 09:29:00',	'2019-1-15 09:29:00'),
(3, '2019-1-15 09:05:00',	'2019-1-15 09:07:00'),
(3, '2019-1-15 09:12:00',	'2019-1-15 09:15:00'),
(3, '2019-1-15 09:17:00',	'2019-1-15 09:20:00'),
(3, '2019-1-15 09:25:00',	'2019-1-15 09:30:00'),
(3, '2019-1-15 09:35:00',	'2019-1-15 09:36:00'),
(4, '2019-1-15 09:04:00',	'2019-1-15 09:05:00'),
(4, '2019-1-15 09:05:00',	'2019-1-15 09:06:00'),
(4, '2019-1-15 09:14:00',	'2019-1-15 09:14:00'),
(4, '2019-1-15 09:18:00',	'2019-1-15 09:19:00');

-- Вариант Сергея.
SELECT * 
  FROM calls c1
       LEFT JOIN calls c2
         ON c1.ID_USER != c2.ID_USER
        AND ((c1.DT_CALL_START > c2.DT_CALL_START AND c1.DT_CALL_END > c2.DT_CALL_END AND c1.DT_CALL_START < c2.DT_CALL_END)
         OR   (c1.DT_CALL_START < c2.DT_CALL_START AND c1.DT_CALL_END < c2.DT_CALL_END AND c1.DT_CALL_END > c2.DT_CALL_START)
         OR   (c1.DT_CALL_START < c2.DT_CALL_START AND c1.DT_CALL_END > c2.DT_CALL_END )
         OR   (c1.DT_CALL_START >c2.DT_CALL_START AND c1.DT_CALL_END < c2.DT_CALL_END )
);


DELIMITER //
CREATE FUNCTION counter (tg_id int)
RETURNS INT DETERMINISTIC
BEGIN
	SET @result = (
    SELECT COUNT(res.ID_USER) FROM (
    SELECT DISTINCT
		tg.ID_USER AS ID_USER
	FROM calls tg
		LEFT JOIN calls src
		ON src.id = tg_id
	WHERE
		(tg.DT_CALL_START BETWEEN src.DT_CALL_START AND src.DT_CALL_END) OR
		(tg.DT_CALL_END BETWEEN src.DT_CALL_START AND src.DT_CALL_END) OR
        (src.DT_CALL_START BETWEEN tg.DT_CALL_START AND tg.DT_CALL_END) OR
		(src.DT_CALL_END BETWEEN tg.DT_CALL_START AND tg.DT_CALL_END)
	GROUP BY tg.ID_USER
	) AS res);
    RETURN @result;
END//

CREATE FUNCTION empty_time (id_1 int, id_2 int)
RETURNS INT DETERMINISTIC
BEGIN
	-- id_2 больше id_1 всегда.
	IF id_1 < 1
    THEN
		SET @result = 0;
    ELSE
		SET @result = (SELECT
			(unix_timestamp(tg.DT_CALL_START) - unix_timestamp(src.DT_CALL_END))/60 AS Del
		FROM calls tg
			JOIN calls src
				ON src.id = id_1 AND tg.id = id_2
		LIMIT 1);
    END IF;
    IF @result < 0
    THEN
		SET @result = 0;
	END IF;
    RETURN @result;
END//
DELIMITER ;

-- Максимальное количество одновременно занятых сотрудников.
SELECT id, ID_USER, counter(id) AS cnt FROM calls ORDER BY cnt DESC LIMIT 1;
-- Среднее время ожидания звонка.
SELECT AVG(empty_time(id - 1, id)) AS empty_time FROM calls;
-- Оба запроса вместе.
SELECT (SELECT counter(id) AS cnt FROM calls ORDER BY cnt DESC LIMIT 1) AS max, (SELECT AVG(empty_time(id - 1, id)) AS empty_time FROM calls) AS no_job;
-- Оба запроса вместе (через CONCAT).
SELECT CONCAT('Максимальное количество одновременно занятых сотрудников: ', (SELECT counter(id) AS cnt FROM calls ORDER BY cnt DESC LIMIT 1), '. Среднее время ожидания звонка: ', (SELECT AVG(empty_time(id - 1, id)) AS empty_time FROM calls)) AS cntc;