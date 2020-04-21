DEFULAT_LIMIT = 20
DEFULAT_OFFSET = 0

default_query_params = (req, res, next) ->
  query = req.query

  if query.limit == undefined
    query.limit = DEFULAT_LIMIT

  if query.offset == undefined
    query.offset = DEFULAT_OFFSET

  limit = parseInt(query.limit)
  offset = parseInt(query.offset)

  limit = switch
    when limit == NaN then DEFULAT_LIMIT
    when limit > DEFULAT_LIMIT then DEFULAT_LIMIT
    when limit <= 0 then DEFULAT_LIMIT
    else limit

  offset = switch
    when offset == NaN then DEFULAT_OFFSET
    when offset > DEFULAT_OFFSET then DEFULAT_OFFSET
    when offset < 0 then DEFULAT_OFFSET
    else offset

  query.limit = limit
  query.offset = offset
  next()

module.exports = default_query_params
