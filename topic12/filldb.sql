-- Вспомогательная база данных по формированию понятных тестовых данных.

DROP DATABASE IF EXISTS filldb;
CREATE DATABASE filldb;
USE filldb;

DROP TABLE IF EXISTS male_first_names;
CREATE TABLE male_first_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор имени",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Имя",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Мужские имена";

DROP TABLE IF EXISTS male_middle_names;
CREATE TABLE male_middle_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор отчества",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Отчество",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Мужские отчества";

DROP TABLE IF EXISTS male_last_names;
CREATE TABLE male_last_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор фимилии",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Фимилия",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Мужские фимилии";

DROP TABLE IF EXISTS female_first_names;
CREATE TABLE female_first_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор имени",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Имя",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Женские имена";

DROP TABLE IF EXISTS female_middle_names;
CREATE TABLE female_middle_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор отчества",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Отчество",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Женские отчества";

DROP TABLE IF EXISTS female_last_names;
CREATE TABLE female_last_names (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор фимилии",
    name VARCHAR(255) NOT NULL UNIQUE COMMENT "Фимилия",
    frequency DECIMAL(7,6) NOT NULL DEFAULT 0 COMMENT "Частота"
) COMMENT = "Женские фимилии";

INSERT INTO male_first_names (name, frequency) VALUES
('Артём',0.7326),
('Артемий',0.7326),
('Александр',0.7252),
('Максим',0.7178),
('Даниил',0.7104),
('Данил',0.7104),
('Данила',0.7104),
('Дмитрий',0.703),
('Димитрий',0.703),
('Иван',0.6956),
('Кирилл',0.6882),
('Никита',0.6808),
('Михаил',0.6734),
('Егор',0.666),
('Егорий',0.666),
('Матвей',0.6586),
('Андрей',0.6512),
('Илья',0.6438),
('Алексей',0.6364),
('Роман',0.629),
('Сергей',0.6216),
('Владислав',0.6142),
('Ярослав',0.6068),
('Тимофей',0.5994),
('Арсений',0.592),
('Арсентий',0.592),
('Денис',0.5846),
('Владимир',0.5772),
('Павел',0.5698),
('Глеб',0.5624),
('Константин',0.555),
('Богдан',0.5476),
('Евгений',0.5402),
('Николай',0.5328),
('Степан',0.5254),
('Захар',0.518),
('Тимур',0.1173),
('Марк',0.1156),
('Семён',0.1139),
('Фёдор',0.1122),
('Георгий',0.1105),
('Лев',0.1088),
('Антон',0.1071),
('Антоний',0.1071),
('Вадим',0.1054),
('Игорь',0.1037),
('Руслан',0.102),
('Вячеслав',0.1003),
('Григорий',0.0986),
('Макар',0.0969),
('Артур',0.0952),
('Виктор',0.0935),
('Станислав',0.0918),
('Савелий',0.0901),
('Олег',0.0884),
('Давид',0.0867),
('Давыд',0.0867),
('Леонид',0.085),
('Пётр',0.0833),
('Юрий',0.0816),
('Виталий',0.0799),
('Мирон',0.0782),
('Василий',0.0765),
('Всеволод',0.0748),
('Елисей',0.0731),
('Назар',0.0714),
('Родион',0.0697),
('Марат',0.068),
('Платон',0.117),
('Герман',0.114),
('Игнат',0.111),
('Игнатий',0.111),
('Святослав',0.108),
('Анатолий',0.105),
('Тихон',0.102),
('Валерий',0.099),
('Мирослав',0.096),
('Ростислав',0.093),
('Борис',0.09),
('Филипп',0.087),
('Демьян',0.084),
('Клим',0.081),
('Климент',0.081),
('Гордей',0.078),
('Валентин',0.075),
('Геннадий',0.072),
('Демид',0.069),
('Диомид',0.069),
('Прохор',0.066),
('Серафим',0.063),
('Савва',0.06),
('Яромир',0.057),
('Аркадий',0.054),
('Архип',0.051),
('Тарас',0.048),
('Трофим',0.045);

INSERT INTO male_middle_names (name, frequency) VALUES
('Артёмович',0.7326),
('Александрович',0.7252),
('Максимович',0.7178),
('Даниилович',0.7104),
('Данилович',0.7104),
('Дмитрович',0.703),
('Иванович',0.6956),
('Кириллович',0.6882),
('Никитович',0.6808),
('Михаилович',0.6734),
('Егорович',0.666),
('Матвеевич',0.6586),
('Андреевич',0.6512),
('Ильич',0.6438),
('Алексеевич',0.6364),
('Романович',0.629),
('Сергеевич',0.6216),
('Владиславович',0.6142),
('Ярославович',0.6068),
('Тимофеевич',0.5994),
('Арсениевич',0.592),
('Денисович',0.5846),
('Владимирович',0.5772),
('Павлович',0.5698),
('Глебович',0.5624),
('Константинович',0.555),
('Богданович',0.5476),
('Евгеньевич',0.5402),
('Николаевич',0.5328),
('Степанович',0.5254),
('Захарович',0.518),
('Тимурович',0.1173),
('Маркович',0.1156),
('Семёнович',0.1139),
('Фёдорович',0.1122),
('Георгиевич',0.1105),
('Львович',0.1088),
('Антонович',0.1071),
('Антониевич',0.1071),
('Вадимович',0.1054),
('Игоревич',0.1037),
('Русланович',0.102),
('Вячеславович',0.1003),
('Григориевич',0.0986),
('Макарович',0.0969),
('Артурович',0.0952),
('Викторович',0.0935),
('Станиславович',0.0918),
('Савелиевич',0.0901),
('Олегович',0.0884),
('Давидович',0.0867),
('Давыдович',0.0867),
('Леонидович',0.085),
('Петрович',0.0833),
('Юриевич',0.0816),
('Виталиевич',0.0799),
('Миронович',0.0782),
('Василиевич',0.0765),
('Всеволодович',0.0748),
('Елисеевич',0.0731),
('Назарович',0.0714),
('Родионович',0.0697),
('Маратович',0.068),
('Платонович',0.117),
('Германович',0.114),
('Игнатович',0.111),
('Игнатиевич',0.111),
('Святославович',0.108),
('Анатолиевич',0.105),
('Тихонович',0.102),
('Валериевич',0.099),
('Мирославович',0.096),
('Ростиславович',0.093),
('Борисович',0.09),
('Филиппович',0.087),
('Демьянович',0.084),
('Климович',0.081),
('Климентович',0.081),
('Гордеевич',0.078),
('Валентинович',0.075),
('Геннадиевич',0.072),
('Демидович',0.069),
('Диомидович',0.069),
('Прохорович',0.066),
('Серафимович',0.063),
('Савваович',0.06),
('Яромирович',0.057),
('Аркадиевич',0.054),
('Архипович',0.051),
('Тарасович',0.048),
('Трофимович',0.045);

INSERT INTO male_last_names (name, frequency) VALUES
('Иванов',1.0),
('Смирнов',0.7412),
('Кузнецов',0.7011),
('Попов',0.5334),
('Васильев',0.4948),
('Петров',0.4885),
('Соколов',0.4666),
('Михайлов',0.3955),
('Новиков',0.3743),
('Федоров',0.3662),
('Морозов',0.3639),
('Волков',0.3636),
('Алексеев',0.346),
('Лебедев',0.3431),
('Семенов',0.3345),
('Егоров',0.3229),
('Павлов',0.3226),
('Козлов',0.3139),
('Степанов',0.3016),
('Николаев',0.3005),
('Орлов',0.2976),
('Андреев',0.2972),
('Макаров',0.2924),
('Никитин',0.2812),
('Захаров',0.2755),
('Зайцев',0.2728),
('Соловьев',0.2712),
('Борисов',0.271),
('Яковлев',0.2674),
('Григорьев',0.2541),
('Романов',0.2442),
('Воробьев',0.2371),
('Сергеев',0.2365),
('Кузьмин',0.2255),
('Фролов',0.2235),
('Александров',0.2234),
('Дмитриев',0.2171),
('Королев',0.2083),
('Гусев',0.2075),
('Киселев',0.207),
('Ильин',0.2063),
('Максимов',0.2059),
('Поляков',0.2035),
('Сорокин',0.1998),
('Виноградов',0.1996),
('Ковалев',0.1978),
('Белов',0.1964),
('Медведев',0.1953),
('Антонов',0.1928),
('Тарасов',0.1896),
('Жуков',0.1894),
('Баранов',0.1883),
('Филиппов',0.1827),
('Комаров',0.1799),
('Давыдов',0.1767),
('Беляев',0.175),
('Герасимов',0.1742),
('Богданов',0.1706),
('Осипов',0.1702),
('Сидоров',0.1695),
('Матвеев',0.1693),
('Титов',0.1646),
('Марков',0.1628),
('Миронов',0.1625),
('Крылов',0.1605),
('Куликов',0.1605),
('Карпов',0.1584),
('Власов',0.1579),
('Мельников',0.1567),
('Денисов',0.1544),
('Гаврилов',0.154),
('Тихонов',0.1537),
('Казаков',0.1528),
('Афанасьев',0.1516),
('Данилов',0.1505),
('Савельев',0.1405),
('Тимофеев',0.1403),
('Фомин',0.1401),
('Чернов',0.1396),
('Абрамов',0.139),
('Мартынов',0.1383),
('Ефимов',0.1377),
('Федотов',0.1377),
('Щербаков',0.1375),
('Назаров',0.1366),
('Калинин',0.1327),
('Исаев',0.1317),
('Чернышев',0.1267),
('Быков',0.1255),
('Маслов',0.1249),
('Родионов',0.1248),
('Коновалов',0.1245),
('Лазарев',0.1236),
('Воронин',0.1222),
('Климов',0.1213),
('Филатов',0.1208),
('Пономарев',0.1203),
('Голубев',0.12),
('Кудрявцев',0.1186),
('Прохоров',0.1182),
('Наумов',0.1172),
('Потапов',0.1165),
('Журавлев',0.116),
('Овчинников',0.1148),
('Трофимов',0.1148),
('Леонов',0.1142),
('Соболев',0.1135),
('Ермаков',0.112),
('Колесников',0.112),
('Гончаров',0.1115),
('Емельянов',0.1081),
('Никифоров',0.1055),
('Грачев',0.1049),
('Котов',0.1037),
('Гришин',0.1017),
('Ефремов',0.0995),
('Архипов',0.0993),
('Громов',0.0986),
('Кириллов',0.0982),
('Малышев',0.0978),
('Панов',0.0978),
('Моисеев',0.0975),
('Румянцев',0.0975),
('Акимов',0.0963),
('Кондратьев',0.0954),
('Бирюков',0.095),
('Горбунов',0.094),
('Анисимов',0.0925),
('Еремин',0.0916),
('Тихомиров',0.0907),
('Галкин',0.0884),
('Лукьянов',0.0876),
('Михеев',0.0872),
('Скворцов',0.0862),
('Юдин',0.0859),
('Белоусов',0.0856),
('Нестеров',0.0842),
('Симонов',0.0834),
('Прокофьев',0.0826),
('Харитонов',0.0819),
('Князев',0.0809),
('Цветков',0.0807),
('Левин',0.0806),
('Митрофанов',0.0796),
('Воронов',0.0792),
('Аксенов',0.0781),
('Софронов',0.0781),
('Мальцев',0.0777),
('Логинов',0.0774),
('Горшков',0.0771),
('Савин',0.0771),
('Краснов',0.0761),
('Майоров',0.0761),
('Демидов',0.0756),
('Елисеев',0.0754),
('Рыбаков',0.0754),
('Сафонов',0.0753),
('Плотников',0.0749),
('Демин',0.0745),
('Хохлов',0.0745),
('Фадеев',0.074),
('Молчанов',0.0739),
('Игнатов',0.0738),
('Литвинов',0.0738),
('Ершов',0.0736),
('Ушаков',0.0736),
('Дементьев',0.0722),
('Рябов',0.0722),
('Мухин',0.0719),
('Калашников',0.0715),
('Леонтьев',0.0714),
('Лобанов',0.0714),
('Кузин',0.0712),
('Корнеев',0.071),
('Евдокимов',0.07),
('Бородин',0.0699),
('Платонов',0.0699),
('Некрасов',0.0697),
('Балашов',0.0694),
('Бобров',0.0692),
('Жданов',0.0692),
('Блинов',0.0687),
('Игнатьев',0.0683),
('Коротков',0.0678),
('Муравьев',0.0675),
('Крюков',0.0672),
('Беляков',0.0671),
('Богомолов',0.0671),
('Дроздов',0.0669),
('Лавров',0.0666),
('Зуев',0.0664),
('Петухов',0.0661),
('Ларин',0.0659),
('Никулин',0.0657),
('Серов',0.0657),
('Терентьев',0.0652),
('Зотов',0.0651),
('Устинов',0.065),
('Фокин',0.0648),
('Самойлов',0.0647),
('Константинов',0.0645),
('Сахаров',0.0641),
('Шишкин',0.064),
('Самсонов',0.0638),
('Черкасов',0.0637),
('Чистяков',0.0637),
('Носов',0.063),
('Спиридонов',0.0627),
('Карасев',0.0618),
('Авдеев',0.0613),
('Воронцов',0.0612),
('Зверев',0.0606),
('Владимиров',0.0605),
('Селезнев',0.0598),
('Нечаев',0.059),
('Кудряшов',0.0587),
('Седов',0.058),
('Фирсов',0.0578),
('Андрианов',0.0577),
('Панин',0.0577),
('Головин',0.0571),
('Терехов',0.0569),
('Ульянов',0.0567),
('Шестаков',0.0566),
('Агеев',0.0564),
('Никонов',0.0564),
('Селиванов',0.0564),
('Баженов',0.0562),
('Гордеев',0.0562),
('Кожевников',0.0562),
('Пахомов',0.056),
('Зимин',0.0557),
('Костин',0.0556),
('Широков',0.0553),
('Филимонов',0.055),
('Ларионов',0.0549),
('Овсянников',0.0546),
('Сазонов',0.0545),
('Суворов',0.0545),
('Нефедов',0.0543),
('Корнилов',0.0541),
('Любимов',0.0541),
('Львов',0.0536),
('Горбачев',0.0535),
('Копылов',0.0534),
('Лукин',0.0531),
('Токарев',0.0527),
('Кулешов',0.0525),
('Шилов',0.0522),
('Большаков',0.0518),
('Панкратов',0.0518),
('Родин',0.0514),
('Шаповалов',0.0514),
('Покровский',0.0513),
('Бочаров',0.0507),
('Никольский',0.0507),
('Маркин',0.0506),
('Горелов',0.05),
('Агафонов',0.0499),
('Березин',0.0499),
('Ермолаев',0.0495),
('Зубков',0.0495),
('Куприянов',0.0495),
('Трифонов',0.0495),
('Масленников',0.0488),
('Круглов',0.0486),
('Третьяков',0.0486),
('Колосов',0.0485),
('Рожков',0.0485),
('Артамонов',0.0482),
('Шмелев',0.0481),
('Лаптев',0.0478),
('Лапшин',0.0468),
('Федосеев',0.0467),
('Зиновьев',0.0465),
('Зорин',0.0465),
('Уткин',0.0464),
('Столяров',0.0461),
('Зубов',0.0458),
('Ткачев',0.0454),
('Дорофеев',0.045),
('Антипов',0.0447),
('Завьялов',0.0447),
('Свиридов',0.0447),
('Золотарев',0.0446),
('Кулаков',0.0446),
('Мещеряков',0.0444),
('Макеев',0.0436),
('Дьяконов',0.0434),
('Гуляев',0.0433),
('Петровский',0.0432),
('Бондарев',0.043),
('Поздняков',0.043),
('Панфилов',0.0427),
('Кочетков',0.0426),
('Суханов',0.0425),
('Рыжов',0.0422),
('Старостин',0.0421),
('Калмыков',0.0418),
('Колесов',0.0416),
('Золотов',0.0415),
('Кравцов',0.0414),
('Субботин',0.0414),
('Шубин',0.0414),
('Щукин',0.0412),
('Лосев',0.0411),
('Винокуров',0.0409),
('Лапин',0.0409),
('Парфенов',0.0409),
('Исаков',0.0407),
('Голованов',0.0402),
('Коровин',0.0402),
('Розанов',0.0401),
('Артемов',0.04),
('Козырев',0.04),
('Русаков',0.0398),
('Алешин',0.0397),
('Крючков',0.0397),
('Булгаков',0.0395),
('Кошелев',0.0391),
('Сычев',0.0391),
('Синицын',0.039),
('Черных',0.0383),
('Рогов',0.0381),
('Кононов',0.0379),
('Лаврентьев',0.0377),
('Евсеев',0.0376),
('Пименов',0.0376),
('Пантелеев',0.0374),
('Горячев',0.0373),
('Аникин',0.0372),
('Лопатин',0.0372),
('Рудаков',0.0372),
('Одинцов',0.037),
('Серебряков',0.037),
('Панков',0.0369),
('Дегтярев',0.0367),
('Орехов',0.0367),
('Царев',0.0363),
('Шувалов',0.0356),
('Кондрашов',0.0355),
('Горюнов',0.0353),
('Дубровин',0.0353),
('Голиков',0.0349),
('Курочкин',0.0348),
('Латышев',0.0348),
('Севастьянов',0.0348),
('Вавилов',0.0346),
('Ерофеев',0.0345),
('Сальников',0.0345),
('Клюев',0.0344),
('Носков',0.0339),
('Озеров',0.0339),
('Кольцов',0.0338),
('Комиссаров',0.0337),
('Меркулов',0.0337),
('Киреев',0.0335),
('Хомяков',0.0335),
('Булатов',0.0331),
('Ананьев',0.0329),
('Буров',0.0327),
('Шапошников',0.0327),
('Дружинин',0.0324),
('Островский',0.0324),
('Шевелев',0.032),
('Долгов',0.0319),
('Суслов',0.0319),
('Шевцов',0.0317),
('Пастухов',0.0316),
('Рубцов',0.0313),
('Бычков',0.0312),
('Глебов',0.0312),
('Ильинский',0.0312),
('Успенский',0.0312),
('Дьяков',0.031),
('Кочетов',0.031),
('Вишневский',0.0307),
('Высоцкий',0.0305),
('Глухов',0.0305),
('Дубов',0.0305),
('Бессонов',0.0302),
('Ситников',0.0302),
('Астафьев',0.03),
('Мешков',0.03),
('Шаров',0.03),
('Яшин',0.0299),
('Козловский',0.0298),
('Туманов',0.0298),
('Басов',0.0296),
('Корчагин',0.0295),
('Болдырев',0.0293),
('Олейников',0.0293),
('Чумаков',0.0293),
('Фомичев',0.0291),
('Губанов',0.0289),
('Дубинин',0.0289),
('Шульгин',0.0289),
('Касаткин',0.0285),
('Пирогов',0.0285),
('Семин',0.0285),
('Трошин',0.0284),
('Горохов',0.0282),
('Стариков',0.0282),
('Щеглов',0.0281),
('Фетисов',0.0279),
('Колпаков',0.0278),
('Чесноков',0.0278),
('Зыков',0.0277),
('Верещагин',0.0274),
('Минаев',0.0272),
('Руднев',0.0272),
('Троицкий',0.0272),
('Окулов',0.0271),
('Ширяев',0.0271),
('Малинин',0.027),
('Черепанов',0.027),
('Измайлов',0.0268),
('Алехин',0.0265),
('Зеленин',0.0265),
('Касьянов',0.0265),
('Пугачев',0.0265),
('Павловский',0.0264),
('Чижов',0.0264),
('Кондратов',0.0263),
('Воронков',0.0261),
('Капустин',0.0261),
('Сотников',0.0261),
('Демьянов',0.026),
('Косарев',0.0257),
('Беликов',0.0254),
('Сухарев',0.0254),
('Белкин',0.0253),
('Беспалов',0.0253),
('Кулагин',0.0253),
('Савицкий',0.0253),
('Жаров',0.0253),
('Хромов',0.0251),
('Еремеев',0.025),
('Карташов',0.025),
('Астахов',0.0246),
('Русанов',0.0246),
('Сухов',0.0246),
('Вешняков',0.0244),
('Волошин',0.0244),
('Козин',0.0244),
('Худяков',0.0244),
('Жилин',0.0242),
('Малахов',0.0239),
('Сизов',0.0237),
('Ежов',0.0235),
('Толкачев',0.0235),
('Анохин',0.0232),
('Вдовин',0.0232),
('Бабушкин',0.0231),
('Усов',0.0231),
('Лыков',0.0229),
('Горлов',0.0228),
('Коршунов',0.0228),
('Маркелов',0.0226),
('Постников',0.0225),
('Черный',0.0225),
('Дорохов',0.0224),
('Свешников',0.0224),
('Гущин',0.0222),
('Калугин',0.0222),
('Блохин',0.0221),
('Сурков',0.0221),
('Кочергин',0.0219),
('Греков',0.0217),
('Казанцев',0.0217),
('Швецов',0.0217),
('Ермилов',0.0215),
('Парамонов',0.0215),
('Агапов',0.0214),
('Минин',0.0214),
('Корнев',0.0212),
('Черняев',0.0212),
('Гуров',0.021),
('Ермолов',0.021),
('Сомов',0.021),
('Добрынин',0.0208),
('Барсуков',0.0205),
('Глушков',0.0203),
('Чеботарев',0.0203),
('Москвин',0.0201),
('Уваров',0.0201),
('Безруков',0.02),
('Муратов',0.02),
('Раков',0.0198),
('Снегирев',0.0198),
('Гладков',0.0197),
('Злобин',0.0197),
('Моргунов',0.0197),
('Поликарпов',0.0197),
('Рябинин',0.0197),
('Судаков',0.0196),
('Кукушкин',0.0193),
('Калачев',0.0191),
('Грибов',0.019),
('Елизаров',0.019),
('Звягинцев',0.019),
('Корольков',0.019),
('Федосов',0.019);

INSERT INTO female_first_names (name, frequency) VALUES
('София',0.7425),
('Софья',0.7425),
('Анастасия',0.735),
('Дарья',0.7275),
('Дарина',0.7275),
('Мария',0.72),
('Анна',0.7125),
('Виктория',0.705),
('Полина',0.6975),
('Елизавета',0.69),
('Екатерина',0.6825),
('Ксения',0.675),
('Валерия',0.6675),
('Варвара',0.66),
('Александра',0.6525),
('Вероника',0.645),
('Арина',0.6375),
('Алиса',0.63),
('Алина',0.6225),
('Милана',0.615),
('Милена',0.615),
('Маргарита',0.6075),
('Диана',0.6),
('Ульяна',0.5925),
('Алёна',0.585),
('Ангелина',0.5775),
('Анжелика',0.5775),
('Кристина',0.57),
('Юлия',0.5625),
('Кира',0.555),
('Ева',0.5475),
('Карина',0.54),
('Василиса',0.5325),
('Василина',0.5325),
('Ольга',0.525),
('Татьяна',0.1035),
('Ирина',0.102),
('Таисия',0.1005),
('Евгения',0.099),
('Яна',0.0975),
('Янина',0.0975),
('Вера',0.096),
('Марина',0.0945),
('Елена',0.093),
('Надежда',0.0915),
('Светлана',0.09),
('Злата',0.0885),
('Олеся',0.087),
('Алеся',0.087),
('Наталья',0.0855),
('Наталия',0.0855),
('Эвелина',0.084),
('Лилия',0.0825),
('Элина',0.081),
('Виолетта',0.0795),
('Виола',0.0795),
('Нелли',0.078),
('Мирослава',0.0765),
('Любовь',0.075),
('Альбина',0.0735),
('Владислава',0.072),
('Камилла',0.0705),
('Марианна',0.069),
('Марьяна',0.069),
('Ника',0.0675),
('Ярослава',0.066),
('Валентина',0.0645),
('Эмилия',0.063),
('Майя',0.0615),
('Эльвира',0.06),
('Снежана',0.117),
('Влада',0.114),
('Каролина',0.111),
('Лидия',0.108),
('Виталина',0.105),
('Виталия',0.105),
('Нина',0.102),
('Есения',0.099),
('Оксана',0.096),
('Аделина',0.093),
('Ада',0.093),
('Лада',0.09),
('Амелия',0.087),
('Амалия',0.087),
('Элеонора',0.084),
('Антонина',0.081),
('Людмила',0.078),
('Галина',0.075),
('Тамара',0.072),
('Алла',0.069),
('Жанна',0.066),
('Инна',0.063),
('Лия',0.06),
('Серафима',0.057),
('Анфиса',0.054),
('Евангелина',0.051),
('Агата',0.048),
('Агафья',0.048),
('Агафия',0.048),
('Лариса',0.045);

INSERT INTO female_middle_names (name, frequency) VALUES
('Артёмовна',0.7326),
('Артемиовна',0.7326),
('Александровна',0.7252),
('Максимовна',0.7178),
('Данииловна',0.7104),
('Даниловна',0.7104),
('Дмитриевна',0.703),
('Димитриевна',0.703),
('Ивановна',0.6956),
('Кирилловна',0.6882),
('Никитиевна',0.6808),
('Михаиловна',0.6734),
('Егоровна',0.666),
('Егориевна',0.666),
('Матвеевна',0.6586),
('Андреевна',0.6512),
('Ильинична',0.6438),
('Алексеевна',0.6364),
('Романовна',0.629),
('Сергеевна',0.6216),
('Владиславовна',0.6142),
('Ярославовна',0.6068),
('Тимофеевна',0.5994),
('Арсениевна',0.592),
('Арсентиевна',0.592),
('Денисовна',0.5846),
('Владимировна',0.5772),
('Павловна',0.5698),
('Глебовна',0.5624),
('Константиновна',0.555),
('Богдановна',0.5476),
('Евгениевна',0.5402),
('Николаевна',0.5328),
('Степановна',0.5254),
('Захаровна',0.518),
('Тимуровна',0.1173),
('Марковна',0.1156),
('Семёновна',0.1139),
('Фёдоровна',0.1122),
('Георгиевна',0.1105),
('Львовна',0.1088),
('Антоновна',0.1071),
('Антониевна',0.1071),
('Вадимовна',0.1054),
('Игоревна',0.1037),
('Руслановна',0.102),
('Вячеславовна',0.1003),
('Григориевна',0.0986),
('Макаровна',0.0969),
('Артуровна',0.0952),
('Викторовна',0.0935),
('Станиславовна',0.0918),
('Савелиевна',0.0901),
('Олеговна',0.0884),
('Давидовна',0.0867),
('Давыдовна',0.0867),
('Леонидовна',0.085),
('Пётровна',0.0833),
('Юриевна',0.0816),
('Виталиевна',0.0799),
('Мироновна',0.0782),
('Василиевна',0.0765),
('Всеволодовна',0.0748),
('Елисеевна',0.0731),
('Назаровна',0.0714),
('Родионовна',0.0697),
('Маратовна',0.068),
('Платоновна',0.117),
('Германовна',0.114),
('Игнатовна',0.111),
('Игнатиевна',0.111),
('Святославовна',0.108),
('Анатолиевна',0.105),
('Тихоновна',0.102),
('Валериевна',0.099),
('Мирославовна',0.096),
('Ростиславовна',0.093),
('Борисовна',0.09),
('Филипповна',0.087),
('Демьяновна',0.084),
('Климовна',0.081),
('Климентовна',0.081),
('Гордеевна',0.078),
('Валентиновна',0.075),
('Геннадиевна',0.072),
('Демидовна',0.069),
('Диомидовна',0.069),
('Прохоровна',0.066),
('Серафимовна',0.063),
('Савваовна',0.06),
('Яромировна',0.057),
('Аркадиевна',0.054),
('Архиповна',0.051),
('Тарасовна',0.048),
('Трофимовна',0.045);

INSERT INTO female_last_names (name, frequency) VALUES
('Иванова',1.156),
('Смирнова',0.8568272),
('Кузнецова',0.8104716),
('Попова',0.6166104),
('Васильева',0.5719888),
('Петрова',0.564706),
('Соколова',0.5393896),
('Михайлова',0.457198),
('Новикова',0.4326908),
('Федорова',0.4233272),
('Морозова',0.4206684),
('Волкова',0.4203216),
('Алексеева',0.399976),
('Лебедева',0.3966236),
('Семенова',0.386682),
('Егорова',0.3732724),
('Павлова',0.3729256),
('Козлова',0.3628684),
('Степанова',0.3486496),
('Николаева',0.347378),
('Орлова',0.3440256),
('Андреева',0.3435632),
('Макарова',0.3380144),
('Никитина',0.3250672),
('Захарова',0.318478),
('Зайцева',0.3153568),
('Соловьева',0.3135072),
('Борисова',0.313276),
('Яковлева',0.3091144),
('Григорьева',0.2937396),
('Романова',0.2822952),
('Воробьева',0.2740876),
('Сергеева',0.273394),
('Кузьмина',0.260678),
('Фролова',0.258366),
('Александрова',0.2582504),
('Дмитриева',0.2509676),
('Королева',0.2407948),
('Гусева',0.23987),
('Киселева',0.239292),
('Ильина',0.2384828),
('Максимова',0.2380204),
('Полякова',0.235246),
('Сорокина',0.2309688),
('Виноградова',0.2307376),
('Ковалева',0.2286568),
('Белова',0.2270384),
('Медведева',0.2257668),
('Антонова',0.2228768),
('Тарасова',0.2191776),
('Жукова',0.2189464),
('Баранова',0.2176748),
('Филиппова',0.2112012),
('Комарова',0.2079644),
('Давыдова',0.2042652),
('Беляева',0.2023),
('Герасимова',0.2013752),
('Богданова',0.1972136),
('Осипова',0.1967512),
('Сидорова',0.195942),
('Матвеева',0.1957108),
('Титова',0.1902776),
('Маркова',0.1881968),
('Миронова',0.18785),
('Крылова',0.185538),
('Куликова',0.185538),
('Карпова',0.1831104),
('Власова',0.1825324),
('Мельникова',0.1811452),
('Денисова',0.1784864),
('Гаврилова',0.178024),
('Тихонова',0.1776772),
('Казакова',0.1766368),
('Афанасьева',0.1752496),
('Данилова',0.173978),
('Савельева',0.162418),
('Тимофеева',0.1621868),
('Фомина',0.1619556),
('Чернова',0.1613776),
('Абрамова',0.160684),
('Мартынова',0.1598748),
('Ефимова',0.1591812),
('Федотова',0.1591812),
('Щербакова',0.15895),
('Назарова',0.1579096),
('Калинина',0.1534012),
('Исаева',0.1522452),
('Чернышева',0.1464652),
('Быкова',0.145078),
('Маслова',0.1443844),
('Родионова',0.1442688),
('Коновалова',0.143922),
('Лазарева',0.1428816),
('Воронина',0.1412632),
('Климова',0.1402228),
('Филатова',0.1396448),
('Пономарева',0.1390668),
('Голубева',0.13872),
('Кудрявцева',0.1371016),
('Прохорова',0.1366392),
('Наумова',0.1354832),
('Потапова',0.134674),
('Журавлева',0.134096),
('Овчинникова',0.1327088),
('Трофимова',0.1327088),
('Леонова',0.1320152),
('Соболева',0.131206),
('Ермакова',0.129472),
('Колесникова',0.129472),
('Гончарова',0.128894),
('Емельянова',0.1249636),
('Никифорова',0.121958),
('Грачева',0.1212644),
('Котова',0.1198772),
('Гришина',0.1175652),
('Ефремова',0.115022),
('Архипова',0.1147908),
('Громова',0.1139816),
('Кириллова',0.1135192),
('Малышева',0.1130568),
('Панова',0.1130568),
('Моисеева',0.11271),
('Румянцева',0.11271),
('Акимова',0.1113228),
('Кондратьева',0.1102824),
('Бирюкова',0.10982),
('Горбунова',0.108664),
('Анисимова',0.10693),
('Еремина',0.1058896),
('Тихомирова',0.1048492),
('Галкина',0.1021904),
('Лукьянова',0.1012656),
('Михеева',0.1008032),
('Скворцова',0.0996472),
('Юдина',0.0993004),
('Белоусова',0.0989536),
('Нестерова',0.0973352),
('Симонова',0.0964104),
('Прокофьева',0.0954856),
('Харитонова',0.0946764),
('Князева',0.0935204),
('Цветкова',0.0932892),
('Левина',0.0931736),
('Митрофанова',0.0920176),
('Воронова',0.0915552),
('Аксенова',0.0902836),
('Софронова',0.0902836),
('Мальцева',0.0898212),
('Логинова',0.0894744),
('Горшкова',0.0891276),
('Савина',0.0891276),
('Краснова',0.0879716),
('Майорова',0.0879716),
('Демидова',0.0873936),
('Елисеева',0.0871624),
('Рыбакова',0.0871624),
('Сафонова',0.0870468),
('Плотникова',0.0865844),
('Демина',0.086122),
('Хохлова',0.086122),
('Фадеева',0.085544),
('Молчанова',0.0854284),
('Игнатова',0.0853128),
('Литвинова',0.0853128),
('Ершова',0.0850816),
('Ушакова',0.0850816),
('Дементьева',0.0834632),
('Рябова',0.0834632),
('Мухина',0.0831164),
('Калашникова',0.082654),
('Леонтьева',0.0825384),
('Лобанова',0.0825384),
('Кузина',0.0823072),
('Корнеева',0.082076),
('Евдокимова',0.08092),
('Бородина',0.0808044),
('Платонова',0.0808044),
('Некрасова',0.0805732),
('Балашова',0.0802264),
('Боброва',0.0799952),
('Жданова',0.0799952),
('Блинова',0.0794172),
('Игнатьева',0.0789548),
('Короткова',0.0783768),
('Муравьева',0.07803),
('Крюкова',0.0776832),
('Белякова',0.0775676),
('Богомолова',0.0775676),
('Дроздова',0.0773364),
('Лаврова',0.0769896),
('Зуева',0.0767584),
('Петухова',0.0764116),
('Ларина',0.0761804),
('Никулина',0.0759492),
('Серова',0.0759492),
('Терентьева',0.0753712),
('Зотова',0.0752556),
('Устинова',0.07514),
('Фокина',0.0749088),
('Самойлова',0.0747932),
('Константинова',0.074562),
('Сахарова',0.0740996),
('Шишкина',0.073984),
('Самсонова',0.0737528),
('Черкасова',0.0736372),
('Чистякова',0.0736372),
('Носова',0.072828),
('Спиридонова',0.0724812),
('Карасева',0.0714408),
('Авдеева',0.0708628),
('Воронцова',0.0707472),
('Зверева',0.0700536),
('Владимирова',0.069938),
('Селезнева',0.0691288),
('Нечаева',0.068204),
('Кудряшова',0.0678572),
('Седова',0.067048),
('Фирсова',0.0668168),
('Андрианова',0.0667012),
('Панина',0.0667012),
('Головина',0.0660076),
('Терехова',0.0657764),
('Ульянова',0.0655452),
('Шестакова',0.0654296),
('Агеева',0.0651984),
('Никонова',0.0651984),
('Селиванова',0.0651984),
('Баженова',0.0649672),
('Гордеева',0.0649672),
('Кожевникова',0.0649672),
('Пахомова',0.064736),
('Зимина',0.0643892),
('Костина',0.0642736),
('Широкова',0.0639268),
('Филимонова',0.06358),
('Ларионова',0.0634644),
('Овсянникова',0.0631176),
('Сазонова',0.063002),
('Суворова',0.063002),
('Нефедова',0.0627708),
('Корнилова',0.0625396),
('Любимова',0.0625396),
('Львова',0.0619616),
('Горбачева',0.061846),
('Копылова',0.0617304),
('Лукина',0.0613836),
('Токарева',0.0609212),
('Кулешова',0.06069),
('Шилова',0.0603432),
('Большакова',0.0598808),
('Панкратова',0.0598808),
('Родина',0.0594184),
('Шаповалова',0.0594184),
('Покровская',0.0593028),
('Бочарова',0.0586092),
('Никольская',0.0586092),
('Маркина',0.0584936),
('Горелова',0.0578),
('Агафонова',0.0576844),
('Березина',0.0576844),
('Ермолаева',0.057222),
('Зубкова',0.057222),
('Куприянова',0.057222),
('Трифонова',0.057222),
('Масленникова',0.0564128),
('Круглова',0.0561816),
('Третьякова',0.0561816),
('Колосова',0.056066),
('Рожкова',0.056066),
('Артамонова',0.0557192),
('Шмелева',0.0556036),
('Лаптева',0.0552568),
('Лапшина',0.0541008),
('Федосеева',0.0539852),
('Зиновьева',0.053754),
('Зорина',0.053754),
('Уткина',0.0536384),
('Столярова',0.0532916),
('Зубова',0.0529448),
('Ткачева',0.0524824),
('Дорофеева',0.05202),
('Антипова',0.0516732),
('Завьялова',0.0516732),
('Свиридова',0.0516732),
('Золотарева',0.0515576),
('Кулакова',0.0515576),
('Мещерякова',0.0513264),
('Макеева',0.0504016),
('Дьяконова',0.0501704),
('Гуляева',0.0500548),
('Петровская',0.0499392),
('Бондарева',0.049708),
('Позднякова',0.049708),
('Панфилова',0.0493612),
('Кочеткова',0.0492456),
('Суханова',0.04913),
('Рыжова',0.0487832),
('Старостина',0.0486676),
('Калмыкова',0.0483208),
('Колесова',0.0480896),
('Золотова',0.047974),
('Кравцова',0.0478584),
('Субботина',0.0478584),
('Шубина',0.0478584),
('Щукина',0.0476272),
('Лосева',0.0475116),
('Винокурова',0.0472804),
('Лапина',0.0472804),
('Парфенова',0.0472804),
('Исакова',0.0470492),
('Голованова',0.0464712),
('Коровина',0.0464712),
('Розанова',0.0463556),
('Артемова',0.04624),
('Козырева',0.04624),
('Русакова',0.0460088),
('Алешина',0.0458932),
('Крючкова',0.0458932),
('Булгакова',0.045662),
('Кошелева',0.0451996),
('Сычева',0.0451996),
('Синицына',0.045084),
('Черных',0.0442748),
('Рогова',0.0440436),
('Кононова',0.0438124),
('Лаврентьева',0.0435812),
('Евсеева',0.0434656),
('Пименова',0.0434656),
('Пантелеева',0.0432344),
('Горячева',0.0431188),
('Аникина',0.0430032),
('Лопатина',0.0430032),
('Рудакова',0.0430032),
('Одинцова',0.042772),
('Серебрякова',0.042772),
('Панкова',0.0426564),
('Дегтярева',0.0424252),
('Орехова',0.0424252),
('Царева',0.0419628),
('Шувалова',0.0411536),
('Кондрашова',0.041038),
('Горюнова',0.0408068),
('Дубровина',0.0408068),
('Голикова',0.0403444),
('Курочкина',0.0402288),
('Латышева',0.0402288),
('Севастьянова',0.0402288),
('Вавилова',0.0399976),
('Ерофеева',0.039882),
('Сальникова',0.039882),
('Клюева',0.0397664),
('Носкова',0.0391884),
('Озерова',0.0391884),
('Кольцова',0.0390728),
('Комиссарова',0.0389572),
('Меркулова',0.0389572),
('Киреева',0.038726),
('Хомякова',0.038726),
('Булатова',0.0382636),
('Ананьева',0.0380324),
('Бурова',0.0378012),
('Шапошникова',0.0378012),
('Дружинина',0.0374544),
('Островская',0.0374544),
('Шевелева',0.036992),
('Долгова',0.0368764),
('Суслова',0.0368764),
('Шевцова',0.0366452),
('Пастухова',0.0365296),
('Рубцова',0.0361828),
('Бычкова',0.0360672),
('Глебова',0.0360672),
('Ильинская',0.0360672),
('Успенская',0.0360672),
('Дьякова',0.035836),
('Кочетова',0.035836),
('Вишневская',0.0354892),
('Высоцкая',0.035258),
('Глухова',0.035258),
('Дубова',0.035258),
('Бессонова',0.0349112),
('Ситникова',0.0349112),
('Астафьева',0.03468),
('Мешкова',0.03468),
('Шарова',0.03468),
('Яшина',0.0345644),
('Козловская',0.0344488),
('Туманова',0.0344488),
('Басова',0.0342176),
('Корчагина',0.034102),
('Болдырева',0.0338708),
('Олейникова',0.0338708),
('Чумакова',0.0338708),
('Фомичева',0.0336396),
('Губанова',0.0334084),
('Дубинина',0.0334084),
('Шульгина',0.0334084),
('Касаткина',0.032946),
('Пирогова',0.032946),
('Семина',0.032946),
('Трошина',0.0328304),
('Горохова',0.0325992),
('Старикова',0.0325992),
('Щеглова',0.0324836),
('Фетисова',0.0322524),
('Колпакова',0.0321368),
('Чеснокова',0.0321368),
('Зыкова',0.0320212),
('Верещагина',0.0316744),
('Минаева',0.0314432),
('Руднева',0.0314432),
('Троицкая',0.0314432),
('Окулова',0.0313276),
('Ширяева',0.0313276),
('Малинина',0.031212),
('Черепанова',0.031212),
('Измайлова',0.0309808),
('Алехина',0.030634),
('Зеленина',0.030634),
('Касьянова',0.030634),
('Пугачева',0.030634),
('Павловская',0.0305184),
('Чижова',0.0305184),
('Кондратова',0.0304028),
('Воронкова',0.0301716),
('Капустина',0.0301716),
('Сотникова',0.0301716),
('Демьянова',0.030056),
('Косарева',0.0297092),
('Беликова',0.0293624),
('Сухарева',0.0293624),
('Белкина',0.0292468),
('Беспалова',0.0292468),
('Кулагина',0.0292468),
('Савицкая',0.0292468),
('Жарова',0.0292468),
('Хромова',0.0290156),
('Еремеева',0.0289),
('Карташова',0.0289),
('Астахова',0.0284376),
('Русанова',0.0284376),
('Сухова',0.0284376),
('Вешнякова',0.0282064),
('Волошина',0.0282064),
('Козина',0.0282064),
('Худякова',0.0282064),
('Жилина',0.0279752),
('Малахова',0.0276284),
('Сизова',0.0273972),
('Ежова',0.027166),
('Толкачева',0.027166),
('Анохина',0.0268192),
('Вдовина',0.0268192),
('Бабушкина',0.0267036),
('Усова',0.0267036),
('Лыкова',0.0264724),
('Горлова',0.0263568),
('Коршунова',0.0263568),
('Маркелова',0.0261256),
('Постникова',0.02601),
('Черная',0.02601),
('Дорохова',0.0258944),
('Свешникова',0.0258944),
('Гущина',0.0256632),
('Калугина',0.0256632),
('Блохина',0.0255476),
('Суркова',0.0255476),
('Кочергина',0.0253164),
('Грекова',0.0250852),
('Казанцева',0.0250852),
('Швецова',0.0250852),
('Ермилова',0.024854),
('Парамонова',0.024854),
('Агапова',0.0247384),
('Минина',0.0247384),
('Корнева',0.0245072),
('Черняева',0.0245072),
('Гурова',0.024276),
('Ермолова',0.024276),
('Сомова',0.024276),
('Добрынина',0.0240448),
('Барсукова',0.023698),
('Глушкова',0.0234668),
('Чеботарева',0.0234668),
('Москвина',0.0232356),
('Уварова',0.0232356),
('Безрукова',0.02312),
('Муратова',0.02312),
('Ракова',0.0228888),
('Снегирева',0.0228888),
('Гладкова',0.0227732),
('Злобина',0.0227732),
('Моргунова',0.0227732),
('Поликарпова',0.0227732),
('Рябинина',0.0227732),
('Судакова',0.0226576),
('Кукушкина',0.0223108),
('Калачева',0.0220796),
('Грибова',0.021964),
('Елизарова',0.021964),
('Звягинцева',0.021964),
('Королькова',0.021964),
('Федосова',0.021964);

DROP VIEW IF EXISTS get_fullname;
CREATE VIEW get_fullname AS ((SELECT
	ml.name AS last_name,
	mf.name AS first_name,
	mm.name AS middle_name
    FROM male_first_names mf, male_middle_names mm, male_last_names ml
ORDER BY rand() DESC
LIMIT 50)
UNION
(SELECT
	fl.name AS last_name,
	ff.name AS first_name,
	fm.name AS middle_name
    FROM female_first_names ff, female_middle_names fm, female_last_names fl
ORDER BY rand() DESC
LIMIT 50)) ORDER BY rand();