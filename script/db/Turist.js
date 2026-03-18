const { DataTypes } = require("sequelize");
module.exports = function (sequelize) {
  return sequelize.define(
    "tourist",
    {
      Tourist_ID: {
        primaryKey: true,
        autoIncrement: true,
        type: DataTypes.INTEGER,
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
      gender: {
        type: DataTypes.STRING,
      },
      age: {
        type: DataTypes.INTEGER,
      },
      role: {
        type: DataTypes.STRING,
      },
      experience: {
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
      new_email: { type: DataTypes.STRING, allowNull: true },
      email_token_expires: { type: DataTypes.DATE, allowNull: true },
    },
    {
      timestamps: false,
      tableName: "tourist",
    },
  );
};
