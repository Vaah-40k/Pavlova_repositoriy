require("dotenv").config({ quiet: true })


const sequelize = require("sequelize")
const bodyParser = require("body-parser")
const express = require("express")
const app = express()
const path = require("path")
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cookieParser = require('cookie-parser');
const axios = require('axios');
const multer = require('multer');
const fs = require('fs');

const db = require("./db/indexdb")
const Turist = db.Turist
const Guide = db.Guide
const Route = db.Route
const Record = db.Record
const Custum_Route = db.Custum_Route
const Route_Schedule = db.Route_Schedule
const Route_Point = db.Route_Point
const Administrator = db.administrator;


const __dirnames = __dirname.replace("script", "")
const SECRET_KEY = process.env.JWT_SECRET


app.use(express.json());
app.use(express.static(path.join(__dirnames, 'css')));
app.use(cookieParser());
app.use('/uploads', express.static(path.join(__dirnames, 'uploads')));

const licensesDir = path.join(__dirnames, 'uploads/licenses');
if (!fs.existsSync(licensesDir)) {
    fs.mkdirSync(licensesDir, { recursive: true });
}

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, licensesDir);
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname);
    }
});
const upload = multer({ storage: storage });


const Working_Site = () => {
    app.get("", (req, res) => {
        res.sendFile(__dirnames + "index.html")
    })

    app.get("/autorization", (req, res) => {
        res.sendFile(__dirnames + "autorization.html")
    })
    app.get("/scheduler", (req, res) => {
        res.sendFile(__dirnames + "scheduler.html")
    })
    app.get("/lk", (req, res) => {
        res.sendFile(__dirnames + "lk.html")
    })
    app.get("/registration", (req, res) => {
        res.sendFile(__dirnames + "registration.html")
    })
    app.get("/trek", (req, res) => {
        res.sendFile(__dirnames + "trek.html")
    })


    app.get("/api/get-route-details", async (req, res) => {
        const { id, type } = req.query;

        if (!id || !type) {
            return res.status(400).json({ error: "Не указан ID или тип маршрута" });
        }

        try {
            let routeData = {
                name: "",
                points: [],
                schedule: [],
                days: 1,
                distance: '0'
            };

            if (type === 'standard') {
                const route = await Route.findByPk(id, {
                    include: [{
                        model: Route_Point,
                        as: 'points'
                    }],
                    order: [[{ model: Route_Point, as: 'points' }, 'Sequence_Number', 'ASC']]
                });

                if (!route) return res.status(404).json({ error: "Маршрут не найден" });

                routeData.name = route.Route_Name;
                routeData.days = route.Route_Duration || 'Не указано';
                routeData.distance = route.Route_Length ? (route.Route_Length / 1000).toFixed(2) : '0';

                if (route.points && route.points.length > 0) {
                    routeData.points = route.points.map(pt => {
                        const [lat, lng] = pt.Coordinates ? pt.Coordinates.split(',').map(s => parseFloat(s.trim())) : [0, 0];
                        return { lat, lng, name: pt.Point_Name };
                    });
                }
            } else if (type === 'custom') {
                const route = await Custum_Route.findByPk(id, {
                    include: [{
                        model: Route_Schedule,
                        as: 'Route_Schedules'
                    }]
                });

                if (!route) return res.status(404).json({ error: "Маршрут не найден" });

                routeData.name = route.Route_Name;
                routeData.days = route.Route_Days || 1;
                routeData.distance = route.Route_Length ? (route.Route_Length / 1000).toFixed(2) : '0';  // В км

                for (let i = 1; i <= 20; i++) {
                    const wpRaw = route[`WaiPoint${i}`];
                    if (wpRaw) {
                        const [lat, lng] = wpRaw.split(',').map(s => parseFloat(s.trim()));
                        routeData.points.push({ lat, lng, name: `Точка ${i}` });
                    }
                }

                if (route.Route_Schedules && route.Route_Schedules.length > 0) {
                    routeData.schedule = route.Route_Schedules.map(sch => ({
                        point_index: sch.Point_Index,
                        visit_date: sch.Visit_Date,
                        visit_time: sch.Visit_Time,
                        note: sch.Note
                    }));
                }
            }

            res.json(routeData);

        } catch (err) {
            console.error("Ошибка при получении деталей маршрута:", err);
            res.status(500).json({ error: "Ошибка сервера" });
        }
    });
}

// АВТОРИЗАЦИЯ


app.post("/registration", async (req, res) => {
    let Finel_hash_Password = null;
    async function hashPassword(password) {
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        return hashedPassword;
    }
    Finel_hash_Password = (await hashPassword(req.body["password"])).toString();

    try {
        const existingUser = await Turist.findOne({
            where: { email: req.body["email"] }
        }) || await Guide.findOne({
            where: { email: req.body["email"] }
        });

        if (existingUser) {
            return res.status(400).json({
                status: "error",
                message: "Пользователь с такой почтой уже существует"
            });
        }

        let userId, userRole;
        if (req.body["role"] === "participant") {
            const Tourist = await Turist.create({
                password: Finel_hash_Password,
                First_Name: req.body["firstName"],
                Last_Name: req.body["lastName"],
                email: req.body["email"],
                role: req.body["role"],
                experience: req.body["experience"],
            });
            console.log("Новый турист был добавлен в таблицу");
            userId = Tourist.Tourist_ID;
            userRole = "participant";
            const fullName = `${Tourist.First_Name} ${Tourist.Last_Name}`;
            const initial = Tourist.First_Name[0].toUpperCase();


            const token = jwt.sign({
                id: userId,
                role: userRole,
                name: fullName,
                initial: initial
            }, SECRET_KEY, { expiresIn: '3d' });

            res.cookie('token', token, {
                httpOnly: true,
                maxAge: 3 * 24 * 60 * 60 * 1000,
                sameSite: 'strict'
            });
        } else if (req.body["role"] === "organizer") {
            const Gide = await Guide.create({
                password: Finel_hash_Password,
                First_Name: req.body["firstName"],
                Last_Name: req.body["lastName"],
                email: req.body["email"],
                role: req.body["role"],
                experience: req.body["experience"],
            });
            console.log("Новый гид был добавлен в таблицу");
            userId = Gide.Guide_ID;
            userRole = "organizer";

            const fullName = `${Gide.First_Name} ${Gide.Last_Name}`;
            const initial = Gide.First_Name[0].toUpperCase();
            const token = jwt.sign({
                id: Gide.Guide_ID,
                role: "organizer",
                name: fullName,
                initial: initial
            }, SECRET_KEY, { expiresIn: '3d' });

            res.cookie('token', token, {
                httpOnly: true,
                maxAge: 3 * 24 * 60 * 60 * 1000,
                sameSite: 'strict'
            });
        } else {
            return res.status(400).json({ status: "error", message: "Неверная роль" });
        }

        res.status(200).json({ status: "ok", role: userRole });

    } catch (err) {
        console.log("Произошла ошибка");
        console.log(err);
        res.status(500).json({ status: "err" });
    }
});

app.post("/autorization", async (req, res) => {
    try {
        const { email, password } = req.body;

        let user = await Turist.findOne({ where: { email: email } });
        let userRole = "participant";

        if (!user) {
            user = await Guide.findOne({ where: { email: email } });
            userRole = "organizer";
        }

        if (!user) {
            user = await Administrator.findOne({ where: { email: email } });
            userRole = "admin";
        }

        if (!user) {
            return res.status(400).json({ message: "Пользователь не найден" });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: "Неверный пароль" });
        }

        const fullName = userRole === "admin" ? "Администратор" : `${user.First_Name} ${user.Last_Name}`;
        const initial = userRole === "admin" ? "А" : user.First_Name[0].toUpperCase();

        const token = jwt.sign({
            id: userRole === "participant" ? user.Tourist_ID : (userRole === "organizer" ? user.Guide_ID : user.ID_administrator),
            role: userRole,
            name: fullName,
            initial: initial
        }, SECRET_KEY, { expiresIn: '3d' });

        res.cookie('token', token, {
            httpOnly: true,
            maxAge: 3 * 24 * 60 * 60 * 1000,
            sameSite: 'strict'
        });

        res.json({ status: "ok", role: userRole });

    } catch (err) {
        console.error("Ошибка авторизации:", err);
        res.status(500).json({ message: "Ошибка сервера" });
    }
});

app.get("/routes", async (req, res) => {
    try {
        const routes = await Route.findAll();
        const result = routes.map(route => ({
            Route_ID: route.Route_ID,
            Route_Name: route.Route_Name,
            Route_Description: route.Route_Description,
            Route_Length: route.Route_Length,
            Route_Duration: route.Route_Duration,
            Stop: route.Stop
        }));
        res.json({ routes: result });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Ошибка получения маршрутов" });
    }
});

app.get('/api/admin/all-routes', async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        if (decoded.role !== 'admin') return res.status(403).json({ error: "Нет доступа" });

        // 1. Маршруты на сайте (Таблица routes)
        const siteRoutes = await Route.findAll();

        // 2. Предложенные маршруты (Таблица custom_routse со статусом 'pending')
        // Примечание: пока кнопку "Опубликовать" мы не сделали, вы можете вручную в БД поставить status='pending' для теста
        const proposedRoutes = await Custum_Route.findAll({
            where: { status: 'pending' }
        });

        // 3. Пользовательские маршруты (Остальные, для статистики или модерации)
        // Можно выводить все, кроме pending, или только private
        const userRoutes = await Custum_Route.findAll({
            where: { status: 'private' }
        });

        res.json({
            site: siteRoutes,
            proposed: proposedRoutes,
            custom: userRoutes
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Ошибка сервера" });
    }
});

app.delete('/api/admin/delete-site-route', async (req, res) => {
    const token = req.cookies.token;
    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        if (decoded.role !== 'admin') return res.status(403).json({ error: "Нет доступа" });

        const { id } = req.body;
        await Route.destroy({ where: { Route_ID: id } });

        res.json({ status: "ok" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Ошибка удаления" });
    }
});

app.post("/api/join-route", async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        if (decoded.role !== "participant") {
            return res.status(403).json({ error: "Доступно только для участников" });
        }

        const { routeId, date } = req.body;

        await Record.create({
            Tourist_ID: decoded.id,
            Route_ID: routeId,
            Trip_Start_Date: date
        });

        res.json({ status: "ok" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Ошибка записи" });
    }
});

app.get('/api/user-routes', async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json([]);

    let userId;
    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        userId = decoded.id;
    } catch (err) {
        return res.status(401).json([]);
    }

    try {
        const data = [];

        // Standard маршруты (из Record)
        const records = await Record.findAll({ where: { Tourist_ID: userId } });
        for (const record of records) {
            const route = await Route.findByPk(record.Route_ID);
            if (route) { // Проверяем существование
                data.push({
                    bookingId: `standard_${record.Route_ID}`,
                    title: route.Route_Name || 'Неизвестно',
                    date: record.Trip_Start_Date ? record.Trip_Start_Date.toISOString().split('T')[0] : null,
                    days: route.Route_Duration || 'Не указано',  // Время как строка 'HH:MM:SS' для formatDuration
                    distance: route.Route_Length ? (route.Route_Length / 1000).toFixed(2) : '0',  // В км
                    description: route.Route_Description || '',
                    type: 'standard'
                });
            }
        }

        // Custom маршруты
        const customs = await Custum_Route.findAll({ where: { Tourist_ID: userId } });
        for (const custom of customs) {
            const distKm = custom.Route_Length ? (custom.Route_Length / 1000).toFixed(2) : '0';
            data.push({
                bookingId: `custom_${custom.Route_custom_ID}`,
                title: custom.Route_Name || 'Пользовательский маршрут',
                date: null,  // Можно добавить из Route_Schedule, если нужно
                days: custom.Route_Days || 1,  // Из нового поля (число дней)
                distance: distKm,
                description: custom.Route_Description || '',
                type: 'custom'
            });
        }

        res.json(data);
    } catch (err) {
        console.error('Ошибка в /api/user-routes:', err);
        res.status(500).json([]);
    }
});


app.get('/api/auth-status', (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.json({ isAuthenticated: false });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        res.json({
            isAuthenticated: true,
            user: {
                name: decoded.name,
                role: decoded.role,
                initial: decoded.initial
            }
        });
    } catch (err) {
        res.json({ isAuthenticated: false });
    }
});

// ==========================================
// 3. Загрузка профиля
// ==========================================
app.get('/api/get-user-profile', async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        const role = decoded.role;
        const userId = decoded.id;

        let user;
        if (role === 'participant') {
            user = await Turist.findByPk(userId);
        } else if (role === 'organizer') {
            user = await Guide.findByPk(userId);
        }

        if (!user) return res.status(404).json({ error: "Пользователь не найден" });

        // Возвращаем данные (без пароля!)
        const profileData = {
            First_Name: user.First_Name,
            Last_Name: user.Last_Name,
            email: user.email,
            phone: user.phone || '',
            age: (role === 'participant' ? user.age : user.Age) || 0,
            experience: user.experience || ''
        };

        if (role === 'participant') profileData.gender = user.gender || '';
        if (role === 'organizer') {
            profileData.Guide_License = user.Guide_License || '';
            profileData.link_vk_group = user.link_vk_group || '';
            profileData.link_tg_group = user.link_tg_group || '';
        }
        res.json(profileData);

    } catch (err) {
        console.error("Ошибка загрузки профиля:", err);
        res.status(500).json({ error: "Ошибка сервера" });
    }
});

// ==========================================
// 4. Обновление профиля (с поддержкой файла)
// ==========================================
// Эндпоинт обновления профиля
app.put('/api/update-user-profile', upload.single('Guide_License'), async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        const role = decoded.role;
        const userId = decoded.id;

        let user;
        if (role === 'participant') {
            user = await Turist.findByPk(userId);
        } else if (role === 'organizer') {
            user = await Guide.findByPk(userId);
        }

        if (!user) return res.status(404).json({ message: "Пользователь не найден" });

        // 1. Обновление текстовых полей
        // Явно мапим поля, чтобы избежать путаницы с регистром (Age vs age)
        user.First_Name = req.body.First_Name;
        user.Last_Name = req.body.Last_Name;
        user.phone = req.body.phone;
        user.experience = req.body.experience;

        // Обработка возраста (с фронта приходит 'age', у гида в БД поле 'Age')
        if (req.body.age) {
            if (role === 'organizer') user.Age = req.body.age;
            else user.age = req.body.age;
        }

        if (role === 'participant') {
            user.gender = req.body.gender;
        }

        if (role === 'organizer') {
            // Ссылки обновляем всегда, независимо от того, загружен файл или нет
            user.link_vk_group = req.body.link_vk_group;
            user.link_tg_group = req.body.link_tg_group;
        }

        // 2. Обработка файла лицензии (удаление старого и запись нового)
        if (role === 'organizer' && req.file) {
            // Если у пользователя уже был файл, удаляем его
            if (user.Guide_License) {
                // Путь в БД начинается с /, убираем его для fs.unlink
                const oldPathRelative = user.Guide_License.startsWith('/') ? user.Guide_License.slice(1) : user.Guide_License;
                const oldPathFull = path.join(__dirnames, oldPathRelative);

                fs.unlink(oldPathFull, (err) => {
                    if (err && err.code !== 'ENOENT') {
                        console.error("Ошибка удаления старой лицензии:", err);
                    } else {
                        console.log("Старый файл лицензии удален:", oldPathFull);
                    }
                });
            }

            // Записываем путь к новому файлу
            user.Guide_License = `/licenses_guide/${req.file.filename}`;
        }

        await user.save();

        // Генерация нового токена
        const fullName = `${user.First_Name} ${user.Last_Name}`;
        const initial = user.First_Name[0].toUpperCase();

        const newToken = jwt.sign({
            id: userId,
            role: role,
            name: fullName,
            initial: initial
        }, SECRET_KEY, { expiresIn: '3d' });

        res.cookie('token', newToken, {
            httpOnly: true,
            maxAge: 3 * 24 * 60 * 60 * 1000,
            sameSite: 'strict'
        });

        res.json({
            status: "ok",
            user: { name: fullName, initial: initial },
            // Возвращаем новый путь к лицензии, чтобы фронтенд обновил ссылку сразу
            newLicenseUrl: user.Guide_License
        });

    } catch (err) {
        console.error("Ошибка при обновлении:", err);
        res.status(500).json({ message: "Ошибка при обновлении профиля" });
    }
});
// ==========================================
// 5. Сохранение пользовательского маршрута (Удалить и Заменить)
// ==========================================
app.post("/api/save-custom-route", async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        const userId = decoded.id; // ID текущего пользователя

        const { name, description, length, duration, days, points, schedule, map_zoom, map_center } = req.body;  // Добавили days

        // Подготовка данных для создания нового маршрута
        const routeDataPayload = {
            Tourist_ID: userId,
            Route_Name: name || "Без названия",
            Route_Description: description || "",
            Route_Length: parseInt(length) || 0,  // В метрах
            Route_Duration: duration || "",
            Route_Type: "Custom",
            Terrain_Type: "Mixed",
            Route_Days: parseInt(days) || 1,  // Новое: сохраняем количество дней
            Map_Zoom: map_zoom || null,
            Map_Center: map_center || null
        };

        // Заполняем WaiPoint1...20 (без изменений)
        if (Array.isArray(points)) {
            for (let i = 0; i < 20; i++) {
                const key = `WaiPoint${i + 1}`;
                if (points[i]) {
                    routeDataPayload[key] = `${points[i].lat}, ${points[i].lng}`;
                } else {
                    routeDataPayload[key] = null; // Явно очищаем пустые слоты
                }
            }
        } else {
            // Если точек нет, забиваем null
            for (let i = 1; i <= 20; i++) {
                routeDataPayload[`WaiPoint${i}`] = null;
            }
        }

        // 1. Ищем старый маршрут с таким же именем (без изменений)
        const existingRoute = await Custum_Route.findOne({
            where: {
                Tourist_ID: userId,
                Route_Name: name
            }
        });

        let message = "";

        // 2. Если нашли — УДАЛЯЕМ его (без изменений)
        if (existingRoute) {
            await existingRoute.destroy();
            message = "Маршрут перезаписан (карточка обновлена)!";
        } else {
            message = "Новый маршрут создан!";
        }

        // 3. СОЗДАЕМ маршрут заново (без изменений)
        const createdRoute = await Custum_Route.create(routeDataPayload);
        const targetRouteId = createdRoute.Route_custom_ID;

        // 4. Записываем новое расписание (без изменений)
        if (schedule && Array.isArray(schedule) && schedule.length > 0) {
            const scheduleRecords = schedule.map(item => ({
                Route_custom_ID: targetRouteId,
                Point_Index: item.point_index,
                Visit_Date: item.visit_date,
                Visit_Time: item.visit_time,
                Note: "Запланировано"
            }));

            await Route_Schedule.bulkCreate(scheduleRecords);
        }

        res.status(200).json({ status: "ok", message: message });

    } catch (err) {
        console.error("Ошибка при сохранении маршрута:", err);
        res.status(500).json({ error: "Ошибка сохранения маршрута" });
    }
});

app.delete("/api/delete-route", async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        const userId = decoded.id; // ID пользователя из токена
        const { bookingId } = req.body; // Получаем ID вида "standard_5" или "custom_10"

        if (!bookingId) return res.status(400).json({ error: "Не указан ID" });

        const [type, id] = bookingId.split('_'); // Разделяем тип и ID

        if (type === 'standard') {
            // Если это "standard", удаляем БРОНЬ из таблицы Record (trip_request)
            // Удаляем запись, где совпадает ID маршрута И ID туриста
            const deleted = await Record.destroy({
                where: {
                    Route_ID: id,
                    Tourist_ID: userId
                }
            });

            if (deleted === 0) {
                return res.status(404).json({ error: "Бронирование не найдено" });
            }

        } else if (type === 'custom') {
            // Если это "custom", удаляем сам МАРШРУТ из таблицы Custum_Route
            const deleted = await Custum_Route.destroy({
                where: {
                    Route_custom_ID: id,
                    Tourist_ID: userId
                }
            });

            if (deleted === 0) {
                return res.status(404).json({ error: "Маршрут не найден" });
            }
        } else {
            return res.status(400).json({ error: "Неверный тип маршрута" });
        }

        res.json({ status: "ok" });

    } catch (err) {
        console.error("Ошибка при удалении маршрута:", err);
        res.status(500).json({ error: "Ошибка сервера при удалении" });
    }
});


// ПРОКЛАДКА МАРШРУТОВ (ВЕЛОСИПЕД)
// ПРОКЛАДКА МАРШРУТОВ (ВЕЛОСИПЕД)
app.post('/generate-route', async (req, res) => {
    const { coordinates } = req.body;

    // Валидация входных данных
    if (!coordinates || !Array.isArray(coordinates) || coordinates.length < 2) {
        return res.status(400).json({ error: 'Для маршрута нужно минимум 2 точки.' });
    }

    try {
        const apiKey = process.env.ORS_API_KEY; // Убедись, что ключ есть в .env

        // Формируем радиусы поиска дорог (ставим 2000м, но на бесплатном тарифе лимит ~350м)
        const radiuses = coordinates.map(() => 2000);

        // Используем профиль 'cycling-mountain' для лучшей проходимости в лесах
        const response = await axios.post('https://api.openrouteservice.org/v2/directions/foot-hiking/geojson', {
            coordinates: coordinates,
            elevation: true,
            extra_info: ['waytype', 'surface', 'steepness'],
            radiuses: radiuses
        }, {
            headers: {
                'Authorization': apiKey,
                'Content-Type': 'application/json'
            }
        });

        // Если маршрут пустой или API вернул странный ответ
        if (!response.data.features || response.data.features.length === 0) {
            return res.status(422).json({ error: 'Маршрут не найден. Нет дорог рядом.' });
        }

        const route = response.data.features[0];
        const summary = route.properties.summary;

        // БЕЗОПАСНАЯ СБОРКА ОТВЕТА (защита от крашей toFixed)
        res.json({
            distance: ((summary.distance || 0) / 1000).toFixed(2) + ' км',
            duration: ((summary.duration || 0) / 3600).toFixed(2) + ' ч', // Время для велика
            ascent: (summary.ascent || 0).toFixed(0) + ' м',
            descent: (summary.descent || 0).toFixed(0) + ' м',
            geometry: route.geometry,
            // Безопасное извлечение сегментов
            segments: route.properties.segments ? route.properties.segments.map((seg, index) => ({
                startToEnd: `Участок ${index + 1}`,
                waytype: seg.extras?.waytype?.summary || 'Неизвестно',
                surface: seg.extras?.surface?.summary || 'Грунт/Тропа',
                distance: ((seg.distance || 0) / 1000).toFixed(2) + ' км'
            })) : []
        });

    } catch (error) {
        // Логирование для отладки
        if (error.response && error.response.data) {
            console.error("Ошибка ORS:", JSON.stringify(error.response.data, null, 2));

            // Обработка ошибки "Точка слишком далеко от дороги" (Code 2010)
            if (error.response.data.error?.code === 2010) {
                return res.status(422).json({
                    error: 'Точка слишком далеко от дороги/тропы. Передвиньте метку ближе к путям.'
                });
            }
        } else {
            console.error("Ошибка сервера:", error.message);
        }

        res.status(500).json({ error: 'Не удалось построить веломаршрут.' });
    }
});

function startServer() {
    Working_Site()

    const server = app.listen(process.env.PORT, () => {
        console.log(`Сервер запущен на порту ${process.env.PORT}`);
    });

    server.on('error', (err) => {
        console.error("Ошибка при запуске сервера:", err.message);
        console.log("Повторная попытка через 3 секунды...");
        setTimeout(startServer, 3000); // Рекурсивный вызов
    });
}

startServer();