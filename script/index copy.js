const db = require("./db/indexdb");
const Turist = db.Turist;
const Guide = db.Guide;
const Route = db.Route;
const Record = db.Record;
const Custum_Route = db.Custum_Route;
const Route_Schedule = db.Route_Schedule;
const Route_Point = db.Route_Point;
const Administrator = db.administrator;

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
