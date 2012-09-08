VPATH = .:routes

# Delete the default C/C++ suffixes
.SUFFIXES: 
.SUFFIXES: .coffee .js 


*.js: *.coffee
	coffee -c $< 

routes: routes/*.coffee
	coffee -c $?

less: ./public/less
	./node_modules/.bin/lessc -x public/less/style.less public/css/style.css

run: app.js routes
	npm start

