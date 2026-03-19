-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Фев 06 2026 г., 13:49
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
  `Route_Days` text DEFAULT NULL,
  `Guide_ID` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'private',
  `equipment` varchar(255) DEFAULT NULL,
  `Cost_organization` int(11) DEFAULT NULL,
  `Photo1` varchar(255) DEFAULT NULL,
  `Photo2` varchar(255) DEFAULT NULL,
  `Photo3` varchar(255) DEFAULT NULL,
  `Photo4` varchar(255) DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `custom_routse`
--

INSERT INTO `custom_routse` (`Route_custom_ID`, `Tourist_ID`, `Route_Name`, `Route_Description`, `Route_Length`, `Route_Type`, `Route_Duration`, `Terrain_Type`, `WaiPoint1`, `WaiPoint2`, `WaiPoint3`, `WaiPoint4`, `WaiPoint5`, `WaiPoint6`, `WaiPoint7`, `WaiPoint8`, `WaiPoint9`, `WaiPoint10`, `WaiPoint11`, `WaiPoint12`, `WaiPoint13`, `WaiPoint14`, `WaiPoint15`, `WaiPoint16`, `WaiPoint17`, `WaiPoint18`, `WaiPoint19`, `WaiPoint20`, `Map_Zoom`, `Map_Center`, `Route_Days`, `Guide_ID`, `status`, `equipment`, `Cost_organization`, `Photo1`, `Photo2`, `Photo3`, `Photo4`, `rejection_reason`) VALUES
(156, 40, 'Название маршрута', 'qeqw', 0, 'Custom', '', 'Mixed', '55.89995614406812, 37.54714965820313', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 17, '55.89995614406812,37.54714965820313', '[[{\"time\":\"12:00\",\"is_text\":true,\"point_name\":null,\"note\":\"we\",\"point_index\":0}],[{\"time\":\"12:00\",\"is_text\":false,\"point_name\":\"Точка 1\",\"note\":null,\"point_index\":1}]]', NULL, 'private', '[\"Новая вещьфывфвфывфывыфв\"]', 123, '/uploads/participant/user_40/1770381075827-route-Ð¨ÐÐÐÐ.jpg', '/uploads/participant/user_40/1770381075834-route-Ð¨ÐÐÐÐ 2.png', '/uploads/participant/user_40/1770381075837-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg', '/uploads/participant/user_40/1770381075844-route-Ð¨ÐÐÐÐ.jpg', NULL);

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
  `experience` varchar(255) DEFAULT NULL,
  `tg_link` varchar(255) DEFAULT NULL,
  `vk_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `guides`
--

INSERT INTO `guides` (`Guide_ID`, `login`, `password`, `First_Name`, `Last_Name`, `phone`, `email`, `Age`, `Guide_License`, `role`, `experience`, `tg_link`, `vk_link`) VALUES
(1, 'extreme_pavel', '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.', 'Павел', 'Морозов', '+79001112233', 'pavel@extreme.ru', 35, 'lic_001.pdf', 'organizer', 'Эксперт', 'https://t.me/pavel_extreme', 'https://vk.com/pavel_mountains'),
(2, 'forest_anna', '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.', 'Анна', 'Лесная', '+79112223344', 'anna@ecotour.ru', 27, 'lic_002.jpg', 'organizer', 'Профессионал', 'https://t.me/anna_forest', 'https://vk.com/anna_hiking'),
(3, 'city_guide_dm', '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.', 'Дмитрий', 'Соколов', '+79223334455', 'dmitry@citytours.ru', 40, NULL, 'organizer', 'Любитель', 'https://t.me/dima_urbantour', 'https://vk.com/dmitry_history'),
(9, NULL, '$2b$10$KtyFUHtMkmYsxaGThR2b1uCEfdIRGwwubbRspsnePpaATAT7qOJhC', 'выффывфыв', 'авыаываыа', '+79999999999', 'qwersty58fdawsassdqwerwed3as4dsassa3sxfdssgf2x3es721654a27324@gmail.com', 80, '/licenses_guide/1769052732390-ÑÐ°Ð±ÐµÐ»Ñ ÑÐ±Ð¾ÑÐºÐ¸ Ð´ÐµÐºÐ°Ð±ÑÑ 2025  2.2.jpg', 'organizer', 'Начинающий', NULL, NULL),
(10, NULL, '$2b$10$xrLhZTXaPJm0GQ40SvKK1e64JLIHvTIhbYkgeFEZESzB/SgaNKPNK', 'er', 'erre', '+71231231231', 'qwerty583274@gmail.com', 80, '/uploads/licenses/1769071366334-ÑÐ°Ð±ÐµÐ»Ñ ÑÐ±Ð¾ÑÐºÐ¸ Ð´ÐµÐºÐ°Ð±ÑÑ 2025  2.2 (1).jpg', 'organizer', 'Любитель', NULL, NULL),
(11, NULL, '$2b$10$kr/E/VYdTd8PEnamsOfA5u.ansxdXqIoOY/fZyOeRAEd8f988bFQi', 'gdf', 'fds', NULL, 'qwed@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(12, NULL, '$2b$10$XELySwvvfGk4MbUEppdmoOiTAn5K06xBi6IH6Hl0MuxSAWCEG5q6W', 'аыв', 'ваы', '+7213213213', 'qwwed@gmail.com', 80, '/uploads/guide/guide_12/1769503422834-lic-meerkat-10071273_1280.png', 'organizer', 'Любитель', NULL, NULL),
(13, NULL, '$2b$10$YEvp20vlR6eSsz29TScgV.3H6dfWxgcQc.KfrjWi0fbO/nqDLH9ja', 'gdf', 'fds', NULL, 'adsadas274@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(14, NULL, '$2b$10$ssdlC/f97JYxZFv9tG3LKekGuW1TeI/QllXoO2HPWZmPhFHZhq/T2', 'пвыавукуепав', 'fds', '+75691203905', 'qwzcrty583274@gmail.com', 80, '/uploads/guide/guide_14/1769554400225-lic-3.jpeg', 'organizer', 'Начинающий', NULL, NULL),
(15, NULL, '$2b$10$4ep0etvIDBB9m/3mBtL.wOXTDTykx8Qike4SWe2Itv6nHSACXuCmS', 'gdf', 'fds', NULL, 'qwertdasdsasy583274@gmail.com', NULL, NULL, 'organizer', 'amateur', NULL, NULL),
(16, NULL, '$2b$10$bYHpJZ3EOTmHEPU0JlrRn.uhdFRt28kzL7PSSIt446.hDmtEQLvZ6', 'gdf', 'fds', NULL, 'qwerty5832742@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(17, NULL, '$2b$10$p3CZOSXSemc1pnEdk.cpFu9VEfneaIsWNt.DX7vQTfB0zsBejcIbe', 'ыфв', 'fds', NULL, 'qwerty58327423@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(18, NULL, '$2b$10$T.ddEV8fQlsebJDe7rvTBOJGUedLw8zgjDCUEyjcC3bm7HqktRkgW', 'gdf', 'fds', NULL, 'qwerty5832sdad74@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(19, NULL, '$2b$10$.3NubnhPNvQLgWkrccerYOUbMtsbQ2F/tO7r92Iftuk8oXWJ93j8G', 'gdf', 'fds', NULL, 'xqwerty5832742@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(20, NULL, '$2b$10$PGyOdioLReNWuVrLVm7f9OPeGR.9IfOM4Fp1K3PCt9R47SYlyVfdy', 'https://vk.com/wall-73662138_886788', 't.me/Sopen87', '+71231231231', 'qwerty5asdsad83274@gmail.com', 80, '/uploads/guide/guide_20/1769566920169-lic-4.jpeg', 'organizer', 'Начинающий', 't.me/Sopen87', 'https://vk.com/wall-73662138_886788'),
(21, 'extreme_pavel', '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.', 'Павел', 'Морозов', '+79001112233', 'pavel@extreme.ru', 35, 'lic_001.pdf', 'organizer', 'Эксперт', 'https://t.me/pavel_extreme', 'https://vk.com/pavel_mountains'),
(22, 'forest_anna', '$2b$10$VocEgbhC55twzmUqqhJTKOlANfSlmokK3X7yydwjvwe2kaRedohw.', 'Анна', 'Лесная', '+79112223344', 'anna@ecotour.ru', 27, 'lic_002.jpg', 'organizer', 'Профессионал', 'https://t.me/anna_forest', 'https://vk.com/anna_hiking'),
(23, NULL, '$2b$10$C1An5kP1d5sc6ITQaZGim./DR5osH.2q/XEKImiqxBfIIJQqByRZm', 'dsfsf', 'sdf', '+78765435678', 'asdsafsdf@gmail.com', 80, '/uploads/guide/guide_23/1769570781745-lic-meerkat-10071273_1280.png', 'organizer', 'Любитель', 'https://t.me/dasdas', 'https://vk.com/eqwe'),
(24, NULL, '$2b$10$MY1fc5XjfhFMPSCdy9sQJ.ZBYkIYTWirSy9KqRKpuj8w9um3iQBhu', 'йцу', 'йцу', '+75467543576', 'qweeldssarsibrimov18@gmail.com', 80, '/uploads/guide/guide_24/1769971647701-lic-ÐÐµÐ· Ð¸Ð¼ÐµÐ½Ð¸.png', 'organizer', 'Любитель', 't.me/dasdas', 'https://vk.com/dasdas'),
(25, NULL, '$2b$10$FSnXB8pdicxZNvSX7niiKe5z7IXjf5KkRKlrCgFrJYsssCDSJJ/Cy', 'wqe', 'qe', '+72345677865', 'qwqeqweerty583274@gmail.com', 80, '/uploads/guide/guide_25/1770076606218-lic-Ð¨ÐÐÐÐ 2.png', 'organizer', 'Любитель', 'https://t.me/adas', 'https://vk.com/qqweqweqwe'),
(26, NULL, '$2b$10$PXsNdIbP5R.Me1fDv46Ooe5PZYpCpyOoa1lYnVIwDgOgcHgjFQ24.', 'ewe', 'qwewe', NULL, 'eld23rsibrimov18@gmail.com', NULL, NULL, 'organizer', 'beginner', NULL, NULL),
(27, NULL, '$2b$10$4gwryScVHFHyK2.s6MfjMOx0uIuAcBZXip5p3y6mDvloshzieVy2S', '21', '12312', '+75654786907', '12qwe3eldarsibrimov18@gmail.com', 80, '/uploads/guide/guide_27/1770160100970-lic-Ð¨ÐÐÐÐ.jpg', 'organizer', 'Любитель', 'https://t.me/dass', 'https://vk.com/qwe'),
(28, NULL, '$2b$10$9OforA1drKlxd75qvagkje..U25L14Ouo2PHU09Uv5H4E5NNvr6dO', 'йцу', 'йцу', '+72435364786', '1w2qwe3eldarsibrimov18@gmail.com', 80, '/uploads/guide/guide_28/1770161560066-lic-Ð¨ÐÐÐÐ 2.png', 'organizer', 'Начинающий', 'https://t.me/adas', 'https://vk.com/wqds'),
(29, NULL, '$2b$10$9nxb3NIEbREoNPq4d/gyD.ksvqV4X7zwofkPuFFRDpd/EztZ15Gtm', 'qwe', 'qwe', '+79878543231', '12123213232133eldarsibrimov18@gmail.com', 80, '/uploads/guide/guide_29/1770165257958-lic-Ð¨ÐÐÐÐ.jpg', 'organizer', 'Начинающий', 'https://t.me/qweqwewqe', 'https://vk.com/qweqwewqe'),
(30, NULL, '$2b$10$Yft1hmIlYyVQ1IZBM40wL.tAcMevensVfCXQzjvumeFnzdEmizNKK', '2e3qw', 'qweqwe', '+76654324576', 'qweqweq@gmail.com', 80, '/uploads/guide/guide_30/1770198895175-lic-Ð¨ÐÐÐÐ 2.png', 'organizer', 'Опытный', 'https://t.me/asdsad', 'https://vk.com/asdsad');

-- --------------------------------------------------------

--
-- Структура таблицы `routes`
--

CREATE TABLE `routes` (
  `Route_ID` int(255) NOT NULL,
  `Route_Name` varchar(255) DEFAULT NULL,
  `Route_Description` varchar(255) DEFAULT NULL,
  `Route_Length` int(11) DEFAULT NULL,
  `Route_Duration` varchar(255) DEFAULT NULL,
  `Route_Type` varchar(255) DEFAULT NULL,
  `Terrain_Type` varchar(255) DEFAULT NULL,
  `Required_Equipment` varchar(255) DEFAULT NULL,
  `Equipment_Cost` int(11) DEFAULT NULL,
  `Cost_organization` int(11) DEFAULT NULL,
  `Guide_ID` int(11) DEFAULT NULL,
  `Map_Center` varchar(255) DEFAULT NULL,
  `Map_Zoom` int(11) DEFAULT NULL,
  `Route_Days` int(11) DEFAULT 1,
  `Photo1` varchar(255) DEFAULT NULL,
  `Photo2` varchar(255) DEFAULT NULL,
  `Photo3` varchar(255) DEFAULT NULL,
  `Photo4` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `routes`
--

INSERT INTO `routes` (`Route_ID`, `Route_Name`, `Route_Description`, `Route_Length`, `Route_Duration`, `Route_Type`, `Terrain_Type`, `Required_Equipment`, `Equipment_Cost`, `Cost_organization`, `Guide_ID`, `Map_Center`, `Map_Zoom`, `Route_Days`, `Photo1`, `Photo2`, `Photo3`, `Photo4`) VALUES
(2, 'Ледяной Байкал', 'Прогулка по прозрачному льду озера Байкал с посещением ледяных гротов. В зимний период лед достигает максимальной прочности и красоты.', 20, '', 'Коньковый', 'Лед', 'Коньки, ледоступы', 5000, 3500, 1, '', 0, 0, '', '', '', ''),
(3, 'Альпийский спуск', 'Горнолыжный спуск средней сложности с подготовленными трассами. Работает исключительно в зимние месяцы при наличии снежного покрова.', 5, '', 'Лыжный', 'Горы', 'Лыжи, шлем', 15000, 4000, 1, '', 0, 0, '', '', '', ''),
(4, 'Огни ночного города', 'Городской маршрут по празднично украшенным центральным улицам и площадям. Лучшее время для прогулки — вечер декабря или января.', 8, '', 'Пеший', 'Асфальт', 'Удобная обувь', 0, 500, 3, '', 0, 0, '', '', '', ''),
(5, 'Тропа хаски', 'Маршрут для катания на собачьих упряжках по подготовленной снежной трассе. Отличное зимнее приключение для всей семьи.', 10, '', 'Упряжки', 'Снежная трасса', 'Зимний комбинезон', 8000, 12000, 2, '', 0, 0, '', '', '', ''),
(6, 'Горячие источники', 'Путь к открытым термальным бассейнам через заснеженное предгорье. Контраст ледяного воздуха и горячей воды бодрит и оздоравливает.', 12, '', 'Авто-пеший', 'Предгорье', 'Купальные принадлежности', 3000, 2500, 10, '', 0, 0, '', '', '', ''),
(7, 'Заповедный лес', 'Экологическая тропа в национальном парке, где можно встретить диких животных в их зимнем обитании. Требует соблюдения тишины.', 7, '', 'Пеший/Лыжный', 'Смешанный лес', 'Снегоступы', 1500, 800, 9, '', 0, 0, '', '', '', ''),
(8, 'Ледяная пещера', 'Спуск в пещеру, где зимой образуются уникальные ледяные сталактиты и сталагмиты. Температура внутри стабильно низкая.', 3, '', 'Спелео', 'Пещера', 'Фонарь, каска', 2500, 1200, 12, '', 0, 0, '', '', '', ''),
(9, 'Вершины Хибин', 'Восхождение на небольшую вершину с панорамным видом на северное сияние. Маршрут доступен только при благоприятном прогнозе погоды.', 6, '', 'Альпинизм', 'Скалы, снег', 'Кошки, ледоруб', 10000, 5000, 1, '', 0, 0, '', '', '', ''),
(20, 'ewruil;kytrew', 'qwewqeqe', 38610, '7.72 ч', 'Custom', 'Mixed', '[]', 0, 1231, 24, '', 0, 0, '', '', '', ''),
(21, 'Название маршрута', 'qweqweq', 24650, '4.93 ч', 'Custom', 'Mixed', '[\"Новая вещьqwewqeqwe\"]', 0, 123, 29, '', 0, 0, '', '', '', ''),
(22, 'вфывфывыфвыф', 'п', 20260, '4.05 ч', 'Custom', 'Mixed', '[]', 0, 123, 24, '', 0, 0, '', '', '', ''),
(23, 'Название маршрута', 'jyhtgfrsd', 10620, '2.12 ч', 'Custom', 'Mixed', '[\"Новая yjhtgrefwdsq\"]', 0, 86453, 30, '', 0, 0, '', '', '', ''),
(24, 'gdfgf', 'sad', 13260, '2.65 ч', 'Custom', 'Mixed', '[]', 0, 13, 30, '', 0, 0, '', '', '', ''),
(25, 'Название маршрута', 'asdsadsad', 17360, '3.47 ч', 'Standard', 'Mixed', '[\"Новая вещьasdasd\"]', NULL, 23, 30, '', 0, 0, '', '', '', ''),
(26, 'фывыфвывы', 'выфвфывыфвфв', 14410, '2.88 ч', 'Standard', 'Mixed', '[\"фывфывфывфывфывНовая вещь\"]', NULL, 123, 30, '55.75671900108533,37.17949100000003', 12, 2, '/uploads/guide/guide_30/1770199808658-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg', '/uploads/guide/guide_30/1770199808670-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_30/1770199808673-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_30/1770199808676-route-Ð¨ÐÐÐÐ.jpg'),
(27, 'Название aasdasdмasdаршрута', 'das', 310, '0.06 ч', 'Standard', 'Mixed', '[\"wdsНовая вещь\"]', NULL, NULL, 12, '55.86371081498347,37.41654217243195', 17, 1, NULL, NULL, NULL, NULL),
(28, 'qweqwe', 'qwe', 21580, '4.32 ч', 'Standard', 'Mixed', '[\"qeНовая вещь\"]', NULL, 213, 24, '55.768502029326314,37.462562', 12, 2, '/uploads/guide/guide_24/1769975160812-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975160817-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975160821-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975160824-route-478950e8733160ad22de5e7d50d648cb.jpg'),
(29, 'Название маршрута', 'фвфыфыв', 0, '', 'Standard', 'Mixed', '[\"Новая ввфвфывыещь\"]', NULL, NULL, 12, '51.998410382390325,-12.458496093750002', 5, 1, NULL, NULL, NULL, NULL),
(30, 'Название маршрута', 'sad', 36290, '7.26 ч', 'Standard', 'Mixed', '[]', NULL, 12, 24, '55.73400449275776,37.54836600000001', 11, 1, '/uploads/guide/guide_24/1769976411447-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976411453-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976411457-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976411460-route-Ð¨ÐÐÐÐ.jpg'),
(31, 'rtyuilj,hgfrrtyyu', 'das', 17210, '3.44 ч', 'Standard', 'Mixed', '[]', NULL, 213, 30, '55.936702471544095,37.385787963867195', 12, 2, '/uploads/guide/guide_30/1770316155372-route-22ea6c80800709ebd03e3ba2c0c12499.jpg', '/uploads/guide/guide_30/1770316155380-route-22ea6c80800709ebd03e3ba2c0c12499.jpg', '/uploads/guide/guide_30/1770316155385-route-22ea6c80800709ebd03e3ba2c0c12499.jpg', '/uploads/guide/guide_30/1770316155389-route-22ea6c80800709ebd03e3ba2c0c12499.jpg');

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
(23, 'Вершина со смотровой', 'Лучшая точка для наблюдения полярного сияния.', 2, '67.5922, 33.6811', 9),
(35, 'Точка 1', NULL, 1, '55.85912884568613, 37.52243041992188', 20),
(36, 'Точка 2', NULL, 2, '55.74180093975863, 37.44415283203126', 20),
(37, 'Точка 3', NULL, 3, '55.87145859243408, 37.35797882080079', 20),
(38, 'Точка 1', NULL, 1, '55.87454041761713, 37.63366699218751', 21),
(39, 'Точка 2', NULL, 2, '55.71550813595296, 37.50320434570313', 21),
(40, 'Точка 1', NULL, 1, '55.88378442572491, 37.81631469726563', 22),
(41, 'Точка 2', NULL, 2, '55.80822725940602, 37.61032104492188', 22),
(42, 'Точка 1', NULL, 1, '55.849878967015044, 37.49359130859376', 23),
(43, 'Точка 2', NULL, 2, '55.79201732549512, 37.42492675781251', 23),
(44, 'Точка 1', NULL, 1, '55.767303495700936, 37.69683837890626', 24),
(45, 'Точка 2', NULL, 2, '55.70080738536962, 37.55950927734376', 24),
(46, 'Точка 1', '', 1, '55.77811772485584, 37.32742309570313', 25),
(47, 'Точка 2', '', 2, '55.71937583528782, 37.24227905273438', 25),
(48, 'Точка 1', '', 1, '55.80359653829958, 37.20794677734376', 26),
(49, 'Точка 2', '', 2, '55.70931902037372, 37.15026855468751', 26),
(50, 'Точка 1', '', 1, '55.86307739747528, 37.41780035169513', 27),
(51, 'Точка 2', '', 2, '55.864493989212036, 37.41529047799065', 27),
(52, 'Точка 1', '', 1, '55.832915136881745, 37.54440307617188', 28),
(53, 'Точка 2', '', 2, '55.70390273988158, 37.38098144531251', 28),
(54, 'Точка 1', '', 1, '55.93772754071002, 37.708862242853115', 29),
(55, 'Точка 2', '', 2, '55.824541812725236, 37.70337050905767', 29),
(56, 'Точка 3', '', 3, '55.65995187472916, 37.625113302472734', 29),
(57, 'Точка 4', '', 4, '54.5985978163725, 19.87530554518982', 29),
(58, 'Точка 5', '', 5, '59.69104310814828, -9.942281811971686', 29),
(59, 'Точка 1', '', 1, '55.8467951848097, 37.65563964843751', 30),
(60, 'Точка 2', '', 2, '55.68610110318785, 37.53479003906251', 30),
(61, 'Точка 3', '', 3, '55.62256840602218, 37.43316650390626', 30),
(62, 'Точка 1', '', 1, '55.98993239772802, 37.39059448242188', 31),
(63, 'Точка 2', '', 2, '55.88224391055777, 37.41531372070313', 31);

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
(30, '$2b$10$2ebcygDqXGJ6LW0YSwwgc.zFwWBDEXTpHMI4omUUnay6s6SYbbbgC', 'dsa', 'sad', '+75432134546', 'asdsa@gmail.com', 'Мужской', 80, 'participant', 'Начинающий'),
(31, '$2b$10$0Svo7pEgrjgdVkeWMGxxM.cOCVlwe5z94/Bx5mRuL9OO8VcaLLWmq', 'dsa', 'фыв', NULL, 'asdasd@gmail.com', NULL, NULL, 'participant', 'beginner'),
(32, '$2b$10$SzhQAldORxp8RGxWlgILNueBmrhoyyYUXHvUJtoYhk40eYhSpaWhW', 'sdsad', 'asdasd', NULL, 'asdasdsa@gmail.com', NULL, NULL, 'participant', 'beginner'),
(33, '$2b$10$1qGXggOrTqOckjwz2bP42eQ4.jZ5HaeC2AM7qxMd0T/5RSATr5FDW', 'HJVJHBJ ', 'zxczx', '+7123123123', 'asdsaadasd@gmail.com', 'Мужской', 80, 'participant', 'Начинающий'),
(34, '$2b$10$M3MUpbh63ccDkr7wtlEIcecCa9vmkhOx9t707U7ixEyItaLCpIBjy', 'йцу', 'йцу', NULL, 'qwqwerty583274@gmail.com', NULL, NULL, 'participant', 'amateur'),
(35, '$2b$10$3TLsdCZ6ZmK9EGz6B7sWkOKdodcaEV5YoG1eenkbdVGsffCaaynqW', 'йцу', 'йцу', NULL, 'qweeldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner'),
(36, '$2b$10$PxmrLtU/dv16p6dfZ53RjeJrjYHGaopyCDdpnHACE6SzZ.bcUCFrO', 'ewe', '23', NULL, '123eldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'amateur'),
(37, '$2b$10$z38zKpNKGApUWP7XRZ0Jb.Du6cp5nBwabpvLDQsQYWbLsH6CFHJ3q', 'ewe', 'qwewe', NULL, '123123eldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner'),
(38, '$2b$10$O5AKHoJkJa3FUBXXlKgKGuPWA54uQMth/yAGAecx/LoT1CPDfB5wC', 'adas', 'dasasd', NULL, '112323123eldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner'),
(39, '$2b$10$.FD4N4UoNZuifpv6hSCluOxiGlqJ5w/dQTIK/dn9h0Fwa4M1.aBC6', 'йцуйцу', 'qwewe', NULL, '121321312323eldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner'),
(40, '$2b$10$krj.1GeRcR.KT.W/RGPMCuUDPz5H.8ZFUb0OG3Kxhmaz3aOkSFuD2', 'ewe', '23', '+74567345678', '1232112312123eldarsibrimov18@gmail.com', 'Мужской', 80, 'participant', 'Начинающий'),
(41, '$2b$10$7HiFyfjWWEdMChtEbDzQmuVw5D9sn0LXQUJ6EU.vDMOZQToS0Mjdq', 'Эдуард', 'Эдуард', NULL, '12313123eldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner');

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
(11, 2, NULL, NULL, '2026-01-10 00:00:00', '0000-00-00 00:00:00'),
(13, 2, NULL, NULL, '2026-02-05 00:00:00', NULL),
(54, 3, NULL, 30, '2026-01-10 00:00:00', NULL),
(58, 3, NULL, 32, '2025-12-15 00:00:00', NULL),
(61, 3, NULL, 34, '2026-01-10 00:00:00', NULL),
(74, 31, NULL, 41, '2025-12-15 00:00:00', NULL);

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
  MODIFY `Route_custom_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT для таблицы `guides`
--
ALTER TABLE `guides`
  MODIFY `Guide_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `routes`
--
ALTER TABLE `routes`
  MODIFY `Route_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `route_point`
--
ALTER TABLE `route_point`
  MODIFY `Point_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT для таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  MODIFY `Schedule_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=703;

--
-- AUTO_INCREMENT для таблицы `tourist`
--
ALTER TABLE `tourist`
  MODIFY `Tourist_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT для таблицы `trip_request`
--
ALTER TABLE `trip_request`
  MODIFY `Trip_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

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
