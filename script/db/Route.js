const { DataTypes } = require("sequelize");
module.exports = function (sequelize) {
  return sequelize.define(
    "routes",
    {
      Route_ID: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      Route_Name: { type: DataTypes.STRING },
      Route_Description: { type: DataTypes.STRING },
      Route_Length: { type: DataTypes.INTEGER },
      Route_Type: { type: DataTypes.STRING },
      Route_Duration: { type: DataTypes.STRING },
      Terrain_Type: { type: DataTypes.STRING },
      Required_Equipment: { type: DataTypes.STRING },
      Equipment_Cost: { type: DataTypes.INTEGER },
      Cost_organization: { type: DataTypes.INTEGER },
      Guide_ID: { type: DataTypes.INTEGER },
      Map_Zoom: { type: DataTypes.INTEGER },
      Map_Center: { type: DataTypes.STRING },
      Photo1: { type: DataTypes.STRING },
      Photo2: { type: DataTypes.STRING },
      Photo3: { type: DataTypes.STRING },
      Photo4: { type: DataTypes.STRING },
      Route_Days: { type: DataTypes.TEXT },
      point_names: {
        type: DataTypes.TEXT,
        allowNull: true,
      },
    },
    {
      tableName: "routes",
      timestamps: false,
    },
  );
};
