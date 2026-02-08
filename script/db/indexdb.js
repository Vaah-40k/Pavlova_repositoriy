const Sequelize = require("sequelize");
const sequelize = new Sequelize("travel_site_oktagon", "root", "", {
  dialect: "mysql",
  host: "localhost",
  logging: false,
});

const Turist = require("./Turist")(sequelize);
const Guide = require("./Guide")(sequelize);
const Route = require("./Route")(sequelize);
const Record = require("./Record")(sequelize);
const Custum_Route = require("./Custom_Route")(sequelize);
const Route_Schedule = require("./Route_Schedule")(sequelize);
const Route_Point = require("./Route_Point")(sequelize);
const administrator = require("./administrator")(sequelize);

Custum_Route.hasMany(Route_Schedule, {
  foreignKey: "Route_custom_ID",
  as: "Route_Schedules",
});
Route_Schedule.belongsTo(Custum_Route, { foreignKey: "Route_custom_ID" });

Route.hasMany(Route_Point, { foreignKey: "Route_ID", as: "points" });
Route_Point.belongsTo(Route, { foreignKey: "Route_ID" });
Route.belongsTo(Guide, { foreignKey: "Guide_ID" });
Guide.hasMany(Route, { foreignKey: "Guide_ID" });

sequelize
  .sync({ alter: true })
  .then(() => console.log("Database schema synced successfully"))
  .catch((err) => console.error("Error syncing schema:", err));

module.exports = {
  sequelize,
  Turist,
  Guide,
  Route,
  Record,
  Custum_Route,
  Route_Schedule,
  Route_Point,
  administrator,
};
