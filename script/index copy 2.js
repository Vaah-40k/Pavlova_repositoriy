require("dotenv").config({ quiet: true });

const sequelize = require("sequelize");
const bodyParser = require("body-parser");
const express = require("express");
const app = express();
const path = require("path");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
const axios = require("axios");
const multer = require("multer");
const fs = require("fs");

const db = require("./db/indexdb");
const Turist = db.Turist;
const Guide = db.Guide;
const Route = db.Route;
const Record = db.Record;
const Custum_Route = db.Custum_Route;
const Route_Schedule = db.Route_Schedule;
const Route_Point = db.Route_Point;
const Administrator = db.administrator;

const __dirnames = __dirname.replace("script", "");
const SECRET_KEY = process.env.JWT_SECRET;

app.use(express.json());
app.use(express.static(path.join(__dirnames, "css")));
app.use(cookieParser());
app.use("/uploads", express.static(path.join(__dirnames, "uploads")));

const routesDir = path.join(__dirnames, "uploads/routes");
if (!fs.existsSync(routesDir)) {
  fs.mkdirSync(routesDir, { recursive: true });
}

const licensesDir = path.join(__dirnames, "uploads/licenses");
if (!fs.existsSync(licensesDir)) {
  fs.mkdirSync(licensesDir, { recursive: true });
}

const getGuideDir = (req) => {
  const token = req.cookies.token;
  if (!token) return null;

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const userId = decoded.id;
    const role = decoded.role;

    if (role === "organizer") {
      const guideDir = path.join(
        __dirnames,
        "uploads",
        "guide",
        `guide_${userId}`,
      );
      if (!fs.existsSync(guideDir)) {
        fs.mkdirSync(guideDir, { recursive: true });
      }
      return guideDir;
    }

    const participantDir = path.join(
      __dirnames,
      "uploads",
      "participant",
      `user_${userId}`,
    );
    if (!fs.existsSync(participantDir)) {
      fs.mkdirSync(participantDir, { recursive: true });
    }
    return participantDir;
  } catch (err) {
    console.error("Ошибка определения папки пользователя:", err);
    return null;
  }
};

// 2. Динамическое хранилище для лицензий
const storageLicenses = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = getGuideDir(req);
    if (dir) cb(null, dir);
    else cb(new Error("Не удалось определить папку для загрузки"), null);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-lic-" + file.originalname);
  },
});

// 3. Динамическое хранилище для фото маршрутов (теперь тоже в папку гида)
const storageRoutes = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = getGuideDir(req);
    if (dir) cb(null, dir);
    else cb(new Error("Не удалось определить папку для загрузки"), null);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-route-" + file.originalname);
  },
});

// 4. Инициализация middleware
const uploadLicense = multer({ storage: storageLicenses });
const uploadRoute = multer({ storage: storageRoutes });

const Working_Site = () => {
  app.get("", (req, res) => {
    res.sendFile(__dirnames + "index.html");
  });

  app.get("/autorization", (req, res) => {
    res.sendFile(__dirnames + "autorization.html");
  });
  app.get("/scheduler", (req, res) => {
    res.sendFile(__dirnames + "scheduler.html");
  });
  app.get("/lk", (req, res) => {
    res.sendFile(__dirnames + "lk.html");
  });
  app.get("/registration", (req, res) => {
    res.sendFile(__dirnames + "registration.html");
  });
  app.get("/trek", (req, res) => {
    res.sendFile(__dirnames + "trek.html");
  });

  app.get("/api/get-route-details", async (req, res) => {
    const { id, type } = req.query;

    if (!id || !type) {
      return res.status(400).json({ error: "Не указан ID или тип маршрута" });
    }

    try {
      // Базовая структура ответа
      let routeData = {
        name: "",
        description: "", // Добавили поле для описания
        points: [],
        schedule: [],
        days: 1,
        distance: "0",
        photos: [], // Добавили массив для фото
        equipment: [],
        costs: [],
      };

      if (type === "standard") {
        const route = await Route.findByPk(id, {
          include: [
            {
              model: Route_Point,
              as: "points",
            },
          ],
          order: [
            [{ model: Route_Point, as: "points" }, "Sequence_Number", "ASC"],
          ],
        });

        if (!route) return res.status(404).json({ error: "Маршрут не найден" });

        routeData.name = route.Route_Name;
        routeData.description = route.Route_Description; // Берем описание из стандартного
        routeData.days = route.Route_Duration || "Не указано";
        routeData.distance = route.Route_Length;
        routeData.Route_Days = route.Route_Days
          ? (route.Route_Length / 1000).toFixed(2)
          : "0";

        if (route.points && route.points.length > 0) {
          routeData.points = route.points.map((pt) => {
            const [lat, lng] = pt.Coordinates
              ? pt.Coordinates.split(",").map((s) => parseFloat(s.trim()))
              : [0, 0];
            return { lat, lng, name: pt.Point_Name };
          });
        }
      } else if (type === "custom") {
        const route = await Custum_Route.findByPk(id, {
          include: [
            {
              model: Route_Schedule,
              as: "Route_Schedules",
            },
          ],
        });

        if (!route) return res.status(404).json({ error: "Маршрут не найден" });

        routeData.name = route.Route_Name;
        routeData.description = route.Route_Description;

        // Исправление: Возвращаем полный JSON дней как route_days
        routeData.route_days = route.Route_Days;

        // Исправление: days как количество дней (длина внешнего массива в JSON)
        let numDays = 1;
        if (route.Route_Days) {
          try {
            const parsedDays = JSON.parse(route.Route_Days);
            numDays = Array.isArray(parsedDays) ? parsedDays.length : 1;
          } catch (e) {
            console.error("Ошибка парсинга Route_Days:", e);
          }
        }
        routeData.days = numDays;

        routeData.distance = route.Route_Length
          ? (route.Route_Length / 1000).toFixed(2)
          : "0";

        // !!! Сбор фоток. Фильтр убирает пустые значения (null или пустые строки)
        routeData.photos = [
          route.Photo1,
          route.Photo2,
          route.Photo3,
          route.Photo4,
        ].filter((p) => p && p.trim() !== "");

        try {
          routeData.equipment = route.equipment
            ? JSON.parse(route.equipment)
            : [];
        } catch (e) {
          routeData.equipment = [];
        }
        try {
          routeData.costs = route.costs ? JSON.parse(route.costs) : [];
        } catch (e) {
          routeData.costs = [];
        }

        // Собираем точки WaiPoint1...20
        for (let i = 1; i <= 20; i++) {
          const wpRaw = route[`WaiPoint${i}`];
          if (wpRaw) {
            const [lat, lng] = wpRaw
              .split(",")
              .map((s) => parseFloat(s.trim()));
            // Пытаемся достать имя, если оно сохранено в JSON point_names,
            // но для простоты пока оставляем генерацию имени, т.к. в БД имена точек отдельно не хранятся для каждой WaiPoint
            // (В твоем коде сохранения они пишутся в JSON point_names, но здесь мы берем просто координаты)
            routeData.points.push({ lat, lng, name: `Точка ${i}` });
          }
        }

        // Если есть сохраненные имена точек в JSON
        if (route.point_names) {
          try {
            const pNames = JSON.parse(route.point_names);
            routeData.points.forEach((pt, idx) => {
              if (pNames[idx]) pt.name = pNames[idx];
            });
          } catch (e) {}
        }

        if (route.Route_Schedules && route.Route_Schedules.length > 0) {
          routeData.schedule = route.Route_Schedules.map((sch) => ({
            point_index: sch.Point_Index,
            visit_date: sch.Visit_Date,
            visit_time: sch.Visit_Time,
            note: sch.Note,
          }));
        }
      }

      res.json(routeData);
    } catch (err) {
      console.error("Ошибка при получении деталей маршрута:", err);
      res.status(500).json({ error: "Ошибка сервера" });
    }
  });
};

// РЕГИСТРАЦИЯ
app.post("/registration", async (req, res) => {
  let Finel_hash_Password = null;
  async function hashPassword(password) {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    return hashedPassword;
  }
  Finel_hash_Password = (await hashPassword(req.body["password"])).toString();

  try {
    const existingUser =
      (await Turist.findOne({
        where: { email: req.body["email"] },
      })) ||
      (await Guide.findOne({
        where: { email: req.body["email"] },
      }));

    if (existingUser) {
      return res.status(400).json({
        status: "error",
        message: "Пользователь с такой почтой уже существует",
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

      const token = jwt.sign(
        {
          id: userId,
          role: userRole,
          name: fullName,
          initial: initial,
        },
        SECRET_KEY,
        { expiresIn: "3d" },
      );

      res.cookie("token", token, {
        httpOnly: true,
        maxAge: 3 * 24 * 60 * 60 * 1000,
        sameSite: "strict",
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
      const token = jwt.sign(
        {
          id: Gide.Guide_ID,
          role: "organizer",
          name: fullName,
          initial: initial,
        },
        SECRET_KEY,
        { expiresIn: "3d" },
      );

      res.cookie("token", token, {
        httpOnly: true,
        maxAge: 3 * 24 * 60 * 60 * 1000,
        sameSite: "strict",
      });
    } else {
      return res
        .status(400)
        .json({ status: "error", message: "Неверная роль" });
    }

    res.status(200).json({ status: "ok", role: userRole });
  } catch (err) {
    console.log("Произошла ошибка");
    console.log(err);
    res.status(500).json({ status: "err" });
  }
});

// АВТОРИЗАЦИЯ

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

    const fullName =
      userRole === "admin"
        ? "Администратор"
        : `${user.First_Name} ${user.Last_Name}`;
    const initial =
      userRole === "admin" ? "А" : user.First_Name[0].toUpperCase();

    const token = jwt.sign(
      {
        id:
          userRole === "participant"
            ? user.Tourist_ID
            : userRole === "organizer"
              ? user.Guide_ID
              : user.ID_administrator,
        role: userRole,
        name: fullName,
        initial: initial,
      },
      SECRET_KEY,
      { expiresIn: "3d" },
    );

    res.cookie("token", token, {
      httpOnly: true,
      maxAge: 3 * 24 * 60 * 60 * 1000,
      sameSite: "strict",
    });

    res.json({ status: "ok", role: userRole });
  } catch (err) {
    console.error("Ошибка авторизации:", err);
    res.status(500).json({ message: "Ошибка сервера" });
  }
});
app.post("/logout", (req, res) => {
  res.clearCookie("token");
  (res.status(200), json({ message: "Вы вышли из аккаунта" }));
});

// ПРОВЕРКА АВТОРИЗАЦИИ
app.get("/api/auth-status", (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.json({ isAuthenticated: false });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    res.json({
      isAuthenticated: true,
      user: {
        name: decoded.name,
        role: decoded.role,
        initial: decoded.initial,
      },
    });
  } catch (err) {
    res.json({ isAuthenticated: false });
  }
});

// ПРОВЕРКА НАЛИЧИЯ ГОТОВЫХ МАРШРУТОВ ИЗ БД
app.get("/routes", async (req, res) => {
  try {
    const routes = await Route.findAll({
      attributes: [
        "Route_ID",
        "Route_Name",
        "Route_Description",
        "Route_Length",
        "Route_Duration",
        "Photo1",
        "Photo2",
        "Photo3",
        "Photo4",
      ],
      order: [["Route_ID", "DESC"]],
    });

    const result = routes.map((route) => ({
      Route_ID: route.Route_ID,
      Route_Name: route.Route_Name,
      Route_Description: route.Route_Description,
      Route_Length: route.Route_Length,
      Route_Duration: route.Route_Duration,
      Photo1: route.Photo1 || null,
      Photo2: route.Photo2 || null,
      Photo3: route.Photo3 || null,
      Photo4: route.Photo4 || null,
    }));

    res.json({ routes: result });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Ошибка получения маршрутов" });
  }
});
// ЗАПИСЬ НА ГОТОВЫЙ МАРШРУТ
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
      Trip_Start_Date: date,
    });

    res.json({ status: "ok" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Ошибка записи" });
  }
});

// ВЫВОД ВСЕХ МАРШРУТОВ У АДМИНА
app.get("/api/admin/all-routes", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin")
      return res.status(403).json({ error: "Нет доступа" });

    // 1. Маршруты на сайте (Таблица routes)
    const siteRoutes = await Route.findAll();

    // 2. Предложенные маршруты (Таблица custom_routse со статусом 'pending')
    // Примечание: пока кнопку "Опубликовать" мы не сделали, вы можете вручную в БД поставить status='pending' для теста
    const proposedRoutes = await Custum_Route.findAll({
      where: { status: "pending" },
    });

    // 3. Пользовательские маршруты (Остальные, для статистики или модерации)
    // Можно выводить все, кроме pending, или только private
    const userRoutes = await Custum_Route.findAll({
      where: { status: "private" },
    });

    res.json({
      site: siteRoutes,
      proposed: proposedRoutes,
      custom: userRoutes,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

// ВЫВОД ВСЕХ ГРУПП АДМИНОМ
app.get("/api/admin/all-groups", async (req, res) => {
  try {
    const routes = await Route.findAll({
      include: [
        {
          model: Guide,
          required: false,
          attributes: ["First_Name", "Last_Name", "vk_link", "tg_link"],
        },
      ],
      attributes: ["Route_ID", "Route_Name", "Photo1"],
      order: [["Route_ID", "DESC"]],
    });

    const result = routes.map((r) => {
      const guide = r.Guide;

      return {
        id: r.Route_ID,
        route_name: r.Route_Name,

        route_img: r.Photo1
          ? r.Photo1
          : `https://loremflickr.com/600/200/nature?lock=${r.Route_ID}`,

        guide_name: guide
          ? `${guide.First_Name} ${guide.Last_Name}`
          : "Гид не назначен",

        vk_link: guide?.vk_link || null,
        tg_link: guide?.tg_link || null,
      };
    });

    res.json(result);
  } catch (e) {
    console.error("ADMIN GROUPS ERROR:", e);
    res.status(500).json({ error: "Ошибка загрузки групп" });
  }
});

// УДАЛЕНИЕ МАРШРУТОВ АДМИНОМ
app.delete("/api/admin/delete-site-route", async (req, res) => {
  const token = req.cookies.token;
  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin")
      return res.status(403).json({ error: "Нет доступа" });

    const { id } = req.body;
    await Route.destroy({ where: { Route_ID: id } });

    res.json({ status: "ok" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Ошибка удаления" });
  }
});

// ПРОСМОТР ДАННЫХ ГИДА АДМИНИСТРАТОРОМ
app.get("/api/admin/route-docs/:routeId", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin")
      return res.status(403).json({ error: "Доступ запрещен" });

    const { routeId } = req.params;
    const customRoute = await Custum_Route.findByPk(routeId);
    if (!customRoute)
      return res.status(404).json({ error: "Маршрут не найден" });

    const guide = await Guide.findByPk(customRoute.Guide_ID);
    if (!guide) return res.status(404).json({ error: "Гид не найден" });

    const guideData = {
      login: guide.login,
      First_Name: guide.First_Name,
      Last_Name: guide.Last_Name,
      phone: guide.phone,
      email: guide.email,
      tg_link: guide.tg_link,
      vk_link: guide.vk_link,
      Age: guide.Age,
      role: guide.role,
      experience: guide.experience,
      Guide_License: guide.Guide_License
        ? `http://localhost:${process.env.PORT}${guide.Guide_License}`
        : null,
      cost_org: customRoute.Cost_organization || 0, // Взнос из маршрута
    };

    const photos = [
      customRoute.Photo1,
      customRoute.Photo2,
      customRoute.Photo3,
      customRoute.Photo4,
    ].filter((p) => p);

    res.json({ guideData, photos });
  } catch (err) {
    console.error("Ошибка в /api/admin/route-docs:", err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

// ОПУБЛИКОВАТЬ МАРШРУТ АДМИНОМ (ФИНАЛЬНАЯ ВЕРСИЯ С ПЕРЕНОСОМ ВСЕХ ПОЛЕЙ)
app.post("/api/admin/publish-route", async (req, res) => {
  try {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ message: "Нет авторизации" });

    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin") {
      return res.status(403).json({ message: "Доступ запрещен" });
    }

    const { customRouteId } = req.body;
    if (!customRouteId)
      return res.status(400).json({ message: "ID маршрута не передан" });

    // 1. Получаем исходный кастомный маршрут
    const sourceRoute = await Custum_Route.findByPk(customRouteId);

    if (!sourceRoute) {
      return res.status(404).json({ message: "Маршрут не найден" });
    }

    // 2. Создаем запись в основной таблице routes
    // ВАЖНО: Здесь мы маппим поля из custom_routse в routes
    const newRoute = await Route.create({
      Route_Name: sourceRoute.Route_Name,
      Route_Description: sourceRoute.Route_Description,
      Route_Length: sourceRoute.Route_Length,
      Route_Duration: sourceRoute.Route_Duration,
      Route_Type: "Standard", // Маршрут становится официальным
      Terrain_Type: sourceRoute.Terrain_Type || "Mixed",
      Guide_ID: sourceRoute.Guide_ID,
      Cost_organization: sourceRoute.Cost_organization,

      // --- ПЕРЕНОС НЕДОСТАЮЩИХ ДАННЫХ ---

      // Перенос настроек карты
      Map_Zoom: sourceRoute.Map_Zoom,
      Map_Center: sourceRoute.Map_Center,

      // Перенос количества дней
      Route_Days: sourceRoute.Route_Days,

      // Перенос снаряжения:
      // Записываем JSON из equipment (custom) в Required_Equipment (routes) как просили
      Required_Equipment: sourceRoute.equipment,
      // На всякий случай дублируем в equipment, если логика фронта использует это поле

      // Перенос фотографий
      Photo1: sourceRoute.Photo1,
      Photo2: sourceRoute.Photo2,
      Photo3: sourceRoute.Photo3,
      Photo4: sourceRoute.Photo4,
    });

    const newRouteId = newRoute.Route_ID;

    // 3. Перенос точек из колонок WaiPoint1...20 в таблицу route_point

    // Попытаемся распарсить имена точек, если они сохранены в JSON
    let pointNames = [];
    try {
      if (sourceRoute.point_names) {
        pointNames = JSON.parse(sourceRoute.point_names);
      }
    } catch (e) {
      console.error("Ошибка парсинга имен точек:", e);
    }

    // Массив для bulkCreate
    const pointsToInsert = [];

    for (let i = 1; i <= 20; i++) {
      // Берем значение из колонки WaiPoint1, WaiPoint2 и т.д.
      const coordKey = `WaiPoint${i}`;
      const coordinates = sourceRoute[coordKey];

      // Если координаты есть и они не пустые
      if (coordinates && coordinates.trim() !== "") {
        pointsToInsert.push({
          Route_ID: newRouteId,
          Point_Name: pointNames[i - 1] || `Точка ${i}`, // Берем имя из массива или генерируем
          Description: "",
          Sequence_Number: i, // Порядковый номер
          Coordinates: coordinates,
        });
      }
    }

    // Записываем все точки разом в таблицу route_point
    if (pointsToInsert.length > 0) {
      await Route_Point.bulkCreate(pointsToInsert);
    }

    // 4. Обновляем статус исходного маршрута
    sourceRoute.status = "published";
    await sourceRoute.save();

    res.json({
      message: "Маршрут успешно опубликован и конвертирован!",
      newId: newRouteId,
    });
  } catch (error) {
    console.error("Ошибка публикации:", error);
    res
      .status(500)
      .json({ message: "Ошибка сервера при публикации", error: error.message });
  }
});
// АДМИН ОТВЕРГАЕТ МАРШРУТ ГИДА
app.post("/api/admin/reject-route", async (req, res) => {
  const { routeId, reason } = req.body;

  try {
    await Custum_Route.update(
      {
        status: "rejected",
        rejection_reason: reason,
      },
      {
        where: {
          Route_custom_ID: routeId,
        },
      },
    );

    res.json({ success: true });
  } catch (e) {
    console.error("REJECT ERROR:", e);
    res.status(500).json({ message: e.message });
  }
});

// ПУБЛИКАЦИЯ ГИДОМ МАРШРУТА
app.post("/api/custom-routes/publish/:id", async (req, res) => {
  try {
    const routeId = req.params.id;

    // ВАЖНО: Используем Route_custom_ID, так как это прописано в модели
    const route = await Custum_Route.findOne({
      where: { Route_custom_ID: routeId },
    });

    if (!route) {
      console.log(`Маршрут с ID ${routeId} не найден`);
      return res.status(404).json({ error: "Маршрут не найден" });
    }

    // Обновляем статус
    route.status = "pending";
    await route.save();

    console.log(`Статус маршрута ${routeId} изменен на pending`);
    res.json({ success: true });
  } catch (error) {
    console.error("Ошибка при публикации:", error);
    res.status(500).json({ error: "Ошибка сервера при обновлении статуса" });
  }
});

// ПОЛУЧЕНИЕ ПРОФИЛЯ ИЗ БД
app.get("/api/get-user-profile", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const role = decoded.role;
    const userId = decoded.id;

    let user;
    if (role === "participant") {
      user = await Turist.findByPk(userId);
    } else if (role === "organizer") {
      user = await Guide.findByPk(userId);
    }

    if (!user) return res.status(404).json({ error: "Пользователь не найден" });

    // Возвращаем данные (без пароля!)
    const profileData = {
      First_Name: user.First_Name,
      Last_Name: user.Last_Name,
      email: user.email,
      phone: user.phone || "",
      age: (role === "participant" ? user.age : user.Age) || 0,
      experience: user.experience || "",
    };

    if (role === "participant") profileData.gender = user.gender || "";
    if (role === "organizer") {
      profileData.Guide_License = user.Guide_License || "";
      profileData.link_vk_group = user.vk_link || "";
      profileData.link_tg_group = user.tg_link || "";
    }
    res.json(profileData);
  } catch (err) {
    console.error("Ошибка загрузки профиля:", err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

// ОБНОВЛЕНИЕ ПРОФИЛЯ
app.put(
  "/api/update-user-profile",
  uploadLicense.single("Guide_License"),
  async (req, res) => {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ error: "Не авторизован" });

    try {
      const decoded = jwt.verify(token, SECRET_KEY);
      const role = decoded.role;
      const userId = decoded.id;

      let user;
      if (role === "participant") {
        user = await Turist.findByPk(userId);
      } else if (role === "organizer") {
        user = await Guide.findByPk(userId);
      }

      if (!user)
        return res.status(404).json({ message: "Пользователь не найден" });

      // 1. Обновление текстовых полей
      user.First_Name = req.body.First_Name;
      user.Last_Name = req.body.Last_Name;
      user.phone = req.body.phone;
      user.experience = req.body.experience;

      // Обработка возраста
      if (req.body.age) {
        if (role === "organizer") user.Age = req.body.age;
        else user.age = req.body.age;
      }

      if (role === "participant") {
        user.gender = req.body.gender;
      }

      if (role === "organizer") {
        // ИСПРАВЛЕНО: Записываем пришедшие с фронта данные в правильные колонки БД
        user.vk_link = req.body.link_vk_group;
        user.tg_link = req.body.link_tg_group;
      }

      // 2. Обработка файла лицензии
      if (role === "organizer" && req.file) {
        if (user.Guide_License) {
          const oldPath = path.join(
            __dirnames,
            user.Guide_License.replace(/^\//, ""),
          );
          fs.unlink(oldPath, () => {});
        }

        const relativePath = req.file.path
          .replace(__dirnames, "")
          .replace(/\\/g, "/")
          .replace(/^\/*/, "/");

        user.Guide_License = relativePath;
      }

      await user.save();

      // Генерация нового токена
      const fullName = `${user.First_Name} ${user.Last_Name}`;
      const initial = user.First_Name[0].toUpperCase();

      const newToken = jwt.sign(
        {
          id: userId,
          role: role,
          name: fullName,
          initial: initial,
        },
        SECRET_KEY,
        { expiresIn: "3d" },
      );

      res.cookie("token", newToken, {
        httpOnly: true,
        maxAge: 3 * 24 * 60 * 60 * 1000,
        sameSite: "strict",
      });

      res.json({
        status: "ok",
        user: { name: fullName, initial: initial },
        newLicenseUrl: user.Guide_License,
      });
    } catch (err) {
      console.error("Ошибка при обновлении:", err);
      res.status(500).json({ message: "Ошибка при обновлении профиля" });
    }
  },
);
// ДАННЫЕ ДЛЯ КАРТОЧКИ МАРШРУТА В ЛИЧНОМ КАБИНЕТЕ
app.get("/api/user-routes", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json([]);

  let userId, role;
  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    userId = decoded.id;
    role = decoded.role;
  } catch (err) {
    return res.status(401).json([]);
  }

  try {
    const data = [];

    // Standard маршруты (из Record)
    if (role === "participant") {
      const records = await Record.findAll({ where: { Tourist_ID: userId } });
      for (const record of records) {
        const route = await Route.findByPk(record.Route_ID);
        if (route) {
          data.push({
            bookingId: `standard_${record.Route_ID}`,
            title: route.Route_Name || "Неизвестно",
            date: record.Trip_Start_Date
              ? record.Trip_Start_Date.toISOString().split("T")[0]
              : null,
            duration: route.Route_Duration || "Не указано", // ← унифицировали
            distance: route.Route_Length
              ? (route.Route_Length / 1000).toFixed(2)
              : "0",
            description: route.Route_Description || "",
            type: "standard",
            status: "public",
            photo: route.Photo1 || null,
          });
        }
      }
    }

    // Custom маршруты
    const whereCustom = {};
    if (role === "participant") whereCustom.Tourist_ID = userId;
    else if (role === "organizer") whereCustom.Guide_ID = userId;

    const customs = await Custum_Route.findAll({ where: whereCustom });
    for (const custom of customs) {
      const distKm = custom.Route_Length
        ? (custom.Route_Length / 1000).toFixed(2)
        : "0";

      // Для кастомных используем Route_Duration, если есть, иначе Route_Days
      let duration = custom.Route_Duration || "Не указано";
      if (!custom.Route_Duration && custom.Route_Days) {
        try {
          const parsed = JSON.parse(custom.Route_Days);
          duration = Array.isArray(parsed)
            ? `${parsed.length} дней`
            : custom.Route_Days;
        } catch (e) {
          duration = custom.Route_Days;
        }
      }

      data.push({
        bookingId: `custom_${custom.Route_custom_ID}`,
        title: custom.Route_Name || "Пользовательский маршрут",
        date: null,
        duration: duration, // ← унифицировали
        distance: distKm,
        description: custom.Route_Description || "",
        type: "custom",
        status: custom.status || "private",
        rejection_reason: custom.rejection_reason,
        photo: custom.Photo1 || null,
      });
    }

    res.json(data);
  } catch (err) {
    console.error("Ошибка в /api/user-routes:", err);
    res.status(500).json([]);
  }
});

// СОХРАНЕНИЕ КАСТОМНОГО МАРШРУТА НА SHELDURE.HTML
app.post("/api/save-custom-route", uploadRoute.any(), async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const role = decoded.role;
    const userId = decoded.id;

    if (role === "organizer") {
      const route = await Custum_Route.findByPk(userId);
      if (route && route.status !== "private") {
        let message;
        if (route.status === "pending") {
          message =
            "Ваш маршрут на модерации, его нельзя изменять, подождите ответ от модерации";
        } else if (route.status === "rejected") {
          message =
            "Ваш маршрут отклонён, если вы всё ещё хотите опубликовать маршрут, то создайте новый маршрут и отправьте на модерацию уже его";
        } else {
          message = "Редактирование маршрута запрещено";
        }
        return res.status(403).json({ error: message });
      }
    }

    // Данные приходят в req.body как строки, так как это FormData. Нужно парсить JSON.
    const {
      name,
      description,
      length,
      duration,
      days,
      map_zoom,
      map_center,
      cost_organization,
    } = req.body;

    // Парсим сложные объекты
    const points = JSON.parse(req.body.points || "[]");
    const schedule = JSON.parse(req.body.schedule || "[]");
    const equipment = JSON.parse(req.body.equipment || "[]");
    const costs = JSON.parse(req.body.costs || "[]");

    const routeDataPayload = {
      Route_Name: name || "Без названия",
      Route_Description: description || "",
      Route_Length: parseInt(length) || 0,
      Route_Duration: duration || "",
      Route_Type: "Custom",
      Terrain_Type: "Mixed",
      Route_Days: req.body.Route_Days,
      Map_Zoom: map_zoom || null,
      Map_Center: map_center || null,
      equipment: JSON.stringify(equipment),
      costs: JSON.stringify(costs),
      Cost_organization: parseInt(cost_organization) || 0, // Сохраняем взнос
      point_names: JSON.stringify(
        points.map((p, i) => p.name || `Точка ${i + 1}`),
      ),
    };

    // Обработка фотографий (Photo1 ... Photo4)
    if (req.files && req.files.length > 0) {
      req.files.forEach((file) => {
        const relativePath = file.path
          .replace(__dirnames, "")
          .replace(/\\/g, "/")
          .replace(/^\/*/, "/");

        if (file.fieldname === "photo_0")
          routeDataPayload.Photo1 = relativePath;
        if (file.fieldname === "photo_1")
          routeDataPayload.Photo2 = relativePath;
        if (file.fieldname === "photo_2")
          routeDataPayload.Photo3 = relativePath;
        if (file.fieldname === "photo_3")
          routeDataPayload.Photo4 = relativePath;
      });
    }
    if (role === "participant") {
      routeDataPayload.Tourist_ID = userId;
      routeDataPayload.Guide_ID = null;
    } else if (role === "organizer") {
      routeDataPayload.Guide_ID = userId;
      routeDataPayload.Tourist_ID = null;
    } else {
      return res.status(403).json({ error: "Недопустимая роль" });
    }

    // Заполнение точек WaiPoint
    for (let i = 0; i < 20; i++) {
      const key = `WaiPoint${i + 1}`;
      routeDataPayload[key] = points[i]
        ? `${points[i].lat}, ${points[i].lng}`
        : null;
    }

    // Логика удаления старого и создания нового
    const whereClause = { Route_Name: name };
    if (role === "participant") whereClause.Tourist_ID = userId;
    else if (role === "organizer") whereClause.Guide_ID = userId;

    const existingRoute = await Custum_Route.findOne({ where: whereClause });

    let targetRouteId;
    // Если обновляем существующий, нужно сохранить старые фото, если новые не загружены
    if (existingRoute) {
      if (!routeDataPayload.Photo1)
        routeDataPayload.Photo1 = existingRoute.Photo1;
      if (!routeDataPayload.Photo2)
        routeDataPayload.Photo2 = existingRoute.Photo2;
      if (!routeDataPayload.Photo3)
        routeDataPayload.Photo3 = existingRoute.Photo3;
      if (!routeDataPayload.Photo4)
        routeDataPayload.Photo4 = existingRoute.Photo4;
      await existingRoute.update(routeDataPayload);
      targetRouteId = existingRoute.Route_custom_ID;
    } else {
      const createdRoute = await Custum_Route.create(routeDataPayload);
      targetRouteId = createdRoute.Route_custom_ID;
    }

    // Расписание
    if (schedule.length > 0) {
      const scheduleRecords = schedule.map((item) => ({
        Route_custom_ID: targetRouteId,
        Point_Index: item.point_index,
        Visit_Date: item.visit_date,
        Visit_Time: item.visit_time,
        Note: "Запланировано",
      }));
      await Route_Schedule.bulkCreate(scheduleRecords);
    }

    res.status(200).json({
      status: "ok",
      message: "Маршрут успешно сохранен!",
      route_id: targetRouteId,
    });
  } catch (err) {
    console.error("Ошибка при сохранении:", err);
    res.status(500).json({ error: "Ошибка сохранения маршрута" });
  }
});
// УДАЛЕНИЕ МАРШУРТА ИЗ ЛИЧНОГО КАБИНЕТА
app.delete("/api/delete-route", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const userId = decoded.id; // ID пользователя из токена
    const role = decoded.role;
    const { bookingId } = req.body; // Получаем ID вида "standard_5" или "custom_10"

    if (!bookingId) return res.status(400).json({ error: "Не указан ID" });

    const [type, id] = bookingId.split("_"); // Разделяем тип и ID

    if (type === "standard") {
      // Если это "standard", удаляем БРОНЬ из таблицы Record (trip_request)
      // Удаляем запись, где совпадает ID маршрута И ID туриста
      // (Для организаторов стандартные маршруты не удаляем, т.к. они не бронируют как туристы)
      if (role !== "participant") {
        return res
          .status(403)
          .json({ error: "Доступно только для участников" });
      }
      const deleted = await Record.destroy({
        where: {
          Route_ID: id,
          Tourist_ID: userId,
        },
      });

      if (deleted === 0) {
        return res.status(404).json({ error: "Бронирование не найдено" });
      }
    } else if (type === "custom") {
      // Если это "custom", удаляем сам МАРШРУТ из таблицы Custum_Route
      const whereDelete = { Route_custom_ID: id };
      if (role === "participant") {
        whereDelete.Tourist_ID = userId;
      } else if (role === "organizer") {
        whereDelete.Guide_ID = userId;
      }
      const deleted = await Custum_Route.destroy({
        where: whereDelete,
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

// ПРОКЛАДКА МАРШРУТОВ
app.post("/generate-route", async (req, res) => {
  const { coordinates } = req.body;

  // Валидация входных данных
  if (!coordinates || !Array.isArray(coordinates) || coordinates.length < 2) {
    return res
      .status(400)
      .json({ error: "Для маршрута нужно минимум 2 точки." });
  }

  try {
    const apiKey = process.env.ORS_API_KEY; // Убедись, что ключ есть в .env

    // Формируем радиусы поиска дорог (ставим 2000м, но на бесплатном тарифе лимит ~350м)
    const radiuses = coordinates.map(() => 2000);

    // Используем профиль 'cycling-mountain' для лучшей проходимости в лесах
    const response = await axios.post(
      "https://api.openrouteservice.org/v2/directions/foot-hiking/geojson",
      {
        coordinates: coordinates,
        elevation: true,
        extra_info: ["waytype", "surface", "steepness"],
        radiuses: radiuses,
      },
      {
        headers: {
          Authorization: apiKey,
          "Content-Type": "application/json",
        },
      },
    );

    // Если маршрут пустой или API вернул странный ответ
    if (!response.data.features || response.data.features.length === 0) {
      return res
        .status(422)
        .json({ error: "Маршрут не найден. Нет дорог рядом." });
    }

    const route = response.data.features[0];
    const summary = route.properties.summary;

    // БЕЗОПАСНАЯ СБОРКА ОТВЕТА (защита от крашей toFixed)
    res.json({
      distance: ((summary.distance || 0) / 1000).toFixed(2) + " км",
      duration: ((summary.duration || 0) / 3600).toFixed(2) + " ч", // Время для велика
      ascent: (summary.ascent || 0).toFixed(0) + " м",
      descent: (summary.descent || 0).toFixed(0) + " м",
      geometry: route.geometry,
      // Безопасное извлечение сегментов
      segments: route.properties.segments
        ? route.properties.segments.map((seg, index) => ({
            startToEnd: `Участок ${index + 1}`,
            waytype: seg.extras?.waytype?.summary || "Неизвестно",
            surface: seg.extras?.surface?.summary || "Грунт/Тропа",
            distance: ((seg.distance || 0) / 1000).toFixed(2) + " км",
          }))
        : [],
    });
  } catch (error) {
    // Логирование для отладки
    if (error.response && error.response.data) {
      console.error(
        "Ошибка ORS:",
        JSON.stringify(error.response.data, null, 2),
      );

      // Обработка ошибки "Точка слишком далеко от дороги" (Code 2010)
      if (error.response.data.error?.code === 2010) {
        return res.status(422).json({
          error:
            "Точка слишком далеко от дороги/тропы. Передвиньте метку ближе к путям.",
        });
      }
    } else {
      console.error("Ошибка сервера:", error.message);
    }

    res.status(500).json({ error: "Не удалось построить веломаршрут." });
  }
});

app.get("/api/user-groups", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json([]);

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    const userId = decoded.id;
    const role = decoded.role;

    // Группы показываем только участникам
    if (role !== "participant") {
      return res.json([]);
    }

    const groups = [];

    // 1. Ищем все записи пользователя на маршруты
    const records = await Record.findAll({ where: { Tourist_ID: userId } });

    for (const record of records) {
      // 2. Ищем сам маршрут
      const route = await Route.findByPk(record.Route_ID);

      if (route && route.Guide_ID) {
        // 3. Ищем гида, который ведет этот маршрут
        const guide = await Guide.findByPk(route.Guide_ID);

        if (guide) {
          groups.push({
            id: record.Trip_ID, // ID заявки
            route_name: route.Route_Name,
            route_img_id: route.Route_ID, // Для генерации картинки
            guide_name: `${guide.First_Name} ${guide.Last_Name}`,
            vk_link: guide.vk_link || "",
            tg_link: guide.tg_link || "",
            route_img: route.Photo1
              ? route.Photo1
              : `https://loremflickr.com/600/200/nature?lock=${route.Route_ID}`,
          });
        }
      }
    }

    res.json(groups);
  } catch (err) {
    console.error("Ошибка при получении групп:", err);
    res.status(500).json([]);
  }
});

function startServer() {
  Working_Site();

  const server = app.listen(process.env.PORT, () => {
    console.log(`Сервер запущен на порту ${process.env.PORT}`);
  });

  server.on("error", (err) => {
    console.error("Ошибка при запуске сервера:", err.message);
    console.log("Повторная попытка через 3 секунды...");
    setTimeout(startServer, 3000); // Рекурсивный вызов
  });
}

startServer();
