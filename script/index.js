require("dotenv").config({ quiet: true });

// const sequelizee = require("sequelize");
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
const nodemailer = require("nodemailer");
const crypto = require("crypto");

const db = require("./db/indexdb");
const Turist = db.Turist;
const Guide = db.Guide;
const Route = db.Route;
const Record = db.Record;
const Custum_Route = db.Custum_Route;
const Route_Schedule = db.Route_Schedule;
const Route_Point = db.Route_Point;
const Administrator = db.administrator;
const { sequelize } = require("./db/indexdb");
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
  // Если есть req.user (установлен middleware) — используем его
  if (req.user) {
    const userId = req.user.id;
    const role = req.user.role;

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
    } else {
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
    }
  }

  // Запасной вариант: пытаемся достать из токена (для старых мест, где middleware не используется)
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
    } else {
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
    }
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

// Отправка писем на почту
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT,
  secure: false,
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS,
  },
});

async function sendVerificationEmail(email, token, role) {
  const link = `${process.env.BASE_URL}/verify-email?token=${token}`;
  const mailOptions = {
    from: process.env.FROM_EMAIL,
    to: email,
    subject: "Подтверждение email для TrekPlan",
    html: `
      <h2>Добро пожаловать в TrekPlan!</h2>
      <p>Для завершения регистрации, пожалуйста, подтвердите ваш email, перейдя по ссылке:</p>
      <a href="${link}">${link}</a>
      <p>Если вы не регистрировались, просто проигнорируйте это письмо.</p>
    `,
  };
  await transporter.sendMail(mailOptions);
}

async function ensureUser(req, res, next) {
  let token = req.cookies.token;
  let decoded = null;

  // Пробуем проверить существующий токен
  if (token) {
    try {
      decoded = jwt.verify(token, SECRET_KEY);
      req.user = {
        id: decoded.id,
        role: decoded.role,
        name: decoded.name,
        initial: decoded.initial,
      };
      return next();
    } catch (err) {
      // Токен недействителен — игнорируем, создадим гостя
      console.warn("Недействительный токен, создаём гостя");
    }
  }

  // Создаём гостя
  try {
    const newGuest = await Turist.create({
      role: "participant", // все остальные поля будут NULL
    });

    const guestToken = jwt.sign(
      {
        id: newGuest.Tourist_ID,
        role: "participant",
        name: "Гость",
        initial: "Г",
      },
      SECRET_KEY,
      { expiresIn: "3d" },
    );

    res.cookie("token", guestToken, {
      httpOnly: true,
      maxAge: 3 * 24 * 60 * 60 * 1000,
      sameSite: "strict",
    });

    req.user = {
      id: newGuest.Tourist_ID,
      role: "participant",
      name: "Гость",
      initial: "Г",
    };

    console.log(`Middleware: создан гость с ID ${req.user.id}`);
    next();
  } catch (err) {
    console.error("Ошибка создания гостя в middleware:", err);
    res.status(500).json({ error: "Не удалось создать пользователя" });
  }
}

async function isEmailTaken(email, excludeUserId, excludeRole) {
  // Поиск в таблице tourist
  let tourist = await Turist.findOne({ where: { email } });
  if (
    tourist &&
    (excludeRole !== "participant" || tourist.Tourist_ID !== excludeUserId)
  ) {
    return true;
  }
  // Поиск в таблице guides
  let guide = await Guide.findOne({ where: { email } });
  if (
    guide &&
    (excludeRole !== "organizer" || guide.Guide_ID !== excludeUserId)
  ) {
    return true;
  }
  return false;
}

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
  app.get("/lk", ensureUser, (req, res) => {
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
        description: "",
        points: [],
        schedule: [],
        days: 1,
        distance: "0",
        photos: [],
        equipment: [],
        costs: [],
        status: "private",
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
        routeData.description = route.Route_Description;
        routeData.days = route.Route_Duration || "Не указано";
        routeData.distance = route.Route_Length
          ? (route.Route_Length / 1000).toFixed(2)
          : "0";
        routeData.status = "published"; // ✅ для блокировки редактирования

        // --- Фотографии (Photo1-4) ---
        routeData.photos = [
          route.Photo1,
          route.Photo2,
          route.Photo3,
          route.Photo4,
        ].filter((p) => p && p.trim() !== "");

        // --- Снаряжение (Required_Equipment) ---
        try {
          routeData.equipment = route.Required_Equipment
            ? JSON.parse(route.Required_Equipment)
            : [];
        } catch (e) {
          routeData.equipment = [];
        }

        // --- Расходы (для стандартных маршрутов отсутствуют) ---
        routeData.costs = [];

        // --- Дни маршрута (Route_Days) ---
        routeData.route_days = route.Route_Days || null;

        // --- Точки ---
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
        routeData.status = route.status || "private";
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
  try {
    const { firstName, lastName, email, password, role, experience } = req.body;

    // Проверка существующего пользователя
    let existingUser = await Turist.findOne({ where: { email } });
    if (!existingUser) {
      existingUser = await Guide.findOne({ where: { email } });
    }

    // Если пользователь с таким email уже есть и подтверждён
    if (existingUser && existingUser.email_verified) {
      return res.status(400).json({
        status: "error",
        message: "Пользователь с такой почтой уже существует",
      });
    }

    // Хеширование пароля
    const hashedPassword = await bcrypt.hash(password, 10);
    const verificationToken = crypto.randomBytes(32).toString("hex");

    // Если пользователь существует, но не подтверждён — обновляем данные
    if (existingUser && !existingUser.email_verified) {
      await existingUser.update({
        password: hashedPassword,
        First_Name: firstName,
        Last_Name: lastName,
        experience: experience || existingUser.experience,
        email_verification_token: verificationToken,
        email_token_expires: expires,
      });

      await sendVerificationEmail(email, verificationToken, role);
      return res.json({
        status: "ok",
        message: "Данные обновлены. Проверьте почту для подтверждения.",
      });
    }

    // Создание нового пользователя
    let newUser;
    const expires = new Date(Date.now() + 10 * 60 * 1000); // +10 минут

    if (role === "participant") {
      newUser = await Turist.create({
        password: hashedPassword,
        First_Name: firstName,
        Last_Name: lastName,
        email,
        role,
        experience,
        email_verified: false,
        email_verification_token: verificationToken,
        email_token_expires: expires,
      });
    } else if (role === "organizer") {
      newUser = await Guide.create({
        password: hashedPassword,
        First_Name: firstName,
        Last_Name: lastName,
        email,
        role,
        experience,
        email_verified: false,
        email_verification_token: verificationToken,
        email_token_expires: expires,
      });
    } else {
      return res
        .status(400)
        .json({ status: "error", message: "Неверная роль" });
    }

    await sendVerificationEmail(email, verificationToken, role);

    res.status(200).json({
      status: "ok",
      message: "Регистрация успешна. Проверьте почту для подтверждения.",
    });
  } catch (err) {
    console.error("Ошибка регистрации:", err);
    res.status(500).json({ status: "error", message: "Ошибка сервера" });
  }
});
// ПОДТВЕРЖДЕНИЕ ПОЧТЫ
app.get("/verify-email", async (req, res) => {
  const { token } = req.query;
  if (!token) return res.status(400).send("Токен не указан");

  try {
    let user = await Turist.findOne({
      where: { email_verification_token: token },
    });
    let role = "participant";
    if (!user) {
      user = await Guide.findOne({
        where: { email_verification_token: token },
      });
      role = "organizer";
    }

    if (!user)
      return res.status(400).send("Недействительный или устаревший токен");

    // Проверка срока действия
    if (user.email_token_expires && new Date() > user.email_token_expires) {
      // Токен истёк – очищаем запрос на смену email (если был)
      if (user.new_email) {
        user.new_email = null;
        user.email_verification_token = null;
        user.email_token_expires = null;
        await user.save();
      }
      return res
        .status(400)
        .send("Срок действия ссылки истёк. Запросите повторную отправку.");
    }

    if (user.new_email) {
      // Смена email
      user.email = user.new_email;
      user.new_email = null;
      user.email_verified = true;
      user.email_verification_token = null;
      user.email_token_expires = null;
      await user.save();
    } else {
      // Первичная регистрация
      user.email_verified = true;
      user.email_verification_token = null;
      user.email_token_expires = null;
      await user.save();
    }

    // Редирект на личный кабинет с параметром verified=1
    res.redirect("/lk?verified=1");
  } catch (err) {
    console.error("Ошибка подтверждения email:", err);
    res.status(500).send("Ошибка сервера");
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
  res.clearCookie("token", { path: "/" }); // очищаем httpOnly куку
  res.status(200).json({ message: "Вы вышли из аккаунта" });
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
// АДМИН СМОТРИТ ВСЕ ГРУППЫ, КОТОРЫЕ ПРЕДОСТВЛЯЮТ ГИДЫ
app.get("/api/admin/all-guides", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin")
      return res.status(403).json({ error: "Доступ запрещен" });

    const guides = await Guide.findAll({
      attributes: ["Guide_ID", "First_Name", "Last_Name", "vk_link", "tg_link"],
      include: [
        {
          model: Route,
          attributes: ["Photo1"],
          limit: 1, // Первое фото маршрута
        },
      ],
    });

    const formattedGuides = guides.map((guide) => ({
      id: guide.Guide_ID,
      name: `${guide.First_Name} ${guide.Last_Name}`,
      vk_link: guide.vk_link || null,
      tg_link: guide.tg_link || null,
      photo: guide.Routes?.[0]?.Photo1 || null, // Photo1 из первого маршрута
    }));

    res.json(formattedGuides);
  } catch (err) {
    console.error("Ошибка загрузки гидов:", err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

// ОПУБЛИКОВАТЬ МАРШРУТ АДМИНОМ (ФИНАЛЬНАЯ ВЕРСИЯ С ПЕРЕНОСОМ ВСЕХ ПОЛЕЙ)
app.post("/api/admin/publish-route", async (req, res) => {
  const t = await sequelize.transaction();
  try {
    const token = req.cookies.token;
    if (!token) return res.status(401).json({ message: "Нет авторизации" });

    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin") {
      return res.status(403).json({ message: "Доступ запрещен" });
    }

    const { customRouteId } = req.body;
    const sourceRoute = await Custum_Route.findByPk(customRouteId);
    if (!sourceRoute) {
      await t.rollback();
      return res.status(404).json({ message: "Маршрут не найден" });
    }

    if (sourceRoute.status === "published") {
      await t.rollback();
      return res.status(400).json({ message: "Маршрут уже опубликован" });
    }

    // Создаём запись в routes
    const newRoute = await Route.create(
      {
        Route_Name: sourceRoute.Route_Name,
        Route_Description: sourceRoute.Route_Description,
        Route_Length: parseInt(sourceRoute.Route_Length) || 0,
        Route_Duration: sourceRoute.Route_Duration || "",
        Route_Type: "Standard",
        Terrain_Type: sourceRoute.Terrain_Type || "Mixed",
        Guide_ID: sourceRoute.Guide_ID ? parseInt(sourceRoute.Guide_ID) : null,
        Cost_organization: parseInt(sourceRoute.Cost_organization) || 0,
        Map_Zoom: sourceRoute.Map_Zoom ? parseInt(sourceRoute.Map_Zoom) : null,
        Map_Center: sourceRoute.Map_Center || null,
        Route_Days: sourceRoute.Route_Days || null,
        Required_Equipment: sourceRoute.equipment || null,
        Photo1: sourceRoute.Photo1 || null,
        Photo2: sourceRoute.Photo2 || null,
        Photo3: sourceRoute.Photo3 || null,
        Photo4: sourceRoute.Photo4 || null,
      },
      { transaction: t },
    );

    // Перенос точек
    let pointNames = [];
    try {
      pointNames = JSON.parse(sourceRoute.point_names || "[]");
    } catch (e) {}

    const pointsToInsert = [];
    for (let i = 1; i <= 20; i++) {
      const coords = sourceRoute[`WaiPoint${i}`];
      if (coords && coords.trim() !== "") {
        pointsToInsert.push({
          Route_ID: newRoute.Route_ID,
          Point_Name: pointNames[i - 1] || `Точка ${i}`,
          Description: "",
          Sequence_Number: i,
          Coordinates: coords,
        });
      }
    }

    if (pointsToInsert.length > 0) {
      await Route_Point.bulkCreate(pointsToInsert, { transaction: t });
    }

    // Обновляем статус исходного маршрута
    sourceRoute.status = "published";
    await sourceRoute.save({ transaction: t });

    await t.commit();

    res.json({
      message: "Маршрут успешно опубликован и конвертирован!",
      newId: newRoute.Route_ID,
    });
  } catch (error) {
    await t.rollback();
    console.error("Ошибка публикации:", error);
    res.status(500).json({
      message: "Ошибка сервера при публикации",
      error: error.message,
    });
  }
});

app.post("/api/admin/approve-route", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "admin")
      return res.status(403).json({ error: "Доступ запрещен" });

    const { id } = req.body;
    const custom = await Custum_Route.findByPk(id);
    if (!custom || custom.status !== "pending")
      return res
        .status(404)
        .json({ error: "Маршрут не найден или не на модерации" });

    // Создание нового маршрута в routes
    const newRoute = await Route.create({
      Route_Name: custom.Route_Name,
      Route_Description: custom.Route_Description,
      Route_Length: custom.Route_Length,
      Route_Type: custom.Route_Type,
      Route_Duration: custom.Route_Duration,
      Terrain_Type: custom.Terrain_Type,
      Required_Equipment: custom.equipment,
      Equipment_Cost: 0, // Или рассчитайте, если нужно
      Cost_organization: custom.Cost_organization,
      Guide_ID: custom.Guide_ID,
      Map_Zoom: custom.Map_Zoom,
      Map_Center: custom.Map_Center,
      Photo1: custom.Photo1,
      Photo2: custom.Photo2,
      Photo3: custom.Photo3,
      Photo4: custom.Photo4,
      Route_Days: custom.Route_Days,
    });

    // Создание точек в Route_Point
    for (let i = 1; i <= 20; i++) {
      const wp = custom[`WaiPoint${i}`];
      if (wp) {
        await Route_Point.create({
          Route_ID: newRoute.Route_ID,
          Sequence_Number: i,
          Point_Name: `Точка ${i}`,
          Coordinates: wp,
        });
      }
    }

    // Удаление кастомного маршрута после переноса
    await custom.destroy();

    res.json({ status: "ok" });
  } catch (err) {
    console.error("Ошибка при одобрении:", err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

app.post("/api/moderate-route", async (req, res) => {
  // Проверка роли админа...
  const { id, action, reason } = req.body; // action: 'approve' или 'reject'
  const route = await Custum_Route.findByPk(id);
  if (!route) return res.status(404).json({ error: "Маршрут не найден" });
  if (action === "approve") route.status = "published";
  else if (action === "reject") {
    route.status = "rejected";
    route.rejection_reason = reason;
  }
  await route.save();
  res.json({ status: "ok" });
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
      new_email: user.new_email,
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

      const oldEmail = user.email;
      const newEmail = req.body.email;
      let emailChanged = false;
      let verificationToken = null;

      // Проверка смены email
      if (newEmail && newEmail !== oldEmail) {
        const emailTaken = await isEmailTaken(newEmail, userId, role);
        if (emailTaken) {
          return res.status(400).json({
            message: "Этот email уже используется другим пользователем",
          });
        }

        emailChanged = true;
        verificationToken = crypto.randomBytes(32).toString("hex");
        user.new_email = newEmail;
        user.email_verification_token = verificationToken;
        // email_verified не меняем
      }

      // Обновление остальных полей
      user.First_Name = req.body.First_Name || user.First_Name;
      user.Last_Name = req.body.Last_Name || user.Last_Name;
      user.phone = req.body.phone || user.phone;
      user.experience = req.body.experience || user.experience;

      if (req.body.age) {
        if (role === "organizer") user.Age = req.body.age;
        else user.age = req.body.age;
      }

      if (role === "participant") {
        user.gender = req.body.gender || user.gender;
      }

      if (role === "organizer") {
        user.vk_link = req.body.link_vk_group || user.vk_link;
        user.tg_link = req.body.link_tg_group || user.tg_link;
      }

      // Обработка файла лицензии
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

      // Если email изменён, отправляем письмо
      if (emailChanged) {
        const expires = new Date(Date.now() + 10 * 60 * 1000);
        user.new_email = newEmail;
        user.email_verification_token = verificationToken;
        user.email_token_expires = expires;

        await sendVerificationEmail(newEmail, verificationToken, role);
        // Генерируем новый токен сессии (имя/фамилия могли измениться)
        const fullName = `${user.First_Name} ${user.Last_Name}`;
        const initial = user.First_Name
          ? user.First_Name[0].toUpperCase()
          : "?";
        const newToken = jwt.sign(
          { id: userId, role, name: fullName, initial },
          SECRET_KEY,
          { expiresIn: "3d" },
        );
        res.cookie("token", newToken, {
          httpOnly: true,
          maxAge: 3 * 24 * 60 * 60 * 1000,
          sameSite: "strict",
        });
        return res.json({
          status: "email_pending",
          message:
            "На новый адрес отправлено письмо с подтверждением. После подтверждения email будет изменён.",
          user: { name: fullName, initial },
          newLicenseUrl: user.Guide_License,
        });
      } else {
        // Без смены email – просто обновляем токен
        const fullName = `${user.First_Name} ${user.Last_Name}`;
        const initial = user.First_Name
          ? user.First_Name[0].toUpperCase()
          : "?";
        const newToken = jwt.sign(
          { id: userId, role, name: fullName, initial },
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
          user: { name: fullName, initial },
          newLicenseUrl: user.Guide_License,
        });
      }
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
            status: "approved",
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
        duration: duration,
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
// Фрагмент для index.js: Добавьте новый endpoint для публикации маршрута гидом
app.post("/api/publish-route", async (req, res) => {
  const token = req.cookies.token;
  if (!token) return res.status(401).json({ error: "Не авторизован" });

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    if (decoded.role !== "organizer")
      return res.status(403).json({ error: "Доступ запрещен" });

    const { id } = req.body;
    const custom = await Custum_Route.findByPk(id);
    if (!custom || custom.Guide_ID !== decoded.id)
      return res.status(404).json({ error: "Маршрут не найден" });

    custom.status = "pending";
    await custom.save();

    res.json({ status: "ok" });
  } catch (err) {
    console.error("Ошибка при публикации:", err);
    res.status(500).json({ error: "Ошибка сервера" });
  }
});

// СОХРАНЕНИЕ КАСТОМНОГО МАРШРУТА НА SHELDURE.HTML
app.post(
  "/api/save-custom-route",
  ensureUser,
  uploadRoute.any(),
  async (req, res) => {
    try {
      const userId = req.user.id;
      const role = req.user.role;

      // Данные приходят в req.body как строки (FormData)
      const {
        name,
        description,
        length,
        duration,
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
        Cost_organization: parseInt(cost_organization) || 0,
        point_names: JSON.stringify(
          points.map((p, i) => p.name || `Точка ${i + 1}`),
        ),
      };

      // Обработка фотографий
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

      // Привязка к пользователю
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

      // Поиск существующего маршрута (для обновления)
      const whereClause = { Route_Name: name };
      if (role === "participant") whereClause.Tourist_ID = userId;
      else if (role === "organizer") whereClause.Guide_ID = userId;

      const existingRoute = await Custum_Route.findOne({ where: whereClause });

      if (existingRoute) {
        if (existingRoute.status !== "private") {
          return res.status(403).json({
            error: "Редактирование маршрута запрещено из-за его статуса.",
          });
        }
      }

      let targetRouteId;
      if (existingRoute) {
        // Сохраняем старые фото, если новые не загружены
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
  },
);

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
