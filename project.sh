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
mkdir client server
touch app.js
echo "Hello world" >> app.js
mkdir server/models server/routes server/test
mkdir client/dist
mkdir client/src
mkdir client/src/app
node app.js
