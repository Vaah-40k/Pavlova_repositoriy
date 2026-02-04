-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Фев 03 2026 г., 10:48
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
  `equipment` varchar(255) DEFAULT NULL,
  `Cost_organization` int(11) DEFAULT NULL,
  `Photo1` varchar(255) DEFAULT NULL,
  `Photo2` varchar(255) DEFAULT NULL,
  `Photo3` varchar(255) DEFAULT NULL,
  `Photo4` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `custom_routse`
--

INSERT INTO `custom_routse` (`Route_custom_ID`, `Tourist_ID`, `Route_Name`, `Route_Description`, `Route_Length`, `Route_Type`, `Route_Duration`, `Terrain_Type`, `WaiPoint1`, `WaiPoint2`, `WaiPoint3`, `WaiPoint4`, `WaiPoint5`, `WaiPoint6`, `WaiPoint7`, `WaiPoint8`, `WaiPoint9`, `WaiPoint10`, `WaiPoint11`, `WaiPoint12`, `WaiPoint13`, `WaiPoint14`, `WaiPoint15`, `WaiPoint16`, `WaiPoint17`, `WaiPoint18`, `WaiPoint19`, `WaiPoint20`, `Map_Zoom`, `Map_Center`, `Route_Days`, `Guide_ID`, `status`, `equipment`, `Cost_organization`, `Photo1`, `Photo2`, `Photo3`, `Photo4`) VALUES
(1, NULL, 'Название', 'Пользовательский маршрут', 13900, 'Custom', '2.78 ч', 'Mixed', '56.015272531542344, 37.38372802734376', '55.966881490388445, 37.40158081054688', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(2, NULL, 'Название', 'Пользовательский маршрут', 2719390, 'Custom', '543.88 ч', 'Mixed', '56.015272531542344, 37.38372802734376', '55.966881490388445, 37.40158081054688', '56.0965557505683, 35.73852539062501', '56.674338416158825, 38.70483398437501', '53.75520681580148, 35.60668945312501', '55.57213384241379, 39.72656250000001', '56.35916436114858, 39.52880859375', '55.57213384241379, 40.50659179687501', '54.95869417101664, 38.12255859375001', '55.30413773740139, 35.69458007812501', '55.893796284148955, 34.20043945312501', '57.231502991478926, 37.36450195312501', '56.96893619436121, 34.61791992187501', '56.1210604250441, 35.98022460937501', '54.65476860921582, 36.35375976562501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(3, NULL, 'ждлнпавывуаперолдж.э', 'Пользовательский маршрут', 43780, 'Custom', '8.76 ч', 'Mixed', '55.775800642613135, 37.37686157226563', '55.868376522659915, 37.49084472656251', '55.78197922246136, 37.81356811523438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(4, NULL, 'Название', 'Пользовательский маршрут', 5140, 'Custom', '1.03 ч', 'Mixed', '55.83831352210821, 37.51281738281251', '55.80977071070357, 37.53479003906251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(37, NULL, 'Название', 'Пользовательский маршрут', 19430, 'Custom', '3.89 ч', 'Mixed', '55.85517527443665, 37.48535156250001', '55.811962250018276, 37.46337890625001', '55.76483626248958, 37.43728637695313', '55.73467664877739, 37.38098144531251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.7558,37.6173', 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(38, NULL, 'Название', 'Пользовательский маршрут', 19430, 'Custom', '3.89 ч', 'Mixed', '55.85517527443665, 37.48535156250001', '55.811962250018276, 37.46337890625001', '55.76483626248958, 37.43728637695313', '55.73467664877739, 37.38098144531251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.7558,37.6173', 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(39, 29, 'Название', 'Пользовательский маршрут', 6830, 'Custom', '1.37 ч', 'Mixed', '55.84062688636364, 37.50320434570313', '55.795877445664125, 37.54302978515626', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.75803176823725,37.62542724609376', 1, NULL, 'private', '', NULL, NULL, NULL, NULL, NULL),
(67, NULL, 'Название маршрута', 'Пользовательский маршрут', 51800, 'Custom', '10.36 ч', 'Mixed', '55.65220757949976, 37.10065272500881', '55.7728442196325, 37.791238249784634', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.71744203349382,37.44586944580079', 1, 11, 'private', '[\"Новая вещdsfdsfdsfdsь\"]', NULL, NULL, NULL, NULL, NULL),
(70, 30, 'Название маршрута', 'Пользовательский маршрут', 30700, 'Custom', '6.14 ч', 'Mixed', '55.93151007833612, 37.34939575195313', '55.737162319794564, 37.28897094726563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.834457609133935,37.34252929687501', 1, NULL, 'private', '[]', NULL, NULL, NULL, NULL, NULL),
(84, NULL, 'Название aasdasdмasdаршрута', 'das', 310, 'Custom', '0.06 ч', 'Mixed', '55.86307739747528, 37.41780035169513', '55.864493989212036, 37.41529047799065', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 17, '55.86371081498347,37.41654217243195', 1, 12, 'pending', '[\"wdsНовая вещь\"]', NULL, NULL, NULL, NULL, NULL),
(95, NULL, 'Название маршрута', 'фвфыфыв', 0, 'Custom', '', 'Mixed', '55.93772754071002, 37.708862242853115', '55.824541812725236, 37.70337050905767', '55.65995187472916, 37.625113302472734', '54.5985978163725, 19.87530554518982', '59.69104310814828, -9.942281811971686', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, '51.998410382390325,-12.458496093750002', 1, 12, 'pending', '[\"Новая ввфвфывыещь\"]', NULL, NULL, NULL, NULL, NULL),
(96, 31, 'Название маршрута', 'ыав', 32920, 'Custom', '6.58 ч', 'Mixed', '55.84062688636364, 37.38235473632813', '55.624894590159975, 37.25326538085938', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.73328297709092,37.32442650000004', 2, NULL, 'private', '[\"Новая вещькпк\"]', NULL, NULL, NULL, NULL, NULL),
(97, NULL, 'asdasdasdasdasd', 'asd', 81800, 'Custom', '16.36 ч', 'Mixed', '55.875400717943826, 37.30110100854214', '55.7867398682956, 37.55921249692755', '55.70638548255686, 37.49468462483117', '56.001489438711296, 37.200876866775495', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.85311989302676,37.3884055', 1, 12, 'pending', '[\"dasdНовая вещь\"]', NULL, NULL, NULL, NULL, NULL),
(98, NULL, 'asdasdd', 'dasda', 29710, 'Custom', '5.94 ч', 'Mixed', '55.86076633954463, 37.39583341651338', '55.68085382062996, 37.16655353055403', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.77132120061455,37.27893199999999', 1, 12, 'pending', '[\"Новая вещьasdsadd\"]', NULL, NULL, NULL, NULL, NULL),
(99, NULL, 'Название маршрута', 'ыфв', 17080, 'Custom', '3.42 ч', 'Mixed', '55.83841902398061, 37.67728477352939', '55.76280539148958, 37.51390569311522', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.80154374120123,37.59383000000001', 1, 14, 'pending', '[]', NULL, NULL, NULL, NULL, NULL),
(100, NULL, 'выаыв', 'фывфыв', 83190, 'Custom', '16.64 ч', 'Mixed', '55.91927077572451, 37.31620327647959', '55.733446300400445, 37.25991300507639', '55.94729629534862, 36.7066918021896', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.834843217637676,37.02701568603516', 1, 14, 'pending', '[\"Новая вещьasdsad\"]', NULL, NULL, NULL, NULL, NULL),
(101, NULL, 'фывыфвфывывфНазвание маршрута', 'фвы', 29880, 'Custom', '5.98 ч', 'Mixed', '55.88925977988212, 37.44663195412115', '55.82299959469957, 37.349153679252204', '55.71721205972215, 37.239319003343496', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.80347325263503,37.33804450000001', 1, 14, 'private', '[]', NULL, NULL, NULL, NULL, NULL),
(102, NULL, 'Название маршрута', 'adsda', 23230, 'Custom', '4.65 ч', 'Mixed', '56.031413571898604, 38.14408214614126', '55.93925310322603, 38.0852705597697', '55.91425844334782, 38.00083515266494', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.984939200229114,38.114147186279304', 1, 20, 'pending', '[\"Новая вещьasdad\"]', 123, '/uploads/guide/guide_20/1769566879124-route-3.jpeg', '/uploads/guide/guide_20/1769566879126-route-3.jpeg', '/uploads/guide/guide_20/1769566879127-route-3.jpeg', '/uploads/guide/guide_20/1769566879127-route-3.jpeg'),
(103, 33, 'Название маршрута', 'kjhdfdsfsdfsdfds', 110140, 'Custom', '22.03 ч', 'Mixed', '55.97610350186218, 37.93716430664063', '55.819801652442436, 37.73529052734376', '55.637298574163, 37.58697509765626', '55.927879797561125, 37.57062435150147', '55.888213066281274, 37.6468849182129', '55.87107334708859, 37.764816284179695', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.80745551080683,37.75794982910156', 2, NULL, 'private', '[]', 123123, '/uploads/participant/user_33/1769570148698-route-3.jpeg', '/uploads/participant/user_33/1769570148700-route-1.jpeg', '/uploads/participant/user_33/1769570148701-route-meerkat-10071273_1280.png', '/uploads/participant/user_33/1769570148718-route-4.jpeg'),
(104, 33, 'ФЫвфывфыв', 'kjhdfdsfsdfsdfds', 155330, 'Custom', '31.07 ч', 'Mixed', '55.97610350186218, 37.93716430664063', '55.819801652442436, 37.73529052734376', '55.637298574163, 37.58697509765626', '55.927879797561125, 37.57062435150147', '55.888213066281274, 37.6468849182129', '55.87107334708859, 37.764816284179695', '55.83060131378955, 37.973556518554695', '55.73948169869349, 37.96188354492188', '55.68610110318785, 37.82730102539063', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.80745551080683,37.770309448242195', 2, NULL, 'private', '[]', 123, '/uploads/participant/user_33/1769570266049-route-4.jpeg', '/uploads/participant/user_33/1769570266050-route-2.jpeg', '/uploads/participant/user_33/1769570266051-route-3.jpeg', '/uploads/participant/user_33/1769570266051-route-3.jpeg'),
(105, NULL, 'Название маршрута', 'asdasd', 81330, 'Custom', '16.27 ч', 'Mixed', '55.93304863776238, 37.87673950195313', '55.72556335763931, 37.61444091796876', '55.470291692680604, 37.22030639648438', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.8309356191101,37.74605100000003', 1, 23, 'pending', '[\"asdaНовая вещь\"]', 1231231, '/uploads/guide/guide_23/1769570743285-route-meerkat-10071273_1280.png', '/uploads/guide/guide_23/1769570743299-route-4.jpeg', '/uploads/guide/guide_23/1769570743300-route-meerkat-10071273_1280.png', '/uploads/guide/guide_23/1769570743315-route-4.jpeg'),
(106, 35, 'Название маршрута', 'asdasdd', 23970, 'Custom', '4.79 ч', 'Mixed', '55.93227936568622, 37.63092041015626', '55.81208577289999, 37.44277954101563', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.872140085618064,37.537506000000015', 2, NULL, 'private', '[\"Новая вещьdas\"]', 13, '/uploads/participant/user_35/1769970586127-route-Ð²Ñ.jpg', '/uploads/participant/user_35/1769970586130-route-Ð²Ñ.jpg', '/uploads/participant/user_35/1769970586131-route-ÐÐµÐ· Ð¸Ð¼ÐµÐ½Ð¸.png', '/uploads/participant/user_35/1769970586132-route-ÐÐµÐ· Ð¸Ð¼ÐµÐ½Ð¸.png'),
(107, NULL, 'Название маршрута', 'sad', 36290, 'Custom', '7.26 ч', 'Mixed', '55.8467951848097, 37.65563964843751', '55.68610110318785, 37.53479003906251', '55.62256840602218, 37.43316650390626', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, '55.73400449275776,37.54836600000001', 1, 24, 'pending', '[]', 12, '/uploads/guide/guide_24/1769976411447-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976411453-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976411457-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976411460-route-Ð¨ÐÐÐÐ.jpg'),
(108, NULL, 'фывфы', 'qwewqe', 190940, 'Custom', '38.19 ч', 'Mixed', '55.831372603449026, 37.50183105468751', '55.70854531198261, 37.36724853515626', '55.66209476458093, 37.34664916992188', '55.573686641951475, 37.07199096679688', '55.147488450471016, 35.67260742187501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, '55.49674933830372,36.58996582031251', 1, 24, 'pending', '[\"Новая вещqweь\"]', 123, NULL, NULL, NULL, NULL),
(109, NULL, 'qweqwe', 'qwe', 21580, 'Custom', '4.32 ч', 'Mixed', '55.832915136881745, 37.54440307617188', '55.70390273988158, 37.38098144531251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.768502029326314,37.462562', 2, 24, 'pending', '[\"qeНовая вещь\"]', 213, '/uploads/guide/guide_24/1769975160812-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975160817-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975160821-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975160824-route-478950e8733160ad22de5e7d50d648cb.jpg'),
(110, NULL, 'фывфыф', 'фывыфв', 17140, 'Custom', '3.43 ч', 'Mixed', '55.811314100800935, 37.56912231445313', '55.73252314847775, 37.38647460937501', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 13, '55.772026947109964,37.477718500000016', 1, 24, 'pending', '[]', 123, '/uploads/guide/guide_24/1769975604422-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975604426-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975604433-route-478950e8733160ad22de5e7d50d648cb.jpg', '/uploads/guide/guide_24/1769975604437-route-478950e8733160ad22de5e7d50d648cb.jpg'),
(111, NULL, 'вфывфывыфвыф', 'п', 20260, 'Custom', '4.05 ч', 'Mixed', '55.88378442572491, 37.81631469726563', '55.80822725940602, 37.61032104492188', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.85112025761726,37.713303999999965', 1, 24, 'pending', '[]', 123, '/uploads/guide/guide_24/1769975638856-route-Gemini_Generated_Image_unumfyunumfyunum.png', '/uploads/guide/guide_24/1769975638868-route-Gemini_Generated_Image_unumfyunumfyunum.png', '/uploads/guide/guide_24/1769975638874-route-se-solicita-programa.jpg', '/uploads/guide/guide_24/1769975638875-route-se-solicita-programa.jpg'),
(112, NULL, 'asdasdasdasasd', 'asd', 12880, 'Custom', '2.58 ч', 'Mixed', '55.73948169869349, 37.31094360351563', '55.654347641744216, 37.27111816406251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.69672647746085,37.29296749999998', 1, 24, 'pending', '[]', 123, '/uploads/guide/guide_24/1769976429471-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976429478-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976429480-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_24/1769976429483-route-Ð¨ÐÐÐÐ.jpg'),
(113, NULL, 'ewruil;kytrew', 'qwewqeqe', 38610, 'Custom', '7.72 ч', 'Mixed', '55.85912884568613, 37.52243041992188', '55.74180093975863, 37.44415283203126', '55.87145859243408, 37.35797882080079', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, '55.80716610113745,37.43213653564454', 1, 24, 'pending', '[]', 1231, '/uploads/guide/guide_24/1769979276871-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg', '/uploads/guide/guide_24/1769979276885-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg', '/uploads/guide/guide_24/1769979276892-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg', '/uploads/guide/guide_24/1769979276896-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg'),
(114, NULL, 'Название маршрута', 'qweqeqwe', 107120, 'Custom', '21.42 ч', 'Mixed', '55.91458189198761, 37.47848510742188', '55.81054241340218, 37.37960815429688', '55.66829135900412, 37.26562500000001', '55.543395974727055, 37.56088256835938', '55.65279803318956, 37.714691162109375', '55.76421316483773, 37.73391723632813', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, '55.728270090392606,37.50595092773438', 1, 25, 'pending', '[]', 213, '/uploads/guide/guide_25/1770076235647-route-Ð¨ÐÐÐÐ 2.png', '/uploads/guide/guide_25/1770076235653-route-Ð¨ÐÐÐÐ.jpg', '/uploads/guide/guide_25/1770076235659-route-Ð°Ð²Ð° ÐºÐ²Ð¾ÑÐº.jpg', '/uploads/guide/guide_25/1770076235664-route-Ð¨ÐÐÐÐ 2.png');

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
(25, NULL, '$2b$10$FSnXB8pdicxZNvSX7niiKe5z7IXjf5KkRKlrCgFrJYsssCDSJJ/Cy', 'wqe', 'qe', '+72345677865', 'qwqeqweerty583274@gmail.com', 80, '/uploads/guide/guide_25/1770076606218-lic-Ð¨ÐÐÐÐ 2.png', 'organizer', 'Любитель', 'https://t.me/adas', 'https://vk.com/qqweqweqwe');

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
(2, 'Ледяной Байкал', 'Прогулка по прозрачному льду озера Байкал с посещением ледяных гротов. В зимний период лед достигает максимальной прочности и красоты.', 20, 'Коньковый', '06:30:00', 'Лед', 'Коньки, ледоступы', 5000, 3500, 1),
(3, 'Альпийский спуск', 'Горнолыжный спуск средней сложности с подготовленными трассами. Работает исключительно в зимние месяцы при наличии снежного покрова.', 5, 'Лыжный', '02:00:00', 'Горы', 'Лыжи, шлем', 15000, 4000, 1),
(4, 'Огни ночного города', 'Городской маршрут по празднично украшенным центральным улицам и площадям. Лучшее время для прогулки — вечер декабря или января.', 8, 'Пеший', '03:00:00', 'Асфальт', 'Удобная обувь', 0, 500, 3),
(5, 'Тропа хаски', 'Маршрут для катания на собачьих упряжках по подготовленной снежной трассе. Отличное зимнее приключение для всей семьи.', 10, 'Упряжки', '01:30:00', 'Снежная трасса', 'Зимний комбинезон', 8000, 12000, 2),
(6, 'Горячие источники', 'Путь к открытым термальным бассейнам через заснеженное предгорье. Контраст ледяного воздуха и горячей воды бодрит и оздоравливает.', 12, 'Авто-пеший', '04:00:00', 'Предгорье', 'Купальные принадлежности', 3000, 2500, 10),
(7, 'Заповедный лес', 'Экологическая тропа в национальном парке, где можно встретить диких животных в их зимнем обитании. Требует соблюдения тишины.', 7, 'Пеший/Лыжный', '04:30:00', 'Смешанный лес', 'Снегоступы', 1500, 800, 9),
(8, 'Ледяная пещера', 'Спуск в пещеру, где зимой образуются уникальные ледяные сталактиты и сталагмиты. Температура внутри стабильно низкая.', 3, 'Спелео', '02:00:00', 'Пещера', 'Фонарь, каска', 2500, 1200, 12),
(9, 'Вершины Хибин', 'Восхождение на небольшую вершину с панорамным видом на северное сияние. Маршрут доступен только при благоприятном прогнозе погоды.', 6, 'Альпинизм', '08:00:00', 'Скалы, снег', 'Кошки, ледоруб', 10000, 5000, 1),
(10, 'Восхождение на Эльбрус', 'Сложный подъем для подготовленных.', 15, 'Горный', '10:00:00', 'Снег/Лед', 'Альпинистские кошки', 5000, 15000, 1),
(11, 'Лесные тропы Карелии', 'Спокойная прогулка.', 8, 'Пеший', '04:30:00', 'Лесная почва', 'Удобная обувь', 500, 2500, 2);

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

--
-- Дамп данных таблицы `route_schedule`
--

INSERT INTO `route_schedule` (`Schedule_ID`, `Route_custom_ID`, `Point_Index`, `Visit_Date`, `Visit_Time`, `Note`) VALUES
(37, 67, 1, '2026-01-26 00:00:00', '12:00:00', 'Запланировано'),
(39, 70, 1, '2026-01-26 00:00:00', '12:00:00', 'Запланировано'),
(70, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(71, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(72, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(73, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(74, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(75, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(76, 96, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(77, 96, 1, '2026-01-28 00:00:00', '06:06:00', 'Запланировано'),
(78, 84, 1, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(79, 98, 1, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(80, 95, 0, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(81, 95, 1, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(82, 99, 1, '2026-01-27 00:00:00', '12:00:00', 'Запланировано'),
(83, 103, 1, '2026-01-28 00:00:00', '12:00:00', 'Запланировано'),
(84, 103, 0, '2026-01-29 00:00:00', '12:00:00', 'Запланировано'),
(85, 103, 1, '2026-01-29 00:00:00', '12:00:00', 'Запланировано'),
(86, 104, 1, '2026-01-28 00:00:00', '12:00:00', 'Запланировано'),
(87, 104, 0, '2026-01-29 00:00:00', '12:00:00', 'Запланировано'),
(88, 104, 1, '2026-01-29 00:00:00', '12:00:00', 'Запланировано'),
(89, 104, 1, '2026-01-28 00:00:00', '12:00:00', 'Запланировано'),
(90, 104, 0, '2026-01-29 00:00:00', '12:00:00', 'Запланировано'),
(91, 104, 1, '2026-01-29 00:00:00', '12:00:00', 'Запланировано'),
(92, 105, 1, '2026-01-28 00:00:00', '12:00:00', 'Запланировано'),
(93, 106, 2, '2026-02-02 00:00:00', '12:00:00', 'Запланировано'),
(94, 107, 2, '2026-02-01 00:00:00', '12:00:00', 'Запланировано'),
(95, 107, 2, '2026-02-01 00:00:00', '12:00:00', 'Запланировано'),
(96, 108, 2, '2026-02-01 00:00:00', '12:00:00', 'Запланировано');

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
(35, '$2b$10$3TLsdCZ6ZmK9EGz6B7sWkOKdodcaEV5YoG1eenkbdVGsffCaaynqW', 'йцу', 'йцу', NULL, 'qweeldarsibrimov18@gmail.com', NULL, NULL, 'participant', 'beginner');

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
(61, 3, NULL, 34, '2026-01-10 00:00:00', NULL);

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
  MODIFY `Route_custom_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT для таблицы `guides`
--
ALTER TABLE `guides`
  MODIFY `Guide_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT для таблицы `routes`
--
ALTER TABLE `routes`
  MODIFY `Route_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `route_point`
--
ALTER TABLE `route_point`
  MODIFY `Point_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `route_schedule`
--
ALTER TABLE `route_schedule`
  MODIFY `Schedule_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT для таблицы `tourist`
--
ALTER TABLE `tourist`
  MODIFY `Tourist_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `trip_request`
--
ALTER TABLE `trip_request`
  MODIFY `Trip_ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

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
