# Nodejs and Express.js

## Typical node js structure

```
- my-application
  - LICENSE
  - README.md
  - package.json
  - app.js
  - public (directory)
  - tests (directory)
  - config (directory)
  - routes (directory)
  - services (directory)
  - db (directory)
  - core (directory)
```

packages.json => have the dependencies required for nodejs application
app.js => starting point for nodjs to run
public => would have html files and client side codes.

```js
app.js

const express = require('express')
const app = express()

app.get('/products', (req,res) => 
          res.send(getProductList()))
          
app.use(express.static(path.join(__dirname, 'public')));

app.listen(3000);
```

```json
package.json

{
  "name": "test-project",
  "version": "1.0.0",
  "description": "A Vue.js project",
  "main": "src/main.js",
  "private": true,
  "scripts": {
    "dev": "webpack-dev-server --inline --progress --config build/webpack.dev.conf.js",
    "start": "NODE_ENV=production node app.js"
    "start:dev": "NODE_ENV=dev node app.js"
    "unit": "jest --config test/unit/jest.conf.js --coverage",
    "test": "npm run unit",
    "lint": "eslint --ext .js,.vue src test/unit",
    "build": "node build/build.js"
  },
  "dependencies": {
    "vue": "^2.5.2"
  },
  "devDependencies": {
    "autoprefixer": "^7.1.2",
    "babel-core": "^6.22.1",
    "babel-eslint": "^8.2.1",
    "babel-helper-vue-jsx-merge-props": "^2.0.3"    
  },
  "engines": {
    "node": ">= 6.0.0",
    "npm": ">= 3.0.0"
  },
  "browserslist": ["> 1%", "last 2 versions", "not ie <= 8"]
}

```

```bash
npm install  # install all the dependencies
node app.js   # run the application
npm run start  # run the aplication using npm (it will runs the start command in scripts section in package.json )
npm run start:dev  # run the aplication using npm (it will runs the start:dev command in scripts section in package.json )
```

Can view the application from http://localhost:3000  here 3000 is the port.

Other tools :

* supervisord
* forever
* pm2

## PM2: Process Manager 2

```bash
pm2 start app.js
pm2 start app.js -i 4 # with 4 workers
```
