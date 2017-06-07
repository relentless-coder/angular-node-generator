#!/bin/bash
#Run this script whenever you want to start a project
read -p "You folder name:" folderName

mkdir $folderName

cd $folderName

yarn init

echo "Installing dependencies: express\nangular\nangular-ui-router\nng-file-upload\nngstorage\nbody-parser\nsanitize-html\nbcrypt-nodejs\nexpress-session\nmongoose\nmulter\npassport\npassport-local\npassport-local-mongoose\ncrypto" 

yarn add express angular angular-ui-router ng-file-upload ngstorage body-parser sanitize-html bcrypt-nodejs express-session mongoose multer passport passport-local passport-local-mongoose crypto --save 

echo "Installing dev dependcies: mocha\nchai\nchai-http\nbabel-core\ncss-loade\nsass-loader\nstyle-loader\nextract-text-webpack-plugin\nbabel-preset-es2015\nbabel-preset-stage-2\nbabel-loader\nbabel-register\nnode-sass\nmorgan webpack"

yarn add mocha chai chai-http babel-core css-loader sass-loader style-loader extract-text-webpack-plugin babel-preset-es2015 babel-preset-stage-2 babel-loader babel-register node-sass morgan webpack --dev 


mkdir client server client/dist client/src client/src/app client/src/app/common client/src/app

mkdir server/models server/routes server/test

touch server/models/dummy.model.js server/routes/dummy.route.js server/test/dummy.spec.js server/test/testHelper.js

touch webpack.config.js

echo "const path = require('path');
const webpack = require('webpack');
const extractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
    entry: {
        app: './client/src/app/root.module.js',
        vendor: 'angular'
    },
    module: {
        loaders: [{
            test: path.join(__dirname, '/client', '/src', '/app'),
            loader: 'babel-loader'
        },
        {
            test: /\.scss$/,
            exclude: /node_modules/,
            loader: extractTextPlugin.extract({fallback: 'style-loader', use: [{loader: 'css-loader'}, {loader: 'sass-loader'}]}) 

        }]
    },
    output: {
        filename: 'js/[name].js',
        path: path.join(__dirname, '/client', '/dist')
    },
    plugins: [
       new webpack.optimize.CommonsChunkPlugin({name: 'vendor'}),
       new extractTextPlugin("css/styles.css")
    ]
};" >> webpack.config.js

echo "
import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const dummySchema = new Schema({
	
	name: String,
	age: Number,
	email: String

})

export default mongoose.model('Dummy', dummySchema)" >> server/models/dummy.model.js

json -I -f package.json -e 'this.scripts = {
"build-js": "webpack --config webpack.config.js",
"test": "node node_modules/.bin/mocha --require ./server/test/testHelper.js ./server/test  --repoert spec --compilers js:babel-core/register",
"start": "npm run build-js && babel-node app.js --presets es2015,stage-2"
}'


echo "// DO NOT DELETE THIS FILE.
require('babel-core/register')({
  ignore: /node_modules\/(?!ProjectB)/
});" >> ./server/test/testHelper.js

touch .babelrc

echo "{
	"presets": ["es2015"]
}" >> .babelrc

touch app.js

echo "import express from 'express';
 const app = express();
 app.listen(process.env.PORT, process.env.IP, ()=>{
 console.log(`Express server started`);
})" >> app.js


export process.env.PORT=6655

export process.env.IP='localhost'

npm start
