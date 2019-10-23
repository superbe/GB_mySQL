-- База данных behest (сайт "Наследие")
-- Требования в Требования.txt
-- Здесь минимум, поэтому решил пока не переносить в отдельный репозиторий.
-- Сделаю здесь, позже перенесу и буду дорабатывать.
-- В папке "Нормативная база" некоторые нормативные и справочные источники.
-- Сначала запустить filldb.sql.

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

INSERT INTO roles (name) VALUES
('admin'),
('user'),
('author'),
('moderator'),
('owner'),
('redactor'),
('expert'); 

select * from roles;

INSERT INTO users (name, email, email_confirmed, phone, phone_confirmed, password_hash, blocked) VALUES
('gaylord.darrion','geovanny.gaylord@example.com',0,'+30(5)3202100932',0,'f9e20680e58746a1f959bcc95d501ac6347c308e',0),
('carolyn94','jacobs.bill@example.com',0,'(493)284-7081x5855',0,'15e1fc6310bf18a9ce96f4ce1cb32e42feca1111',0),
('rkihn','rosina.o\'hara@example.net',0,'1-074-109-2670',1,'1bf6f593147a7d0fcd679a34bc2478afccdb28be',1),
('beth47','ro\'conner@example.com',0,'1-299-512-8910x528',0,'833b37eb01e739f2dfb314a0bbc890d7cb60b475',0),
('gzemlak','jessie48@example.org',0,'(198)720-3901',0,'fc37680d578dddfcebe292f2a6297a198b46cca2',1),
('bhowell','fbartell@example.com',1,'933-131-5290',0,'2552d173976fbbaea308b23bd4571be4a2f9a125',1),
('darien.muller','mbartoletti@example.com',1,'+42(4)8528535202',0,'4ec677d76e1a222a1d5fbfffa76cc4944e58368e',0),
('stephon.quigley','ulang@example.net',1,'921-614-8557x24206',0,'99dc587f896427deb25ce2983ac427ef90f8e7fe',1),
('amitchell','stroman.may@example.org',1,'(551)385-6334x2651',1,'28d70c6509b27a4c5dd517743a9e4640fdedb91e',1),
('vita05','bkrajcik@example.org',1,'069-492-2493x870',0,'59eb760d20c4e776094836f93eb4fcc38b1dfcd8',0),
('hbarrows','vbeier@example.com',0,'752.024.5557',1,'60a462f6011cc362fe9233cd00d8d465738444b5',1),
('carter.gregoria','ricardo.kris@example.org',0,'892-653-3700',1,'017375b1ee80312f7088b95be759659f6c6312c4',0),
('mathilde24','smarquardt@example.net',1,'(329)445-9798x33577',0,'6f6cea0b97eaf12126d27f873d3cfdad854203b8',1),
('mweissnat','stokes.tara@example.net',0,'564.191.9322',0,'f13621910cb2cc3210498981a60816cbaab555d6',1),
('howard75','nhermann@example.com',1,'1-774-429-1992',0,'955bbc0809796830b2e1c63b8f1b6acf1f1809f0',0),
('buford89','perry.grady@example.com',0,'(837)676-5197x98989',0,'0452d52c471a148de86487bec0d2e4af7daadaba',0),
('keebler.jedidiah','jayne98@example.com',1,'1-522-876-5759',1,'44a0844a708c71164f145a6eeb89ff382b800214',0),
('raven18','auer.casey@example.com',1,'589.514.8447x258',1,'7f89fc22598432fd0600d8bcdb717d143c5bfabf',1),
('hdubuque','vada61@example.com',1,'616-418-8840',0,'d4c6bbac410ad5e7094b4804e53fdb0db63bb8dd',0),
('lemke.roosevelt','padberg.claudine@example.net',0,'1-034-846-2814',0,'8d50a1a9b43785159c6b6d1aa1b9c89fdbec50c1',1),
('brakus.noelia','devon79@example.net',1,'08252825059',1,'4d4eede24cd6de635e94c57dd81e1fc7ed68290d',1),
('misael.kuhlman','jeremy.johnson@example.com',0,'977.937.4400x7748',0,'5a4c19eddb81d3e4c324468b4c006f7137fb8c24',0),
('zwaters','xhermann@example.com',0,'1-160-330-9525x127',0,'9d94167172bb383018fb9d5f90d3b3af00279c4d',0),
('rowena33','maymie.schmidt@example.org',0,'+64(0)2068940909',0,'83d2a432b2424fb66214b8474a4602027ca751da',1),
('reichert.kaley','autumn11@example.org',0,'281.083.3422',1,'eb83d61c5b327a31a8f4cd255d32570577b167a2',0),
('hilpert.gussie','ulises.moore@example.net',1,'923-247-0829x5002',0,'7cc3d720b978a77261db5cbe8377de89ca2a3d75',1),
('helena98','neil37@example.org',1,'+20(1)1645489553',1,'d184bdc8751279af5d2aaf363659dd27662de5e5',0),
('julien47','will89@example.com',0,'(270)877-2136x5984',0,'faa4544d1f8879ae94ef2ad07f0c8d1ce0e4db8f',0),
('bell.pfeffer','hoppe.haylie@example.org',0,'1-941-144-2285x35081',1,'e52baf2770254baa0052e2b925dabd6f37a6ac16',0),
('wo\'reilly','oda.mayer@example.net',0,'+36(6)8787404448',0,'bb4f061363de520b66c91295992e9b4841180618',0),
('ullrich.merritt','bettie25@example.org',1,'132-404-7238x118',1,'8472b2290e39141a006ca3491259d8d7f2fc72da',1),
('laverna.auer','gstark@example.com',1,'01230480109',0,'07edd918acf849b1e10b574fcd547d27c0eff4e9',0),
('grimes.estevan','antonio68@example.com',0,'368.319.3572x03162',0,'92131a7fab23a948d99eae846ff1e365e14573b6',1),
('arnaldo.runolfsdottir','jsanford@example.net',1,'733-644-7769x3647',0,'6a3744d5a547a163683ba4145b156f210820dddc',1),
('evie.bradtke','wjacobs@example.com',1,'+62(4)8773130356',0,'e3f878a4662afa55cfe8b9211a358a2a71ee5212',1),
('leanne.rempel','dietrich.taryn@example.com',1,'(041)105-9395x130',0,'2b0cae802b9217db8c0376ce5a9bc7a3fbedc9c7',1),
('vicky.jakubowski','rowe.athena@example.net',0,'+18(8)5236787371',0,'3618527fc4eec86ac1a37cfe3a1d1efcf0f21ccb',1),
('barrett98','barbara31@example.net',0,'370.129.8190',1,'bbadae5fd0114a33ee25636bd77dcebabc50d61a',0),
('pkovacek','kuphal.francesco@example.net',0,'1-824-600-6210x464',1,'8f699b7d448ce20983b84080bf83e74f3b47f202',1),
('theresia57','zmurray@example.com',0,'+92(0)9355034702',0,'3767f48a0bb85fae6ce28e71cd4bf9f33078f428',1),
('christiansen.tyreek','carolanne61@example.org',1,'1-031-100-1583x835',0,'91f68dd64c787144c9bf92d6ab2cb4517cbddccb',0),
('grady.gabriella','nmarks@example.org',1,'1-467-136-2908x004',0,'04d165d190e7ad93662a6cc258e05d28db967e33',0),
('fhirthe','giovanni.west@example.com',1,'06269722776',0,'a4a113345abbd1def121e8d89441daa7e8e7966a',0),
('jess.oberbrunner','kailey59@example.net',1,'1-330-703-8674x3490',0,'10bf1ca277638b67b435451c15a34bded500f347',0),
('ethel34','ismael.ruecker@example.org',1,'888.604.4778',1,'7da2fa0af16f5d4d0c16546fdbf53b151f86cf4d',0),
('wuckert.lenna','uhickle@example.org',1,'833-867-2605',1,'443a6b144417d0b5433217d53cf417b9fc2f2083',1),
('blick.elwin','noemie.sawayn@example.net',1,'(167)337-9308x500',0,'7ef7ab288dae57d2c6f79ff33a92e9e40db28d7d',0),
('rkirlin','xkertzmann@example.org',0,'1-222-479-0636x289',1,'449e703fd301f1273cc15ce030a0cc1b6b045cc4',1),
('kevon86','alfred.crist@example.net',1,'744.300.5489',0,'e213f0cfc1d2a6316d88cc1c52ffada029b8eb28',0),
('svolkman','pschinner@example.net',1,'(602)444-7012x97120',0,'d5fe288ce48074c6b88efeb683b75622be2b5d9d',1),
('marks.dee','eernser@example.net',0,'(128)759-2879x098',1,'6d748e3c31c7232840449dce89e76cb6199a0ec1',1),
('tzemlak','everette74@example.org',0,'1-031-458-8605x2728',0,'54f0dc398163c98713be35d06d1825bcc79c93df',0),
('lindsey.abshire','sheila.pouros@example.org',0,'(300)612-3674x67611',0,'fe3470280600af674394d5a4ae778ee52ed30f12',0),
('vonrueden.ellsworth','hledner@example.net',1,'(932)707-1415',1,'b31013a2f467b4f496c7cff8e10735455dff1ed8',1),
('maximilian25','wsmitham@example.com',0,'+15(5)9216987263',0,'d2c6963f875092b4167c26aa5519e56f5d59a9b7',0),
('boyer.cyril','xkris@example.com',1,'(330)773-4848x69920',0,'b7bdb7518bf407b7113f03b74a289a9bd38c3cfe',0),
('liliane04','oswift@example.com',0,'09283051481',1,'81f63245561863b9aecac70da592cb0d7d9086a5',0),
('yrunolfsson','ybogisich@example.org',0,'1-483-457-2630x642',1,'d4676a4e145bde7012804c47570f1244cc0a69bd',0),
('emmanuelle92','rickey50@example.org',0,'107.297.9041x531',1,'d8a4c2c15a2709573b79f52286091b5ae6bc612e',1),
('ukoepp','seth64@example.com',0,'675.397.2731x35315',1,'a16eb7efe677431c00fa3bc1761fc2c9304be84d',1),
('vhomenick','lisette96@example.org',0,'1-334-084-8897',0,'e1344f4509d402c90635ad66acdf04234c7be786',0),
('kkohler','melissa15@example.net',0,'+60(8)4133455598',0,'40e272003f624ad6042a3098523dd98dc15f1850',0),
('sherman70','dusty.kreiger@example.net',0,'+85(8)3187977043',1,'a9378bb6c691e3d6bd420ab9d0c24db414f53a98',0),
('tressa.yost','mclaughlin.van@example.com',1,'1-061-239-0088',0,'77ac6f7ecaa619e0385eca2d9cceef33c982f534',0),
('rosemarie59','kaycee.hoeger@example.org',0,'303-962-7491x5882',1,'253bf57b76eb4e83ff9bc400078aba4b6883f043',1),
('botsford.hildegard','ashtyn42@example.org',0,'1-685-176-1320x396',0,'037c2d5caecfc9385c5844fd251db420562a9c1f',0),
('fpagac','jovany.herman@example.net',1,'966.004.2703',1,'a1f738d132b907f40da49890cd1456683bb82304',1),
('nswift','ykonopelski@example.org',0,'521-754-7839x63409',1,'2334b1492f54c2c7968c7aa168b60f5018a042af',0),
('chase.romaguera','romaguera.jovan@example.net',0,'(878)282-9732x17759',0,'aaae1999b5e5d6404cd1ad8935e733b3cec80cde',0),
('lesch.thaddeus','veum.cloyd@example.org',0,'040-959-8782x15070',0,'7b6119470d7974acd1a9f2eeeb3efc70c0f548f2',0),
('charity.ziemann','kihn.tanya@example.com',0,'542.416.4393x8658',0,'77d1bb1a70c2a70cbed355384898d0f9ea1786d4',0),
('emiller','golden31@example.com',0,'(734)475-8896',0,'5defad6fe1f106516a05ab9aa37e221425affeb2',1),
('cschulist','qlittle@example.org',0,'690.606.9333x24291',0,'103d6f60fc3ea28d691f1370bf4d03904ac33453',0),
('hassie.hegmann','kschneider@example.net',1,'1-683-116-6767',0,'9567bd4910467844ebf8facb59f905ef92e7f197',1),
('rosina06','farrell.waino@example.net',0,'1-246-097-3941x948',0,'92b3f32e0f9a2263df2598973f2c95a8f7a4b038',0),
('glover.jaquelin','lue05@example.com',0,'(817)712-8410x350',0,'c561767024da899a62cad3e187a65defc12a8060',0),
('johnson.emard','elizabeth.sawayn@example.net',0,'05121798574',1,'9346bc867be30b800e992ede2de258362883a143',1),
('ashley.mccullough','qmurazik@example.net',0,'09968145482',0,'81702db26305e64141ab63902a3052cebc3f63fb',1),
('davis.jack','runte.coy@example.net',1,'(047)926-7100x47218',0,'76f596bd3e9fef45705640ffd30bc00468852351',1),
('friesen.hal','brown.elisha@example.com',1,'253-777-9624x9899',0,'218929c276dd27b7ad5b526e91a4885c0ac7dae6',1),
('jgutkowski','douglas.balistreri@example.net',0,'1-114-917-4891x995',0,'d12f832ca0ed181f0404c45336e6fb5b1aa95f47',1),
('hmills','virginie.klocko@example.com',1,'312-579-9583',1,'7ae88bb094860d40a9ff91f9a87923fc61562cb1',1),
('earnest.mitchell','frami.kaitlin@example.com',0,'1-956-587-7130x74786',1,'1b6544b0c845bd73ea25062bd703e77a9005ec24',0),
('wuckert.tressie','deron.douglas@example.com',0,'691-504-5400x26633',0,'1a89902d2704135df178332336fe91274c9ea6d2',0),
('gideon96','sammie49@example.net',0,'1-293-688-7574x21453',1,'52d88129d7b422173f140e3635bb82ae5ed30b5b',1),
('brooke50','christopher31@example.org',0,'1-988-631-9593x45970',1,'32af62890271e69506be46049faad7c9b65e9ec3',0),
('ncarter','edyth.corwin@example.com',1,'(503)185-8604x5247',0,'846600dccd4940ed3c468d23235aa4cbe86b83f2',1),
('emilia38','gerardo.lubowitz@example.org',1,'299.199.7892x7162',1,'a1af22b2d6ea85281ff34bc021e3d95cf1f71d53',0),
('ghilll','oboyer@example.net',1,'509.326.0532x684',0,'f4823aeb45f91e4e2e6179e0d37281db949b1c1f',0),
('arlie.dickens','ezequiel.turner@example.net',1,'06499730347',0,'3ef8e78d156dc444ced7c3ea6825793c1d1281eb',0),
('pgerhold','casandra80@example.org',1,'(170)250-7785x53650',1,'27e65b3d981ce2e6e2ce6bb0d349e645c0475ccf',1),
('vhamill','collier.eliseo@example.com',1,'619-417-1142',1,'4764c7bc8390bfa9ed86e26521d02147c115deec',1),
('dawson.pollich','mariana.haag@example.com',1,'426-906-9870',1,'01c4f9363497c464967a89077037cbb016c6dd53',1),
('qyundt','hanna.rogahn@example.net',0,'977.567.7322',1,'7d0f52c2a58fdf743c7d6141af3d786c8f554243',0),
('johnpaul.sipes','altenwerth.eliezer@example.org',1,'234.792.1224x3836',0,'98a40ec6a1940bb6d78fd7e6136500e1155f7204',1),
('orval.torp','glenda86@example.org',0,'(763)641-0394',1,'2d07450da821c7485a36721f6120591efece4a83',0),
('yadira.koepp','creichel@example.org',0,'544.771.6317x1732',1,'962f69f92afe96798d8260f3dad460ca878aa45b',1),
('lnolan','alan60@example.org',0,'624-192-5245',0,'e8261647ca25ff49c6701ef0b0dfcd803b1ec978',0),
('graham.javonte','bgrant@example.org',1,'1-643-716-3224',1,'f01416903b629f5ccaba86acd2633651eafa920a',0),
('jordon.swift','adell.ferry@example.com',1,'910-428-1879x608',1,'88a9321cc7d7d3b1e615a10a697091ac0193efb2',1);

select * from users;

INSERT INTO user_roles VALUES
('1','1'),
('2','2'),
('3','3'),
('4','4'),
('5','5'),
('6','6'),
('7','7'),
('8','1'),
('9','2'),
('10','3'),
('11','4'),
('12','5'),
('13','6'),
('14','7'),
('15','1'),
('16','2'),
('17','3'),
('18','4'),
('19','5'),
('20','6'),
('21','7'),
('22','1'),
('23','2'),
('24','3'),
('25','4'),
('26','5'),
('27','6'),
('28','7'),
('29','1'),
('30','2'),
('31','3'),
('32','4'),
('33','5'),
('34','6'),
('35','7'),
('36','1'),
('37','2'),
('38','3'),
('39','4'),
('40','5'),
('41','6'),
('42','7'),
('43','1'),
('44','2'),
('45','3'),
('46','4'),
('47','5'),
('48','6'),
('49','7'),
('50','1'),
('51','2'),
('52','3'),
('53','4'),
('54','5'),
('55','6'),
('56','7'),
('57','1'),
('58','2'),
('59','3'),
('60','4'),
('61','5'),
('62','6'),
('63','7'),
('64','1'),
('65','2'),
('66','3'),
('67','4'),
('68','5'),
('69','6'),
('70','7'),
('71','1'),
('72','2'),
('73','3'),
('74','4'),
('75','5'),
('76','6'),
('77','7'),
('78','1'),
('79','2'),
('80','3'),
('81','4'),
('82','5'),
('83','6'),
('84','7'),
('85','1'),
('86','2'),
('87','3'),
('88','4'),
('89','5'),
('90','6'),
('91','7'),
('92','1'),
('93','2'),
('94','3'),
('95','4'),
('96','5'),
('97','6'),
('98','7'),
('99','1'),
('100','2'); 

select * from user_roles;

INSERT INTO media_types (name) VALUES
('audio'),
('image'),
('video'); 