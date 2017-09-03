#!/bin/bash
set -e
shopt -s extglob

if ! [ -e user/config/system.yaml ]; then
  rsync -a /tmp/gravuser/ /var/www/html/user
fi
chown -R www-data:www-data /var/www/html/user

exec "$@"
