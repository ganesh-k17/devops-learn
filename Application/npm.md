# Node Package Manager (npm)

install node js for linux:

```bash
curl -sL https://rpm.nodesource.com/setup_13.x | bash -  # add the repository for node js 

yum install nodejs # install node js

node -V  # to check version

node add.js  # to run the code in the file add.js
```

## NPM

* it's a package manager for node js
* supports large number of packages and libraries
* This could be packages to work with Files, Webservers, Databases, Security, etc.
* Allows developer to develop new reusable packages and share it with public repository for others to use.
* npm gets installed automatically while install node js.


## Build in modules Samples:

### Modules installe by default while installing node js

* fs => To handle filesystem
* http => To host an HTTP server
* os => To work with the Operating system
* events => To handle events
* tls => To implement TLS and SSL
* url => To Parse URL strings

## External modules:

### Modules installed manually as per our needs.

* express => fast, unopinionated, minimalist web framework
* react => To create user interfaces
* debug => To debug applications
* async => To work with asynchronous JS
* lodash => To work with arrays, objects, strings, etc.

```bash
npm -v # to check npm version

npm search file # to search for the package here file is package name

npm install file # install package eg: file (package will get installed under node_modules folder with the name of the package under this folder.  package.json - contains meta data for the package) - this will create the package for the application means in the current directory.

node -e "console.log(module.paths)"  # list of path node look at for the packages. ['/app/node_modules','/node_modules']

npm install file -g # to install package (eg:file) globally

ls /usr/lib/node_modules/npm/node_modules # to list the built in modules.

ls /usr/lib/node_modules # to list the external modules installed
```


Application dependencies:

* Application has packages and some scripts depends on it.  They are listed in package.json


```json
{
  "name": "GeeksForGeeks",
  "version": "1.0.0",
  "description": "GeeksForGeeks",
  "dependencies": {
    "body-parser": "^1.17.1",
    "express": "^4.15.2",
    "express-validator": "^3.1.2",
    "mongoose": "^4.8.7",
    "nodemon": "^1.14.12",
  }
}
```

To clone an application from github 

```bash
cd /home/thor/; git clone https://github.com/contentful/the-example-app.nodejs
```