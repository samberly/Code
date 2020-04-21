'use strict'

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define('User', {
    username: DataTypes.STRING
    password: DataTypes.STRING
    createdAt: DataTypes.DATE
    updatedAt: DataTypes.DATE
  }, classMethods: associate: (models) ->
    # associations can be defined here
    return
  )
  User
