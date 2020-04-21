'use strict'

module.exports = (sequelize, DataTypes) ->
  Task = sequelize.define('Task', {
    title:
      type: DataTypes.STRING
      validate:
        notEmpty: true
    desc: DataTypes.STRING
    done: DataTypes.BOOLEAN
    createdAt: DataTypes.DATE
    updatedAt: DataTypes.DATE
  },
    tableName: 'tasks',
    classMethods: associate: (models) ->
      # associations can be defined here
      return
  )
  Task
