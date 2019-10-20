-- База данных behest (сайт "Наследие")
-- Требования в Требования.txt
-- Здесь минимум, поэтому решил пока не переносить в отдельный репозиторий.
-- Сделаю здесь, позже перенесу и буду дорабатывать.
-- В папке "Нормативная база" некоторые нормативные и справочные источники.

drop database if exists behest;
create database behest;
use behest;

-- Роли пользователя определяют права доступа к разделам сайта.
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор роли",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Наименование роли",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи"
) COMMENT = "Роли пользователя в системе";

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор учетной записи пользователя",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Наименование учетной записи пользователя",
    email VARCHAR(255) NOT NULL UNIQUE COMMENT "Электронная почта пользователя",
    email_confirmed BIT NOT NULL DEFAULT 0 COMMENT "Подтвержение электронной почты пользователя",
    phone VARCHAR(64) NOT NULL COMMENT "Телефон пользователя",
    phone_confirmed BIT NOT NULL DEFAULT 0 COMMENT "Подтвержение телефона пользователя",
    password_hash VARCHAR(1024) COMMENT "Хэш пароля пользователя",
    blocked BIT NOT NULL DEFAULT 0 COMMENT "Блокировка учетной записи пользователя",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи"
) COMMENT = "Учетная запись пользователя";

DROP TABLE IF EXISTS user_roles;
CREATE TABLE user_roles (
    user_id INT UNSIGNED NOT NULL COMMENT "Идентификатор учетной записи пользователя",
    role_id INT UNSIGNED NOT NULL COMMENT "Идентификатор роли",
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT user_roles_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT user_roles_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE NO ACTION ON UPDATE CASCADE
) COMMENT = "Назначение роли учетной записи пользователя";

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор типа медиа файла",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Наименование типа медиа файла",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи"
) COMMENT = "Типы медиа файлов";

-- После загрузки файла высчитываем хэш файла. Если такой хэш уже присутствует в базе, 
-- значит этот файл уже закачивался, поэтому файл не сохраняем на сетевой ресурс. 
-- В любом случае в таблицу media передаем хэш файла.
DROP TABLE IF EXISTS files;
CREATE TABLE files (
    hash VARCHAR(128) NOT NULL PRIMARY KEY COMMENT "Хэш медиа файла",
    file_name VARCHAR(255) NOT NULL UNIQUE COMMENT "Путь медиа файла",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи"
) COMMENT = "Путь к файлу";

DROP TABLE IF EXISTS media;
CREATE TABLE media (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор медиа файла",
    media_type_id INT UNSIGNED NOT NULL COMMENT "Идентификатор типа медиа файла",
    user_id INT UNSIGNED NOT NULL COMMENT "Идентификатор собственника медиа файла",
    size INT UNSIGNED NOT NULL COMMENT "Размер медиа файла",
    metadata JSON COMMENT "Метаданные медиа файла",
    files_hash VARCHAR(128) NOT NULL COMMENT "Идентификатор файла",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи",
    CONSTRAINT media_media_type_id_fk FOREIGN KEY (media_type_id) REFERENCES media_types (id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT media_files_hash_fk FOREIGN KEY (files_hash) REFERENCES files (hash) ON DELETE NO ACTION ON UPDATE CASCADE
) comment = "Метаданные медиа файла";

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор пользователя",
    last_name VARCHAR(100) NOT NULL COMMENT "Фамилия",
    first_name VARCHAR(100) NOT NULL COMMENT "Имя",
    middle_name VARCHAR(100) NOT NULL COMMENT "Отчество",
    gender CHAR(1) NOT NULL COMMENT "Пол",
    birthday DATE COMMENT "Дата рождения",
    hometown VARCHAR(100) COMMENT "Город",
    photo_id INT UNSIGNED NOT NULL COMMENT "Идентификатор аватарки",
    metadata JSON COMMENT "Метаданные профиля пользователя",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи",
    CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT profiles_photo_id_fk FOREIGN KEY (photo_id) REFERENCES media (id) ON DELETE NO ACTION ON UPDATE CASCADE
) comment = "Профиль пользователя";

-- Делаю пока только один классификатор. Для простоты выбрал ББК, так как данные проще обработать.
DROP TABLE IF EXISTS BBK;
CREATE TABLE BBK (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор раздела классификатора ББК",
    name VARCHAR(255) NOT NULL COMMENT "Наименование раздела классификатора ББК",
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания записи",
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Дата последней правки записи"
) COMMENT = "Классификатор ББК";

DROP TABLE IF EXISTS BBK_faset;
CREATE TABLE BBK_faset (
    parent_id INT UNSIGNED NOT NULL COMMENT "Идентификатор родительского раздела",
    child_id INT UNSIGNED NOT NULL COMMENT "Идентификатор родительского раздела",
    operator VARCHAR(12) NOT NULL COMMENT "Оператор соединения раздела классификатора ББК",
    CONSTRAINT BBK_faset_parent_id_fk FOREIGN KEY (parent_id) REFERENCES BBK (id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT BBK_faset_child_id_fk FOREIGN KEY (child_id) REFERENCES BBK (id) ON DELETE NO ACTION ON UPDATE CASCADE
) COMMENT = "Соединение разделов ББК";