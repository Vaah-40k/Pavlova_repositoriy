-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Янв 26 2026 г., 17:54
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
  `ID_administrator` int(32) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `administrator`
--

INSERT INTO `administrator` (`ID_administrator`, `email`, `password`) VALUES
(1, 'eldarsibrimov18@gmail.com', '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.');

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
  `Map_Center` varchar(255) DEFAULT NULL,
  `Route_Days` int(11) DEFAULT 1,
  `Guide_ID` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'private',
  `equipment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `custom_routse`
--

INSERT INTO `custom_routse` (`Route_custom_ID`, `Tourist_ID`, `Route_Name`, `Route_Description`, `Route_Length`, `Route_Type`, `Route_Duration`, `Terrain_Type`, `WaiPoint1`, `WaiPoint2`, `WaiPoint3`, `WaiPoint4`, `WaiPoint5`, `WaiPoint6`, `WaiPoint7`, `WaiPoint8`, `WaiPoint9`, `WaiPoint10`, `WaiPoint11`, `WaiPoint12`, `WaiPoint13`, `WaiPoint14`, `WaiPoint15`, `WaiPoint16`, `WaiPoint17`, `WaiPoint18`, `WaiPoint19`, `WaiPoint20`, `Map_Zoom`, `Map_Center`, `Route_Days`, `Guide_ID`, `status`, `equipment`) VALUES
(1, NULL, 'Название', 'Пользовательский маршрут', 13900, 'Custom', '2.78 ч', 'Mixed', '56.015272531542344, 37.38372802734376', '55.966881490388445, 37.40158081054688', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', ''),
(2, NULL, 'Название', 'Пользовательский маршрут', 2719390, 'Custom', '543.88 ч', 'Mixed', '56.015272531542344, 37.38372802734376', '55.966881490388445, 37.40158081054688', '56.0965557505683, 35.73852539062501', '56.674338416158825, 38.70483398437501', '53.75520681580148, 35.60668945312501', '55.57213384241379, 39.72656250000001', '56.35916436114858, 39.52880859375', '55.57213384241379, 40.50659179687501', '54.95869417101664, 38.12255859375001', '55.30413773740139, 35.69458007812501', '55.893796284148955, 34.20043945312501', '57.231502991478926, 37.36450195312501', '56.96893619436121, 34.61791992187501', '56.1210604250441, 35.98022460937501', '54.65476860921582, 36.35375976562501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', ''),
(3, NULL, 'ждлнпавывуаперолдж.э', 'Пользовательский маршрут', 43780, 'Custom', '8.76 ч', 'Mixed', '55.775800642613135, 37.37686157226563', '55.868376522659915, 37.49084472656251', '55.78197922246136, 37.81356811523438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', ''),
(4, NULL, 'Название', 'Пользовательский маршрут', 5140, 'Custom', '1.03 ч', 'Mixed', '55.83831352210821, 37.51281738281251', '55.80977071070357, 37.53479003906251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', ''),
(37, NULL, 'Название', 'Пользовательский маршрут', 19430, 'Custom', '3.89 ч', 'Mixed', '55.85517527443665, 37.48535156250001', '55.811962250018276, 37.46337890625001', '55.76483626248958, 37.43728637695313', '55.73467664877739, 37.38098144531251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.7558,37.6173', 1, NULL, 'private', ''),
(38, NULL, 'Название', 'Пользовательский маршрут', 19430, 'Custom', '3.89 ч', 'Mixed', '55.85517527443665, 37.48535156250001', '55.811962250018276, 37.46337890625001', '55.76483626248958, 37.43728637695313', '55.73467664877739, 37.38098144531251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.7558,37.6173', 1, NULL, 'private', ''),
(39, 29, 'Название', 'Пользовательский маршрут', 6830, 'Custom', '1.37 ч', 'Mixed', '55.84062688636364, 37.50320434570313', '55.795877445664125, 37.54302978515626', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.75803176823725,37.62542724609376', 1, NULL, 'private', ''),
(48, 30, 'Название маршрута', 'Пользовательский маршрут', 22470, 'Custom', '4.49 ч', 'Mixed', '55.79742138660978, 37.43453979492188', '55.676810074389465, 37.32467651367188', '55.61481346181522, 37.19421386718751', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.74087693614372,37.38366600000001', 1, NULL, 'private', ''),
(59, NULL, 'Название маршрута', 'Пользовательский маршрут', 38470, 'Custom', '7.69 ч', 'Mixed', '55.56614298260134, 37.10065272500881', '55.812973687245695, 37.27226940611611', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.689971551383536,37.186322628565755', 1, 11, 'private', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `guides`
--

CREATE TABLE `guides` (
  `Guide_ID` int(11) NOT NULL,
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
(9, NULL, '$2b$10$KtyFUHtMkmYsxaGThR2b1uCEfdIRGwwubbRspsnePpaATAT7qOJhC', 'выффывфыв', 'авыаываыа', '+79999999999', 'qwersty58fdawsassdqwerwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', 80, '/licenses_guide/1769052732390-ÑÐ°Ð±ÐµÐ»Ñ ÑÐ±Ð¾ÑÐºÐ¸ Ð´ÐµÐºÐ°Ð±ÑÑ 2025  2.2.jpg', 'organizer', 'Начинающий'),
(10, NULL, '$2b$10$xrLhZTXaPJm0GQ40SvKK1e64JLIHvTIhbYkgeFEZESzB/SgaNKPNK', 'er', 'erre', '+71231231231', 'qwerty583274@gmail.com', 80, '/uploads/licenses/1769071366334-ÑÐ°Ð±ÐµÐ»Ñ ÑÐ±Ð¾ÑÐºÐ¸ Ð´ÐµÐºÐ°Ð±ÑÑ 2025  2.2 (1).jpg', 'organizer', 'Любитель'),
(11, NULL, '$2b$10$kr/E/VYdTd8PEnamsOfA5u.ansxdXqIoOY/fZyOeRAEd8f988bFQi', 'gdf', 'fds', NULL, 'qwed@gmail.com', NULL, NULL, 'organizer', 'beginner');

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
(1, 'Зимняя сказка Карелии', 'Маршрут проходит через заснеженные карельские леса к незамерзающим водопадам. Идеально подходит для любителей зимней фотографии и тишины.', 15, 'Пеший', '05:00:00', 'Лес, снег', 'Теплая обувь, термос', 5000, 1500, NULL),
(2, 'Ледяной Байкал', 'Прогулка по прозрачному льду озера Байкал с посещением ледяных гротов. В зимний период лед достигает максимальной прочности и красоты.', 20, 'Коньковый', '06:30:00', 'Лед', 'Коньки, ледоступы', 5000, 3500, NULL),
(3, 'Альпийский спуск', 'Горнолыжный спуск средней сложности с подготовленными трассами. Работает исключительно в зимние месяцы при наличии снежного покрова.', 5, 'Лыжный', '02:00:00', 'Горы', 'Лыжи, шлем', 15000, 4000, NULL),
(4, 'Огни ночного города', 'Городской маршрут по празднично украшенным центральным улицам и площадям. Лучшее время для прогулки — вечер декабря или января.', 8, 'Пеший', '03:00:00', 'Асфальт', 'Удобная обувь', 0, 500, NULL),
(5, 'Тропа хаски', 'Маршрут для катания на собачьих упряжках по подготовленной снежной трассе. Отличное зимнее приключение для всей семьи.', 10, 'Упряжки', '01:30:00', 'Снежная трасса', 'Зимний комбинезон', 8000, 12000, NULL),
(6, 'Горячие источники', 'Путь к открытым термальным бассейнам через заснеженное предгорье. Контраст ледяного воздуха и горячей воды бодрит и оздоравливает.', 12, 'Авто-пеший', '04:00:00', 'Предгорье', 'Купальные принадлежности', 3000, 2500, NULL),
(7, 'Заповедный лес', 'Экологическая тропа в национальном парке, где можно встретить диких животных в их зимнем обитании. Требует соблюдения тишины.', 7, 'Пеший/Лыжный', '04:30:00', 'Смешанный лес', 'Снегоступы', 1500, 800, NULL),
(8, 'Ледяная пещера', 'Спуск в пещеру, где зимой образуются уникальные ледяные сталактиты и сталагмиты. Температура внутри стабильно низкая.', 3, 'Спелео', '02:00:00', 'Пещера', 'Фонарь, каска', 2500, 1200, NULL),
(9, 'Вершины Хибин', 'Восхождение на небольшую вершину с панорамным видом на северное сияние. Маршрут доступен только при благоприятном прогнозе погоды.', 6, 'Альпинизм', '08:00:00', 'Скалы, снег', 'Кошки, ледоруб', 10000, 5000, NULL);

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
(28, '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.', 'выффывфыв', 'авыаываыа', NULL, 'qwersty58fdawsasdqwerwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', NULL, NULL, 'participant', 'beginner'),
(29, '$2b$10$tQJSOwFq8mfVcOmuFg/8L.kJSQ/fZ3AMo9WxevNOxQa78M0lSwNw.', 'asdsa', 'авыаываыа', '+7999999999', 'qwersty58fdawsasddqwerwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', 'Мужской', 80, 'participant', 'Начинающий'),
(30, '$2b$10$2ebcygDqXGJ6LW0YSwwgc.zFwWBDEXTpHMI4omUUnay6s6SYbbbgC', 'dsa', 'sad', NULL, 'asdsa@gmail.com', NULL, NULL, 'participant', 'beginner');

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
(10, 1, NULL, NULL, '2025-12-15 00:00:00', '0000-00-00 00:00:00'),
(11, 2, NULL, NULL, '2026-01-10 00:00:00', '0000-00-00 00:00:00'),
(12, 1, NULL, NULL, '2026-01-10 00:00:00', NULL),
(13, 2, NULL, NULL, '2026-02-05 00:00:00', NULL),
(14, 1, NULL, NULL, '2026-01-10 00:00:00', NULL),
(50, 1, NULL, 29, '2025-12-15 00:00:00', NULL),
(51, 1, NULL, 29, '2025-12-15 00:00:00', NULL),
(52, 1, NULL, 30, '2025-12-15 00:00:00', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`ID_administrator`);

--
-- Индексы таблицы `custom_routse`
--
ALTER TABLE `custom_routse`
  ADD PRIMARY KEY (`Route_custom_ID`),
  ADD KEY `fk_custom_routes_tourist` (`Tourist_ID`),
  ADD KEY `fk_custom_routes_guide` (`Guide_ID`);

--
-- Индексы таблицы `guides`
--
ALTER TABLE `guides`
  ADD PRIMARY KEY (`Guide_ID`);

--
-- Индексы таблицы `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`Route_ID`),
  ADD KEY `fk_routes_guide` (`Guide_ID`);

--
-- Индексы таблицы `route_point`
--
ALTER TABLE `route_point`
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
  ADD PRIMARY KEY (`Trip_ID`),
  ADD KEY `fk_trip_request_route` (`Route_ID`),
  ADD KEY `fk_trip_request_tourist` (`Tourist_ID`),
  ADD KEY `fk_trip_request_guide` (`Guide_ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `custom_routse`
--
ALTER TABLE `custom_routse`
  MODIFY `Route_custom_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT для таблицы `guides`
--
ALTER TABLE `guides`
  MODIFY `Guide_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
-- AUTO_INCREMENT для таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  MODIFY `Schedule_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `tourist`
--
ALTER TABLE `tourist`
  MODIFY `Tourist_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `trip_request`
--
ALTER TABLE `trip_request`
  MODIFY `Trip_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `custom_routse`
--
ALTER TABLE `custom_routse`
  ADD CONSTRAINT `custom_routse_ibfk_9` FOREIGN KEY (`Tourist_ID`) REFERENCES `tourist` (`Tourist_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_custom_routes_guide` FOREIGN KEY (`Guide_ID`) REFERENCES `guides` (`Guide_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `routes`
--
ALTER TABLE `routes`
  ADD CONSTRAINT `fk_routes_guide` FOREIGN KEY (`Guide_ID`) REFERENCES `guides` (`Guide_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `route_point`
--
ALTER TABLE `route_point`
  ADD CONSTRAINT `route_point_ibfk_1` FOREIGN KEY (`Route_ID`) REFERENCES `routes` (`Route_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  ADD CONSTRAINT `route_schedule_ibfk_1` FOREIGN KEY (`Route_custom_ID`) REFERENCES `custom_routse` (`Route_custom_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `trip_request`
--
ALTER TABLE `trip_request`
  ADD CONSTRAINT `fk_trip_request_guide` FOREIGN KEY (`Guide_ID`) REFERENCES `guides` (`Guide_ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trip_request_route` FOREIGN KEY (`Route_ID`) REFERENCES `routes` (`Route_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trip_request_tourist` FOREIGN KEY (`Tourist_ID`) REFERENCES `tourist` (`Tourist_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
