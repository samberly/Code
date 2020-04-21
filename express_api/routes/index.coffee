express = require('express');
router = express.Router();

router.get '/', (req, res, next)->
  res.json({api: 'root'})

module.exports = router
