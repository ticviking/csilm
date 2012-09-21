
###
 GET home page.
###

module.exports = (app) ->
  app.get '/', (req, res) ->
    res.render 'index', { title: 'Gameful CSILM' }
  app.get '/demo', (req, res) ->
      res.render 'demo', {
        title: 'Demo CSILM'
      }

