#!/bin/sh

# Copy the example config file of the main application
cat sites/prod/app/config/config.example.ini | sed s/localhost:27017/mongo:27017/g > sites/prod/app/config/config.ini

# Start up the stack
docker-compose up -d

# Initialize mongo with the latest prepared dump
cp -r sites/prod/dump/ data/mongo/dump
docker-compose exec mongo mongorestore /server/data/dump
