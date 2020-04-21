express = require('express')
router = express.Router()
models = require('../models')

router.get '/tasks', (req, res, next) ->
  models.Task.findAll({order: 'createdAt DESC', limit: req.query.limit, offset: req.query.offset}).then (tasks) ->
      res.json tasks || []

router.get '/tasks/:id', (req, res, next) ->
  models.Task.findById(req.params.id)
  .then (task) ->
    res.json task || {}
  .catch (err) ->
    res.status = 404
    res.json(msg: 'task does not exist')

router.post '/tasks', (req, res, next) ->
  models.Task.create(req.body)
  .then (created_obj) ->
    res.json created_obj
  .catch (err) ->
    res.status = 400
    res.json(msg: err)

router.delete '/tasks/:id', (req, res, next) ->
  models.Task.destroy(where: {id: req.params.id})
  .then (deleted_obj) ->
    res.json {id: req.params.id}

router.put '/tasks/:id', (req, res, next) ->
  models.Task.findById(req.params.id)
  .then (task) ->
    task.done = true
    task.save()
      .then ->
        return res.json(task)
      .catch (err) ->
        res.status = 400
        return res.json(msg: 'can not complete task')
  .catch (err) ->
    res.status = 404
    res.json(msg: 'task does not exist')

module.exports = router;
