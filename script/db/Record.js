const { DataTypes } = require("sequelize")
module.exports = function (sequelize) {
    return sequelize.define('trip_request', {
        Trip_ID: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
        Tourist_ID: { type: DataTypes.INTEGER },
        Route_ID: { type: DataTypes.INTEGER },
        Guide_ID: { type: DataTypes.INTEGER },
        Trip_Start_Date: { type: DataTypes.DATE },
        Trip_End_Date: { type: DataTypes.DATE },
    }, {
        tableName: 'trip_request',
        timestamps: false
    });
}