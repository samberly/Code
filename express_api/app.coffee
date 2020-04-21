express = require('express')
path = require('path')
logger = require('morgan')
bodyParser = require('body-parser')
express_jwt = require('express-jwt')
jwt_secret = 'this is a bad secret'

routes = require('./routes/index')
auth = require('./routes/auth')
api = require('./routes/api')
default_query_params = require('./routes/default_query_params')
app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(express.static(path.join(__dirname, 'public')))

app.set('x-powered-by', false)

app.all('*', (req, res, next) ->
  res.append('Access-Control-Allow-Origin', '*');
  res.append('Access-Control-Allow-Credentials', 'true');
  res.append('Access-Control-Allow-Methods', 'GET, POST, OPTIONS,DELETE,PUT');
  res.append('Access-Control-Allow-Headers', 'Authorization,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type');
  next();
)

# app.use(express_jwt(secret: jwt_secret).unless(path: ['/register', '/login']))
app.use(default_query_params)
app.use('/', auth)
app.use('/api', api)

app.use (err, req, res, next) ->
  if err.name == 'UnauthorizedError'
    return res.status(401).json(msg: 'UnauthorizedError').end()

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err

# error handlers
#
# development error handler
# will print stacktrace

if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status(err.status || 500)
    res.render('error', {message: err.message, error: err})

app.use (err, req, res, next) ->
  res.status(err.status || 500)
  res.json({error: err.massage})

module.exports = app
