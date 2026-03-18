const { DataTypes } = require("sequelize");
module.exports = function (sequelize) {
  return sequelize.define(
    "guides",
    {
      Guide_ID: {
        primaryKey: true,
        autoIncrement: true, // Исправлено на autoIncrement
        type: DataTypes.INTEGER,
      },
      login: {
        type: DataTypes.STRING,
      },
      password: {
        type: DataTypes.STRING,
      },
      First_Name: {
        type: DataTypes.STRING,
      },
      Last_Name: {
        type: DataTypes.STRING,
      },
      phone: {
        type: DataTypes.STRING,
      },
      email: {
        type: DataTypes.STRING,
      },
      tg_link: {
        type: DataTypes.STRING,
      },
      vk_link: {
        type: DataTypes.STRING,
      },
      Age: {
        type: DataTypes.INTEGER,
      },
      role: { type: DataTypes.STRING },
      experience: { type: DataTypes.STRING },
      Guide_License: {
        type: DataTypes.STRING,
      },
      email_verified: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
      },
      email_verification_token: {
        type: DataTypes.STRING,
        allowNull: true,
      },
    },
    {
      timestamps: false,
      tableName: "guides",
    },
  );
};
