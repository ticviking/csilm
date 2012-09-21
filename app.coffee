
###
Module dependencies.
###

express = require('express')
routes = require('./routes')
http = require('http')
fs = require('fs')
path = require('path');

app = express();

#set up configs

app.locals
  nav:
    home: '/',
    ilms: [ 
      { 
        name:"demo"
        url:"/demo"
      },
      { 
        name:"scarf"
        url:"/scarf"
      }
      ]
console.log app.locals

app.configure ->
  app.set 'port', process.env.PORT || 3000 
  app.set 'views', __dirname + '/views' 
  app.set 'view engine', 'jade' 
  app.use express.favicon() 
  app.use express.logger('dev') 
  app.use express.bodyParser() 
  app.use express.methodOverride()
  app.use app.router 
  app.use express.static path.join(__dirname, 'public')


app.configure('development', ->
  app.use(express.errorHandler());
)
routes app 

http.createServer(app).listen(app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'));
)