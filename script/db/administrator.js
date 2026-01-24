const { DataTypes } = require("sequelize");
module.exports = function (sequelize) {
    return sequelize.define("route_schedule", {
        ID_administrator: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER
        },
        email: {
            type: DataTypes.STRING,
        },
        password: {
            type: DataTypes.STRING,
        }

    }, {
        timestamps: false,
        tableName: 'administrator'
    });
};