-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 05 2026 г., 04:40
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `travel_site_oktagon`
--

-- --------------------------------------------------------

--
-- Структура таблицы `administrator`
--

CREATE TABLE `administrator` (
  `ID_администратора` int(32) NOT NULL,
  `Логин` varchar(32) NOT NULL,
  `Пароль` int(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `custom_routse`
--

CREATE TABLE `custom_routse` (
  `Route_custom_ID` int(11) NOT NULL,
  `Tourist_ID` int(11) DEFAULT NULL,
  `Route_Name` varchar(255) DEFAULT NULL,
  `Route_Description` varchar(255) DEFAULT NULL,
  `Route_Length` int(11) DEFAULT NULL,
  `Route_Type` varchar(255) DEFAULT NULL,
  `Route_Duration` varchar(255) DEFAULT NULL,
  `Terrain_Type` varchar(255) DEFAULT NULL,
  `WaiPoint1` varchar(255) DEFAULT NULL,
  `WaiPoint2` varchar(255) DEFAULT NULL,
  `WaiPoint3` varchar(255) DEFAULT NULL,
  `WaiPoint4` varchar(255) DEFAULT NULL,
  `WaiPoint5` varchar(255) DEFAULT NULL,
  `WaiPoint6` varchar(255) DEFAULT NULL,
  `WaiPoint7` varchar(255) DEFAULT NULL,
  `WaiPoint8` varchar(255) DEFAULT NULL,
  `WaiPoint9` varchar(255) DEFAULT NULL,
  `WaiPoint10` varchar(255) DEFAULT NULL,
  `WaiPoint11` varchar(255) DEFAULT NULL,
  `WaiPoint12` varchar(255) DEFAULT NULL,
  `WaiPoint13` varchar(255) DEFAULT NULL,
  `WaiPoint14` varchar(255) DEFAULT NULL,
  `WaiPoint15` varchar(255) DEFAULT NULL,
  `WaiPoint16` varchar(255) DEFAULT NULL,
  `WaiPoint17` varchar(255) DEFAULT NULL,
  `WaiPoint18` varchar(255) DEFAULT NULL,
  `WaiPoint19` varchar(255) DEFAULT NULL,
  `WaiPoint20` varchar(255) DEFAULT NULL,
  `Map_Zoom` int(11) DEFAULT NULL,
  `Map_Center` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `custom_routse`
--

INSERT INTO `custom_routse` (`Route_custom_ID`, `Tourist_ID`, `Route_Name`, `Route_Description`, `Route_Length`, `Route_Type`, `Route_Duration`, `Terrain_Type`, `WaiPoint1`, `WaiPoint2`, `WaiPoint3`, `WaiPoint4`, `WaiPoint5`, `WaiPoint6`, `WaiPoint7`, `WaiPoint8`, `WaiPoint9`, `WaiPoint10`, `WaiPoint11`, `WaiPoint12`, `WaiPoint13`, `WaiPoint14`, `WaiPoint15`, `WaiPoint16`, `WaiPoint17`, `WaiPoint18`, `WaiPoint19`, `WaiPoint20`, `Map_Zoom`, `Map_Center`) VALUES
(1, 0, 'Название', 'Пользовательский маршрут', 13900, 'Custom', '2.78 ч', 'Mixed', '56.015272531542344, 37.38372802734376', '55.966881490388445, 37.40158081054688', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 0, 'Название', 'Пользовательский маршрут', 2719390, 'Custom', '543.88 ч', 'Mixed', '56.015272531542344, 37.38372802734376', '55.966881490388445, 37.40158081054688', '56.0965557505683, 35.73852539062501', '56.674338416158825, 38.70483398437501', '53.75520681580148, 35.60668945312501', '55.57213384241379, 39.72656250000001', '56.35916436114858, 39.52880859375', '55.57213384241379, 40.50659179687501', '54.95869417101664, 38.12255859375001', '55.30413773740139, 35.69458007812501', '55.893796284148955, 34.20043945312501', '57.231502991478926, 37.36450195312501', '56.96893619436121, 34.61791992187501', '56.1210604250441, 35.98022460937501', '54.65476860921582, 36.35375976562501', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 0, 'ждлнпавывуаперолдж.э', 'Пользовательский маршрут', 43780, 'Custom', '8.76 ч', 'Mixed', '55.775800642613135, 37.37686157226563', '55.868376522659915, 37.49084472656251', '55.78197922246136, 37.81356811523438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 0, 'Название', 'Пользовательский маршрут', 5140, 'Custom', '1.03 ч', 'Mixed', '55.83831352210821, 37.51281738281251', '55.80977071070357, 37.53479003906251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 22, 'Название', 'Пользовательский маршрут', 11640, 'Custom', '2.33 ч', 'Mixed', '55.88147363004733, 37.61718750000001', '55.87145859243408, 37.76138305664063', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 22, 'Название', 'Пользовательский маршрут', 8990, 'Custom', '1.80 ч', 'Mixed', '55.903035707281575, 37.54165649414063', '55.86914706303444, 37.64739990234376', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 22, 'klhgfdasdgyukihjggf', 'Пользовательский маршрут', 14490, 'Custom', '2.90 ч', 'Mixed', '55.845253201954556, 37.42080688476563', '55.80359653829958, 37.58422851562501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 22, 'Название', 'Пользовательский маршрут', 11020, 'Custom', '2.20 ч', 'Mixed', '55.89764631120948, 37.45239257812501', '55.822116117988486, 37.51831054687501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 22, 'Название', 'Пользовательский маршрут', 53160, 'Custom', '10.63 ч', 'Mixed', '55.89764631120948, 37.45239257812501', '55.822116117988486, 37.51831054687501', '55.93151007833612, 37.418746948242195', '55.93651017309418, 37.33703613281251', '55.90034110284037, 37.30545043945313', '55.84949350761968, 37.33016967773438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 24, 'Название', 'Пользовательский маршрут', 24200, 'Custom', '4.84 ч', 'Mixed', '55.79896526634486, 37.694091796875', '55.822887575908794, 37.82592773437501', '55.82365901853182, 37.63504028320313', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 24, 'Название', 'Пользовательский маршрут', 15480, 'Custom', '3.10 ч', 'Mixed', '55.870688097921345, 37.832794189453125', '55.7742558445822, 37.75177001953126', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 24, 'Название', 'Пользовательский маршрут', 35830, 'Custom', '7.17 ч', 'Mixed', '55.92766341247032, 37.88085937500001', '55.83368638065533, 37.93579101562501', '55.79819333412856, 37.63366699218751', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 24, 'hfds', 'Пользовательский маршрут', 35830, 'Custom', '7.17 ч', 'Mixed', '55.92766341247032, 37.88085937500001', '55.83368638065533, 37.93579101562501', '55.79819333412856, 37.63366699218751', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 24, 'Зимняя сказка Карелии', 'Пользовательский маршрут', 1050, 'Custom', '0.21 ч', 'Mixed', '62.2678, 33.9833', '62.2751, 33.9806', '62.2755, 33.9841', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 24, 'FVFVFV', 'Пользовательский маршрут', 37610, 'Custom', '7.52 ч', 'Mixed', '55.898416270776835, 37.63504028320313', '55.79973718325882, 37.76824951171875', '55.72943006127542, 37.51693725585938', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 24, 'Зимняя сказка Карелии', 'Пользовательский маршрут', 1050, 'Custom', '0.21 ч', 'Mixed', '62.2678, 33.9833', '62.2751, 33.9806', '62.2755, 33.9841', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 24, 'Зимняя сказка Карелии', 'Пользовательский маршрут', 1050, 'Custom', '0.21 ч', 'Mixed', '62.2678, 33.9833', '62.2751, 33.9806', '62.2755, 33.9841', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 24, 'KUHTGSFADHGJKGFSDA', 'Пользовательский маршрут', 25820, 'Custom', '5.16 ч', 'Mixed', '55.81748704921519, 37.67211914062501', '55.7765730186677, 37.8643798828125', '55.70931902037372, 37.81356811523438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 24, 'Название', 'Пользовательский маршрут', 5800, 'Custom', '1.16 ч', 'Mixed', '55.82828735303679, 37.60757446289063', '55.79896526634486, 37.65014648437501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 24, 'Название', 'Пользовательский маршрут', 5800, 'Custom', '1.16 ч', 'Mixed', '55.82828735303679, 37.60757446289063', '55.79896526634486, 37.65014648437501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 24, 'Название', 'Пользовательский маршрут', 5800, 'Custom', '1.16 ч', 'Mixed', '55.82828735303679, 37.60757446289063', '55.79896526634486, 37.65014648437501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 24, 'Зимняя сказка Карелии', 'Пользовательский маршрут', 3080, 'Custom', '0.62 ч', 'Mixed', '62.2678, 33.9833', '62.2751, 33.9806', '62.2755, 33.9841', '62.27890419644036, 33.9763355255127', '62.274551981654334, 33.97916793823243', '62.26732351967657, 33.97496223449708', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 24, 'Название', 'Пользовательский маршрут', 9200, 'Custom', '1.84 ч', 'Mixed', '16.307618466639035, -61.49734497070313', '16.291801339469128, -61.44378662109376', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 24, 'KJYHGFHJKGFHG', 'Пользовательский маршрут', 35290, 'Custom', '7.06 ч', 'Mixed', '61.778318564713175, 50.62911987304688', '61.68856962337029, 50.58242797851563', '61.63740003203868, 50.66894531250001', '61.60672288745969, 50.65933227539063', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 24, 'KJYHGFHJKGFHG', 'Пользовательский маршрут', 35290, 'Custom', '7.06 ч', 'Mixed', '61.778318564713175, 50.62911987304688', '61.68856962337029, 50.58242797851563', '61.63740003203868, 50.66894531250001', '61.60672288745969, 50.65933227539063', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 24, 'KJYHGFHJKGFHG', 'Пользовательский маршрут', 107350, 'Custom', '21.47 ч', 'Mixed', '61.778318564713175, 50.62911987304688', '61.68856962337029, 50.58242797851563', '61.63740003203868, 50.66894531250001', '61.60672288745969, 50.65933227539063', '61.75428109163535, 50.4931640625', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 24, 'QWEQWEQEQEQWE', 'Пользовательский маршрут', 472310, 'Custom', '94.46 ч', 'Mixed', '61.33466012375646, 73.07628726919692', '60.91020888488149, 73.51574039419692', '59.95019685841227, 71.26419067382814', '59.74532608213611, 70.38391113281251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `guides`
--

CREATE TABLE `guides` (
  `Guide_ID` int(64) UNSIGNED NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `First_Name` varchar(255) DEFAULT NULL,
  `Last_Name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Guide_License` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `experience` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `guides`
--

INSERT INTO `guides` (`Guide_ID`, `login`, `password`, `First_Name`, `Last_Name`, `phone`, `email`, `Age`, `Guide_License`, `role`, `experience`) VALUES
(1, '', '$2b$10$cH59E9QBA0iz07iDOcwY2eB1uSQ/sSD3rgGoMM29zfO6U//Y6bMpG', 'Eldar', 'Sibrimov', '', 'qwerty5834assa323es7216s54a27324@gmail.com', 0, '0', '', ''),
(2, '', '$2b$10$d1HvM/wEksIcrTrN4Z8aMeNVHA.ZG10LoZavAwQmfrhbLDdqH6hDu', 'Eldar', 'Sibrimov', '', 'qwerty5834asssa323es721654a27324@gmail.com', 0, '0', '', ''),
(3, '', '$2b$10$20Fjoat0.y1zfmcmkRJKee1fN3q7AIuu/AQJgdB6SwKaSb/RmYEjW', 'Eldar', 'Sibrimov', '', 'qwerty5834assa323es7s1654a27324@gmail.com', 0, '0', '', ''),
(4, '', '$2b$10$QAa31tSvMY8G8wliqIA2zOPUw7edDUfDtt5d64UiAh6G3nGtjD4nm', 'Eldar', 'Sibrimov', '', 'qwerty5834assa32x3es721654a27324@gmail.com', 0, '0', '', ''),
(5, '', '$2b$10$ZOFBw1MBEmGkFNNEK1EaXOtnC4DoNgTmyZ.lPwzW4hAFrqrT1rqiq', 'Eldar', 'Sibrimov', '', 'qwerty5834assa3gf2x3es721654a27324@gmail.com', 0, '0', '', ''),
(6, NULL, '$2b$10$B/PtQmv7vBPbRxhSeSSxluWklAkeq7SaO2ekAN3WFMB2XRN9tCfyO', 'Eldar', 'Sibrimov', NULL, 'qwerty58asd34assa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `routes`
--

CREATE TABLE `routes` (
  `Route_ID` int(255) NOT NULL,
  `Route_Name` varchar(255) DEFAULT NULL,
  `Route_Description` varchar(255) DEFAULT NULL,
  `Route_Length` int(11) DEFAULT NULL,
  `Route_Type` varchar(255) DEFAULT NULL,
  `Route_Duration` time DEFAULT NULL,
  `Terrain_Type` varchar(255) DEFAULT NULL,
  `Required_Equipment` varchar(255) DEFAULT NULL,
  `Equipment_Cost` int(11) DEFAULT NULL,
  `Cost_organization` int(11) DEFAULT NULL,
  `Guide_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `routes`
--

INSERT INTO `routes` (`Route_ID`, `Route_Name`, `Route_Description`, `Route_Length`, `Route_Type`, `Route_Duration`, `Terrain_Type`, `Required_Equipment`, `Equipment_Cost`, `Cost_organization`, `Guide_ID`) VALUES
(1, 'Зимняя сказка Карелии', 'Маршрут проходит через заснеженные карельские леса к незамерзающим водопадам. Идеально подходит для любителей зимней фотографии и тишины.', 15, 'Пеший', '05:00:00', 'Лес, снег', 'Теплая обувь, термос', 5000, 1500, 0),
(2, 'Ледяной Байкал', 'Прогулка по прозрачному льду озера Байкал с посещением ледяных гротов. В зимний период лед достигает максимальной прочности и красоты.', 20, 'Коньковый', '06:30:00', 'Лед', 'Коньки, ледоступы', 5000, 3500, 0),
(3, 'Альпийский спуск', 'Горнолыжный спуск средней сложности с подготовленными трассами. Работает исключительно в зимние месяцы при наличии снежного покрова.', 5, 'Лыжный', '02:00:00', 'Горы', 'Лыжи, шлем', 15000, 4000, 0),
(4, 'Огни ночного города', 'Городской маршрут по празднично украшенным центральным улицам и площадям. Лучшее время для прогулки — вечер декабря или января.', 8, 'Пеший', '03:00:00', 'Асфальт', 'Удобная обувь', 0, 500, 0),
(5, 'Тропа хаски', 'Маршрут для катания на собачьих упряжках по подготовленной снежной трассе. Отличное зимнее приключение для всей семьи.', 10, 'Упряжки', '01:30:00', 'Снежная трасса', 'Зимний комбинезон', 8000, 12000, 0),
(6, 'Горячие источники', 'Путь к открытым термальным бассейнам через заснеженное предгорье. Контраст ледяного воздуха и горячей воды бодрит и оздоравливает.', 12, 'Авто-пеший', '04:00:00', 'Предгорье', 'Купальные принадлежности', 3000, 2500, 0),
(7, 'Заповедный лес', 'Экологическая тропа в национальном парке, где можно встретить диких животных в их зимнем обитании. Требует соблюдения тишины.', 7, 'Пеший/Лыжный', '04:30:00', 'Смешанный лес', 'Снегоступы', 1500, 800, 0),
(8, 'Ледяная пещера', 'Спуск в пещеру, где зимой образуются уникальные ледяные сталактиты и сталагмиты. Температура внутри стабильно низкая.', 3, 'Спелео', '02:00:00', 'Пещера', 'Фонарь, каска', 2500, 1200, 0),
(9, 'Вершины Хибин', 'Восхождение на небольшую вершину с панорамным видом на северное сияние. Маршрут доступен только при благоприятном прогнозе погоды.', 6, 'Альпинизм', '08:00:00', 'Скалы, снег', 'Кошки, ледоруб', 10000, 5000, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `route_point`
--

CREATE TABLE `route_point` (
  `Point_ID` int(255) NOT NULL,
  `Point_Name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Sequence_Number` int(11) NOT NULL,
  `Coordinates` varchar(255) NOT NULL,
  `Route_ID` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `route_point`
--

INSERT INTO `route_point` (`Point_ID`, `Point_Name`, `Description`, `Sequence_Number`, `Coordinates`, `Route_ID`) VALUES
(1, 'Вход в заповедник Кивач', 'Начало маршрута, оформление пропусков.', 1, '62.2678, 33.9833', 1),
(2, 'Водопад Кивач', 'Осмотр одного из крупнейших равнинных водопадов Европы.', 2, '62.2751, 33.9806', 1),
(3, 'Музей природы', 'Экспозиция флоры и фауны Карелии.', 3, '62.2755, 33.9841', 1),
(4, 'Порт Хужир', 'Выход на лед Байкала.', 1, '53.1939, 107.3394', 2),
(5, 'Скала Шаманка (мыс Бурхан)', 'Главная святыня озера и ледяные гроты.', 2, '53.2041, 107.3371', 2),
(6, 'Мыс Хобой', 'Северная оконечность острова с видом на бескрайний лед.', 3, '53.4095, 107.7891', 2),
(7, 'Нижняя станция канатной дороги', 'Точка сбора и аренда оборудования.', 1, '43.6841, 40.2644', 3),
(8, 'Верхний приют', 'Панорамная площадка на высоте.', 2, '43.6617, 40.2711', 3),
(9, 'Финиш трассы', 'Окончание спуска у базы отдыха.', 3, '43.6822, 40.2599', 3),
(10, 'Площадь Советов', 'Главная елка и начало праздничного маршрута.', 1, '55.7558, 37.6173', 4),
(11, 'Пешеходный бульвар', 'Зона праздничной иллюминации.', 2, '55.7611, 37.6089', 4),
(12, 'Арт-объект \"Ледяной город\"', 'Финальная точка с ледяными скульптурами.', 3, '55.7655, 37.6011', 4),
(13, 'Стартовый городок', 'Инструктаж по управлению упряжкой.', 1, '61.7850, 34.3469', 5),
(14, 'Лесной круг', 'Середина дистанции в хвойном лесу.', 2, '61.7922, 34.3555', 5),
(15, 'Питомник', 'Возвращение на базу и общение с собаками.', 3, '61.7852, 34.3475', 5),
(16, 'Термальный комплекс', 'Вход в зону отдыха.', 1, '44.5122, 40.1011', 6),
(17, 'Минеральный бювет', 'Природный источник питьевой воды.', 2, '44.5155, 40.1044', 6),
(18, 'Визит-центр', 'Получение карт и инструкций.', 1, '54.0667, 35.0333', 7),
(19, 'Смотровая вышка', 'Наблюдение за зубрами в зимнем лесу.', 2, '54.0711, 35.0455', 7),
(20, 'Вход в пещеру', 'Начало подземного маршрута.', 1, '57.4408, 57.0058', 8),
(21, 'Бриллиантовый грот', 'Зал с уникальными ледяными кристаллами.', 2, '57.4415, 57.0077', 8),
(22, 'Подножие горы Айкуайвенчорр', 'Начало подъема.', 1, '67.5861, 33.6733', 9),
(23, 'Вершина со смотровой', 'Лучшая точка для наблюдения полярного сияния.', 2, '67.5922, 33.6811', 9);

-- --------------------------------------------------------

--
-- Структура таблицы `route_points`
--

CREATE TABLE `route_points` (
  `Point_ID` int(11) NOT NULL,
  `Route_ID` int(11) NOT NULL,
  `Point_Name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Order` int(11) NOT NULL,
  `Coordinates` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `route_points`
--

INSERT INTO `route_points` (`Point_ID`, `Route_ID`, `Point_Name`, `Description`, `Order`, `Coordinates`) VALUES
(1, 1, 'Вход в заповедник Кивач', 'Начало маршрута, оформление пропусков.', 1, '62.2678, 33.9833'),
(2, 1, 'Водопад Кивач', 'Осмотр одного из крупнейших равнинных водопадов Европы.', 2, '62.2751, 33.9806'),
(3, 1, 'Музей природы', 'Экспозиция флоры и фауны Карелии.', 3, '62.2755, 33.9841'),
(4, 2, 'Порт Хужир', 'Выход на лед Байкала.', 1, '53.1939, 107.3394'),
(5, 2, 'Скала Шаманка (мыс Бурхан)', 'Главная святыня озера и ледяные гроты.', 2, '53.2041, 107.3371'),
(6, 2, 'Мыс Хобой', 'Северная оконечность острова с видом на бескрайний лед.', 3, '53.4095, 107.7891'),
(7, 3, 'Нижняя станция канатной дороги', 'Точка сбора и аренда оборудования.', 1, '43.6841, 40.2644'),
(8, 3, 'Верхний приют', 'Панорамная площадка на высоте.', 2, '43.6617, 40.2711'),
(9, 3, 'Финиш трассы', 'Окончание спуска у базы отдыха.', 3, '43.6822, 40.2599'),
(10, 4, 'Площадь Советов', 'Главная елка и начало праздничного маршрута.', 1, '55.7558, 37.6173'),
(11, 4, 'Пешеходный бульвар', 'Зона праздничной иллюминации.', 2, '55.7611, 37.6089'),
(12, 4, 'Арт-объект \"Ледяной город\"', 'Финальная точка с ледяными скульптурами.', 3, '55.7655, 37.6011'),
(13, 5, 'Стартовый городок', 'Инструктаж по управлению упряжкой.', 1, '61.7850, 34.3469'),
(14, 5, 'Лесной круг', 'Середина дистанции в хвойном лесу.', 2, '61.7922, 34.3555'),
(15, 5, 'Питомник', 'Возвращение на базу и общение с собаками.', 3, '61.7852, 34.3475'),
(16, 6, 'Термальный комплекс', 'Вход в зону отдыха.', 1, '44.5122, 40.1011'),
(17, 6, 'Минеральный бювет', 'Природный источник питьевой воды.', 2, '44.5155, 40.1044'),
(18, 7, 'Визит-центр', 'Получение карт и инструкций.', 1, '54.0667, 35.0333'),
(19, 7, 'Смотровая вышка', 'Наблюдение за зубрами в зимнем лесу.', 2, '54.0711, 35.0455'),
(20, 8, 'Вход в пещеру', 'Начало подземного маршрута.', 1, '57.4408, 57.0058'),
(21, 8, 'Бриллиантовый грот', 'Зал с уникальными ледяными кристаллами.', 2, '57.4415, 57.0077'),
(22, 9, 'Подножие горы Айкуайвенчорр', 'Начало подъема.', 1, '67.5861, 33.6733'),
(23, 9, 'Вершина со смотровой', 'Лучшая точка для наблюдения полярного сияния.', 2, '67.5922, 33.6811');

-- --------------------------------------------------------

--
-- Структура таблицы `route_schedule`
--

CREATE TABLE `route_schedule` (
  `Schedule_ID` int(255) NOT NULL,
  `Route_custom_ID` int(255) NOT NULL,
  `Point_Index` int(11) NOT NULL,
  `Visit_Date` datetime NOT NULL,
  `Visit_Time` time NOT NULL,
  `Note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `route_schedule`
--

INSERT INTO `route_schedule` (`Schedule_ID`, `Route_custom_ID`, `Point_Index`, `Visit_Date`, `Visit_Time`, `Note`) VALUES
(1, 6, 1, '2025-12-28 00:00:00', '03:02:00', 'Запланировано'),
(2, 7, 1, '2025-12-28 00:00:00', '02:01:00', 'Запланировано'),
(3, 7, 2, '2025-12-28 00:00:00', '01:04:00', 'Запланировано'),
(4, 8, 1, '2025-12-28 00:00:00', '00:00:00', 'Запланировано'),
(5, 10, 1, '2025-12-28 00:00:00', '01:01:00', 'Запланировано'),
(6, 10, 1, '2025-12-28 00:00:00', '04:03:00', 'Запланировано'),
(7, 14, 2, '2026-01-03 00:00:00', '02:01:00', 'Запланировано'),
(8, 19, 1, '2026-01-04 00:00:00', '03:01:00', 'Запланировано'),
(9, 20, 1, '2026-01-04 00:00:00', '03:01:00', 'Запланировано'),
(10, 21, 1, '2026-01-04 00:00:00', '03:01:00', 'Запланировано'),
(11, 21, 2, '2026-01-05 00:00:00', '00:00:00', 'Запланировано');

-- --------------------------------------------------------

--
-- Структура таблицы `tourist`
--

CREATE TABLE `tourist` (
  `Tourist_ID` int(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `First_Name` varchar(255) DEFAULT NULL,
  `Last_Name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `experience` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `tourist`
--

INSERT INTO `tourist` (`Tourist_ID`, `password`, `First_Name`, `Last_Name`, `phone`, `email`, `gender`, `age`, `role`, `experience`) VALUES
(1, '2tC-pXQ-2Pc-gby', 'Eldar', 'Sibrimov', '', 'qwerty583274@gmail.com', '', 0, 'organizer', 'amateur'),
(2, '$2b$10$91lHghc4jdBs5L8l2PU1yu8Sgi3.5L8TslsTvdWija2RWieOHG/K2', 'Eldar', 'Sibrimov', '', 'qwerty583274@gmail.com', '', 0, 'participant', 'beginner'),
(3, '$2b$10$UBQZaFI97jZlM8TOto3p..I9.0N9nDIXthtiTU1KNohsvQ424AQVC', 'Eldar', 'Sibrimov', '', 'qwerty583274@gmail.com', '', 0, 'participant', 'beginner'),
(4, '$2b$10$nVbnktLwztURHqR/CUUXi.mXGprLE7Gz9LVhWM641S0oE.d4Fy5/O', 'Eldar', 'Sibrimov', '', 'qwerty583274@gmail.com', '', 0, 'participant', 'beginner'),
(5, '$2b$10$yRzvQ35uUre1r0PSnvUKMuxQQxAd/G/hMBtF1z8ZGzVbsFPI0DDnW', 'Eldar', 'Sibrimov', '', 'qwerty583274@gmail.com', '', 0, 'organizer', 'beginner'),
(6, '$2b$10$QifMM4W1FfCBybYKw9PXu.8cCZcaw/dffbZX7IZzGW1XM8R64vXCO', 'Eldar', 'Sibrimov', '', 'qwerty5834323274@gmail.com', '', 0, 'organizer', 'experienced'),
(7, '$2b$10$Hpgr7gSjUZisNUiHCbheJOVP/L1h0PH8NKdRhhrUHNL/mYrU9KMUa', 'Eldar', 'Sibrimov', '', 'qwerty58343237654274@gmail.com', '', 0, 'organizer', 'experienced'),
(8, '$2b$10$hqHS8EcQffOcAwtSQnGUDux22w3060uhpyl3Tly7Xj7fZdMf.s0mW', 'Eldar', 'Sibrimov', '', 'qwerty58343237654a274@gmail.com', '', 0, 'organizer', 'experienced'),
(9, '$2b$10$gjQhxMsaQtLTxOksgw2/X.OaO8ZBc.2TgqhMPnqV0Ccno0cY0ry1a', 'Eldar', 'Sibrimov', '', 'qwerty58343237654a27324@gmail.com', '', 0, 'organizer', 'experienced'),
(10, '$2b$10$.nb.rLX0CFwA26wlp0tzYu5KL4gO0o3Fue/ZDpMs4HnMMUgaKuby.', 'Eldar', 'Sibrimov', '', 'qwerty5834323721654a27324@gmail.com', '', 0, 'participant', 'experienced'),
(11, '$2b$10$5JeGgP5r3RtqOG1umVc.VOiqLK1CHwal6Iz8HFfZSOMAzB9Op.I92', 'Eldar', 'Sibrimov', '', 'qwerty5834as323721654a27324@gmail.com', '', 0, 'organizer', 'experienced'),
(12, '$2b$10$.Dm59LqNko2B19OjU77nPOQAcXXNmnGQOpqvw4gCSLTHcS03MG5tK', 'Eldar', 'Sibrimov', '', 'qwerty5834as323es721654a27324@gmail.com', '', 0, 'participant', 'experienced'),
(13, '$2b$10$bpdAhvfmd0gF3wjGJrXdbuWZEJdzMd/RDf794QK0XVesZV3iU245C', 'Eldar', 'Sibrimov', '', 'qwerty5834assa323es721654a27324@gmail.com', '', 0, 'participant', 'experienced'),
(14, '$2b$10$uDBEmvfciivSwG3h4.sPxO5jVp4rMUL/CWFOL6Id7zlkAtAtw3zTy', 'Eldar', 'Sibrimov', NULL, 'qwerty5834assa3sxsgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'amateur'),
(15, '$2b$10$Zh4xv4DkN5MJfs1FKUdVReNrAlpXdgY1HTqE3EixJn8fu4oc.KARm', 'Eldar', 'Sibrimov', NULL, 'qwerty5834assa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(16, '$2b$10$CY45QYFK41GpmOUP0mH/Pul09Lsym/HpkOOibO9OT0vymAK66ZoYm', 'Eldar', 'Sibrimov', NULL, 'qwersty58asd34assa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(17, '$2b$10$lKyJB9e.bAgrvyeRzCZv3OuapSv/0dHgS3EPUCioghAngIW3qNT3G', 'Eldar', 'Sibrimov', NULL, 'qwersty58asd34dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'amateur'),
(18, '$2b$10$pTGafrSSBPNODBjTiPx48O/99tUKDUTKc0lSHNbfYu5Fdxs.1Vw8S', 'Eldar', 'Sibrimov', NULL, 'qwersty58asd3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(19, '$2b$10$cbA0k/1Y5Nsr4gln/4jnk.4l7o4DUGio1EO7tks.B.ZmtGxBd449O', 'Eldar', 'Sibrimov', NULL, 'qwersty58asdsdf3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'experienced'),
(20, '$2b$10$mqtgnLNeme4tSOyu/uL0b.vccwJx6J/.84Qypz5TAvZTKRARH5Z6G', 'Eldar', 'Sibrimov', NULL, 'qwersty58asasdd3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(21, '$2b$10$iSMEBrrGNcy5WphEHBpsY.MZRz/1b0LWOo0X9q/DdxGqt3XcM582C', 'Eldar', 'Sibrimov', NULL, 'qwersty58asasdqwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(22, '$2b$10$QJK9p80Lxan6DhKVWYnvzuvKaTNeib62LS20NZgLBc0hP5refEPzG', 'Eldar', 'Sibrimov', NULL, 'qwersty58fdasasdqwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(23, '$2b$10$Bik2OKYjPDGPLm0IPwYZMeddRfwoUK2eIke4X5VOTYXDEXRVEU./6', 'er', 'erre', NULL, 'eldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner'),
(24, '$2b$10$TKPbFKO4q7kVZc1EDbrJjeimQFwJihxLaasL.5w.ujOwmpL7WR9g.', 'Eldar', 'Sibrimov', NULL, 'qwersty58fdawsasdqwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner');

-- --------------------------------------------------------

--
-- Структура таблицы `trip_request`
--

CREATE TABLE `trip_request` (
  `Trip_ID` int(255) NOT NULL,
  `Route_ID` int(11) DEFAULT NULL,
  `Guide_ID` int(11) DEFAULT NULL,
  `Tourist_ID` int(11) DEFAULT NULL,
  `Trip_Start_Date` datetime DEFAULT NULL,
  `Trip_End_Date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `trip_request`
--

INSERT INTO `trip_request` (`Trip_ID`, `Route_ID`, `Guide_ID`, `Tourist_ID`, `Trip_Start_Date`, `Trip_End_Date`) VALUES
(10, 1, 0, 0, '2025-12-15 00:00:00', '0000-00-00 00:00:00'),
(11, 2, 0, 0, '2026-01-10 00:00:00', '0000-00-00 00:00:00'),
(12, 1, 0, NULL, '2026-01-10 00:00:00', NULL),
(13, 2, 0, NULL, '2026-02-05 00:00:00', NULL),
(14, 1, 0, NULL, '2026-01-10 00:00:00', NULL),
(15, 1, 0, 15, '2026-01-10 00:00:00', NULL),
(16, 2, 0, 15, '2025-12-15 00:00:00', NULL),
(17, 1, 0, 16, '2026-01-10 00:00:00', NULL),
(18, 1, 0, 16, '2026-02-05 00:00:00', NULL),
(19, 2, 0, 16, '2026-01-10 00:00:00', NULL),
(20, 1, 0, 17, '2025-12-15 00:00:00', NULL),
(21, 1, 0, 18, '2026-01-10 00:00:00', NULL),
(22, 2, 0, 18, '2026-01-10 00:00:00', NULL),
(23, 1, 0, 18, '2025-12-15 00:00:00', NULL),
(24, 1, 0, 19, '2026-02-05 00:00:00', NULL),
(25, 1, 0, 18, '2026-02-05 00:00:00', NULL),
(26, 1, 0, 20, '2026-01-10 00:00:00', NULL),
(27, 1, 0, 20, '2026-01-10 00:00:00', NULL),
(28, 2, 0, 20, '2026-01-10 00:00:00', NULL),
(29, 1, 0, 20, '2026-01-10 00:00:00', NULL),
(30, 1, 0, 20, '2026-01-10 00:00:00', NULL),
(31, 1, 0, 22, '2026-02-05 00:00:00', NULL),
(32, 1, 0, 23, '2026-02-05 00:00:00', NULL),
(33, 1, NULL, 22, '2025-12-15 00:00:00', NULL),
(34, 2, NULL, 22, '2026-01-10 00:00:00', NULL),
(35, 8, NULL, 22, '2026-01-10 00:00:00', NULL),
(36, 2, NULL, 22, '2026-02-05 00:00:00', NULL),
(37, 9, NULL, 22, '2025-12-15 00:00:00', NULL),
(38, 3, NULL, 22, '2026-01-10 00:00:00', NULL),
(39, 2, NULL, 22, '2026-01-10 00:00:00', NULL),
(40, 1, NULL, 24, '2026-01-10 00:00:00', NULL),
(41, 1, NULL, 24, '2026-02-05 00:00:00', NULL),
(42, 3, NULL, 24, '2026-01-10 00:00:00', NULL),
(43, 2, NULL, 24, '2025-12-15 00:00:00', NULL),
(44, 1, NULL, 24, '2025-12-15 00:00:00', NULL),
(45, 9, NULL, 24, '2026-03-20 00:00:00', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`ID_администратора`);

--
-- Индексы таблицы `custom_routse`
--
ALTER TABLE `custom_routse`
  ADD PRIMARY KEY (`Route_custom_ID`);

--
-- Индексы таблицы `guides`
--
ALTER TABLE `guides`
  ADD PRIMARY KEY (`Guide_ID`);

--
-- Индексы таблицы `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`Route_ID`);

--
-- Индексы таблицы `route_point`
--
ALTER TABLE `route_point`
  ADD PRIMARY KEY (`Point_ID`),
  ADD KEY `Route_ID` (`Route_ID`);

--
-- Индексы таблицы `route_points`
--
ALTER TABLE `route_points`
  ADD PRIMARY KEY (`Point_ID`),
  ADD KEY `Route_ID` (`Route_ID`);

--
-- Индексы таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  ADD PRIMARY KEY (`Schedule_ID`),
  ADD KEY `Route_custom_ID` (`Route_custom_ID`);

--
-- Индексы таблицы `tourist`
--
ALTER TABLE `tourist`
  ADD PRIMARY KEY (`Tourist_ID`);

--
-- Индексы таблицы `trip_request`
--
ALTER TABLE `trip_request`
  ADD PRIMARY KEY (`Trip_ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `custom_routse`
--
ALTER TABLE `custom_routse`
  MODIFY `Route_custom_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `guides`
--
ALTER TABLE `guides`
  MODIFY `Guide_ID` int(64) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `routes`
--
ALTER TABLE `routes`
  MODIFY `Route_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `route_point`
--
ALTER TABLE `route_point`
  MODIFY `Point_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `route_points`
--
ALTER TABLE `route_points`
  MODIFY `Point_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  MODIFY `Schedule_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `tourist`
--
ALTER TABLE `tourist`
  MODIFY `Tourist_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `trip_request`
--
ALTER TABLE `trip_request`
  MODIFY `Trip_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `route_point`
--
ALTER TABLE `route_point`
  ADD CONSTRAINT `route_point_ibfk_1` FOREIGN KEY (`Route_ID`) REFERENCES `routes` (`Route_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `route_points`
--
ALTER TABLE `route_points`
  ADD CONSTRAINT `route_points_ibfk_1` FOREIGN KEY (`Route_ID`) REFERENCES `routes` (`Route_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  ADD CONSTRAINT `route_schedule_ibfk_1` FOREIGN KEY (`Route_custom_ID`) REFERENCES `custom_routse` (`Route_custom_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
