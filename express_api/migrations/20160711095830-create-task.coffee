'use strict'
module.exports =
  up: (queryInterface, Sequelize) ->
    queryInterface.createTable 'tasks',
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER
      title: type: Sequelize.STRING
      desc: type: Sequelize.STRING
      done: type: Sequelize.BOOLEAN, defaultValue: false
      createdAt:
        allowNull: false
        type: Sequelize.DATE
      updatedAt:
        allowNull: false
        type: Sequelize.DATE
  down: (queryInterface, Sequelize) ->
    queryInterface.dropTable 'Tasks'
