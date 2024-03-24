#!/bin/bash

# Ensure MariaDB is initialized before starting the service
if [ ! -d "/var/lib/mysql/mysql" ]; then
   mysql_install_db
   service mysql start
   mysql < /docker-entrypoint-initdb.d/init_db.sql
   service mysql stop
fi

# Start MariaDB in the foreground
exec "$@"
