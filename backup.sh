#!/bin/sh
set -Eeuxo pipefail

docker-compose exec -T mongo mongodump -o /server/backup/passwork-$(date +"%Y-%m-%d")
