VPATH = .:routes

# Delete the default C/C++ suffixes
.SUFFIXES: 
.SUFFIXES: .coffee .js 

run: app.js routes less
	npm start

*.js: *.coffee
	coffee -c $< 

routes: routes/*.coffee
	coffee -c $?

less: ./public/less/*.less ./public/less/bootstrap
	./node_modules/.bin/lessc -x public/less/style.less public/css/style.css



