// модель для точек пользовательского маршрута

const { DataTypes } = require("sequelize");
module.exports = function (sequelize) {
    return sequelize.define("route_schedule", {
        Schedule_ID: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER
        },
        // Связь с основной таблицей маршрута
        Route_custom_ID: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        // Индекс метки (от 1 до 20), чтобы знать, к какой WaiPoint привязываемся
        Point_Index: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        // Дата посещения
        Visit_Date: {
            type: DataTypes.DATE, // Хранит только дату (ГГГГ-ММ-ДД)
            allowNull: false
        },
        // Время посещения
        Visit_Time: {
            type: DataTypes.TIME, // Хранит только время (ЧЧ:ММ:СС)
            allowNull: false
        },
        // Дополнительный комментарий к этой точке на этот день
        Note: {
            type: DataTypes.STRING,
            allowNull: true
        }
    }, {
        timestamps: false,
        tableName: 'route_schedule'
    });
};