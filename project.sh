#!/bin/bash
#Run this script whenever you want to start a project
mkdir newProject
cd newProject
yarn init
read -p "Your core dependencies, type them out with a single space between two " core_dependencies
read -p "Your dev dependencies, type them out with a single space between two " dev_dependencies
echo $core_dependencies
echo $dev_dependencies
yarn add $core_dependencies --save
yarn add $dev_dependencies --dev
echo "
,{
	"test": "node node_modules/.bin/mocha --reporter spec --require ./server/test/testHelper.js --timeout 10000 --compilers js:babel-core/register",
	"start": "babel-node app.js --presets es2015,stage-2"
}
" >> package.json
touch server/test/testHelper.js
echo "require('babel-core/register')({
  ignore: /node_modules\/(?!ProjectB)/
});" >> server/test/testHelper.js
touch .babelrc
echo "{
	"presets": ["es2015"]
}" >> .babelrc
mkdir client server
touch app.js
echo "import express from 'express'
 const app = express();
 app.listen(process.env.PORT, process.env.IP, ()=>{
 console.log(`Express server started`);
})" >> app.js
mkdir server/models server/routes server/test
mkdir client/dist
mkdir client/src
mkdir client/src/app
process.env.PORT=6655
process.env.IP='localhost'
npm start
