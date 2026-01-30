// точки готовых маршрутов

const { DataTypes } = require("sequelize");

module.exports = function (sequelize) {
    return sequelize.define("route_points", {
        Point_ID: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER
        },
        // Внешний ключ для связи с Route
        Route_ID: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        Point_Name: {
            type: DataTypes.STRING,
            allowNull: false
        },
        Description: {
            type: DataTypes.TEXT, // Для подробного описания места
            allowNull: true
        },
        Coordinates: {  // Добавляем поле для координат (формат: "lat,lng")
            type: DataTypes.STRING,
            allowNull: false
        },
        // Порядковый номер (чтобы знать, какая точка первая, какая вторая)
        Sequence_Number: {
            type: DataTypes.INTEGER,
            allowNull: false
        }
    }, {
        timestamps: false,
        tableName: 'route_point'
    });
};