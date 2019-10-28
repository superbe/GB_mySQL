USE behest;

-- Проверяем заполненность таблиц.
SELECT * FROM roles;
SELECT * FROM users;
SELECT * FROM user_roles;
SELECT * FROM media_types;
SELECT * FROM files;
SELECT * FROM media;
SELECT * FROM city;
SELECT * FROM profiles;
SELECT * FROM classifier;
SELECT * FROM business;
SELECT * FROM organization;
SELECT * FROM cards;
SELECT * FROM keywords;
SELECT * FROM card_keywords;
SELECT * FROM classifier_cards;
SELECT * FROM card_ciphers;
SELECT * FROM publication_type;
SELECT * FROM personalities;
SELECT * FROM publications;
SELECT * FROM tracker_points;
SELECT * FROM behests;
SELECT * FROM other_publications;
SELECT * FROM documents;
SELECT * FROM authors;
SELECT * FROM pages;
SELECT * FROM reference_pages;


SET @login = 'nswift';

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