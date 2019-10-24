USE behest;

SET @login = 'nswift';

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
	NOT u.blocked AND u.name = @login;

