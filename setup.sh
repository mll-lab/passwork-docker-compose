#!/bin/sh
set -Eeuxo pipefail

# Copy the example config file of the main application
cat site/app/config/config.example.ini | sed s/localhost:27017/mongo:27017/g > site/app/config/config.ini

# Initialize mongo with the latest prepared dump
cp -r site/dump/ data/mongo/dump

# Start up the stack
docker-compose up -d

docker-compose exec mongo mongorestore /server/data/dump
