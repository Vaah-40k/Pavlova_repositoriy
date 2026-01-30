const { DataTypes } = require("sequelize")
module.exports = function (sequelize) {
    return sequelize.define('routes', {
        Route_ID: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
        Route_Name: { type: DataTypes.STRING },
        Route_Description: { type: DataTypes.STRING },
        Route_Length: { type: DataTypes.INTEGER },
        Route_Type: { type: DataTypes.STRING },
        Route_Duration: { type: DataTypes.TIME },
        Terrain_Type: { type: DataTypes.STRING },
        Required_Equipment: { type: DataTypes.STRING },
        Equipment_Cost: { type: DataTypes.INTEGER },
        Cost_organization: { type: DataTypes.INTEGER },
        Guide_ID: { type: DataTypes.INTEGER }
    }, {
        tableName: 'routes',
        timestamps: false
    })
}