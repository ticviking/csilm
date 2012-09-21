VPATH = .:routes

# Delete the default C/C++ suffixes
.SUFFIXES: 
.SUFFIXES: .coffee .js 


run: app.js routes less client
	npm start

*.js: *.coffee
	coffee -c $< 

routes: routes/*.coffee
	coffee -c $?

.PHONY: client
client:
	coffee -c -o client/lib/ client/src

less: ./public/less/*.less ./public/less/bootstrap
	./node_modules/.bin/lessc -x public/less/style.less public/css/style.css



