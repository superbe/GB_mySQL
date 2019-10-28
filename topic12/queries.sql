USE behest;

-- Проверяем заполненность таблиц.
SELECT * FROM roles;				-- Роли (Справочник)
SELECT * FROM users;				-- Пользователи (Служебный объект)
SELECT * FROM user_roles;			-- Роли пользователя (Справочник)
SELECT * FROM media_types;			-- Типы медиа (Справочник)
SELECT * FROM files;				-- Файлы (Справочник)
SELECT * FROM media;				-- Медиа (Выборка медиа по собственнику) +
SELECT * FROM city;					-- Города (Справочник)
SELECT * FROM profiles;				-- Профиль пользователя (Простой список пользователей; Выборка профиля пользователя) ++
SELECT * FROM classifier;			-- Классификатор (Справочник)
SELECT * FROM business;				-- Тип деятельности организации (Справочник)
SELECT * FROM organization;			-- Организация (Справочник)
SELECT * FROM cards;				-- Каталожная карточка (Список каталожных карточек) +
SELECT * FROM keywords;				-- Ключевые слова (Справочник)
SELECT * FROM card_keywords;		-- Ключевые слова каталожной карточки (Справочник)
SELECT * FROM classifier_cards;		-- Каталожные карточки раздела классификатора (Служебный объект)
SELECT * FROM card_ciphers;			-- Шифры издания (Служебный объект)
SELECT * FROM publication_type;		-- Тип публикации (Справочник)
SELECT * FROM personalities;		-- Персоналии (Справочник)
SELECT * FROM publications;			-- Публикация (Полный профиль публикации) +
SELECT * FROM tracker_points;		-- Трекер публикации (Служебный объект)
SELECT * FROM behests;				-- Памятник (Список памятников; Конкретный памятник) аналогично каталожной карточке или публикации
SELECT * FROM other_publications;	-- Другие публикации (Список)
SELECT * FROM documents;			-- Документ публикации (Текстовая выборка) выборка по документу
SELECT * FROM authors;				-- Авторы публикации (Справочник)
SELECT * FROM pages;				-- Страницы публикации (Список)
SELECT * FROM reference_pages;		-- Ссылки на связанные страницы (Список)

SET @login = 'nswift';

-- Выборка медиа по собственнику
SELECT
	m.id AS id,
    m.name AS name,
    mt.name AS type,
    CONCAT(p.last_name, ' ', p.first_name, ' ', p.middle_name) AS full_name
FROM
	media m
	JOIN profiles p
		ON p.user_id = m.user_id
	JOIN media_types mt
		ON mt.id = m.media_type_id
    JOIN users u
		ON u.id = p.user_id
 WHERE u.name = @login;

-- Список пользователей.
SELECT 
	p.user_id AS id,
	CONCAT(p.last_name, ' ', p.first_name, ' ', p.middle_name) AS fullname,
    p.birthday AS birthday,
    c.name AS city,
    u.email AS email,
    u.phone AS phone
FROM 
	profiles p
    LEFT JOIN city c
		ON c.id = p.city_id
    JOIN users u
		ON u.id = p.user_id;

-- Получить сведения о пользователе.
DROP VIEW IF EXISTS get_profile;
CREATE VIEW get_profile AS 
SELECT
	p.user_id AS id,
	CONCAT(p.last_name, ' ', p.first_name, ' ', p.middle_name) AS fullname,
	(CASE 
		WHEN p.gender = 'f' THEN 'жен'
        ELSE 'муж'
    END) AS gender,
    p.birthday AS birthday,
    c.name AS city,
    f.file_name AS filename,
    m.name AS phototitle,
    m.description AS description,
    u.name AS login,
    p.metadata AS metadata,
    u.email AS email,
    u.phone AS phone
FROM 
	profiles p
    LEFT JOIN city c
		ON c.id = p.city_id
    LEFT JOIN media m
		ON m.id = p.photo_id
    LEFT JOIN files f
		ON m.files_hash = f.hash
    LEFT JOIN users u
		ON u.id = p.user_id
WHERE
	NOT u.blocked;

SELECT * FROM get_profile WHERE login = @login;

-- Список каталожных карточек

SET @classifier_id = 101;

SELECT
	c.id AS id,
    c.title AS title,
    c.bibliographic_description AS description,
    org.name AS organization,
    c.created_at AS created_date,
    cc.classifier_id AS classifier_id
FROM cards AS c
	JOIN organization AS org
		ON org.id = c.organization_id
	JOIN classifier_cards AS cc
		ON c.id = cc.card_id
WHERE
	cc.classifier_id = @classifier_id;

SET @card_id = 5;

-- Выгрузить список ключевых слов для конкретной каталожной карточки.
SELECT 
	k.id AS id,
	k.word AS word
FROM card_keywords AS ck
	JOIN keywords AS k
		ON k.id = ck.keyword_id
WHERE
	ck.card_id = @card_id;

-- Выгрузить каталожные карточки по ключевому слову.
SELECT
	c.id AS id,
    c.title AS title,
    c.bibliographic_description AS description,
    org.name AS organization,
    c.created_at AS created_date
FROM cards AS c
	JOIN organization AS org
		ON org.id = c.organization_id
	JOIN card_keywords AS ck
		ON c.id = ck.card_id
	JOIN keywords AS k
		ON k.id = ck.keyword_id AND k.word = 'sint';

-- Выгрузить список шифров документов и сиглов библиотек.
SELECT 
	id,
	cipher
FROM card_ciphers
WHERE
	card_id = @card_id;

SET @cipher = 280246; 
  
-- Выгрузить каталожные карточки по шифру документа или сигле библиотеки.
SELECT
	c.id AS id,
    c.title AS title,
    c.bibliographic_description AS description,
    org.name AS organization,
    c.created_at AS created_date
FROM cards AS c
	JOIN organization AS org
		ON org.id = c.organization_id
	JOIN card_ciphers AS cc
		ON c.id = cc.card_id AND cc.cipher = @cipher;   
        
-- Поиск по слову.
SELECT
	c.id AS id,
    c.title AS title,
    c.bibliographic_description AS description,
    org.name AS organization,
    c.created_at AS created_date
FROM cards AS c
	JOIN organization AS org
		ON org.id = c.organization_id 
WHERE title LIKE '%Проблемы%';

-- Полный профиль публикации
SELECT
	c.id AS id,
    c.title AS title,
    c.bibliographic_description AS description,
    org.name AS organization,
    c.created_at AS created_date,
    cc.classifier_id AS classifier_id,
    p.circumstances AS circumstances,
    pt.name AS publication_type,
    doc.owner AS owner,
    doc.author AS author,
    doc.title AS title,
    doc.annotation AS annotation
FROM cards AS c
	JOIN organization AS org
		ON org.id = c.organization_id
	JOIN classifier_cards AS cc
		ON c.id = cc.card_id
	JOIN publications AS p
		ON c.id = p.card_id
	JOIN publication_type AS pt
		ON pt.id = p.publication_type_id
	JOIN documents AS doc
		ON doc.publication_id = p.card_id
WHERE
	c.id = @card_id;