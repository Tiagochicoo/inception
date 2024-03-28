#!/bin/sh

echo "Creating MariaDB Database..."

# Ensure the environment variables are passed correctly
DB_NAME=${MYSQL_DATABASE:-wordpress}
DB_USER=${MYSQL_USER:-tpereira}
DB_PASSWORD=${MYSQL_PASSWORD:-abc123$$}

# Initialize the data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background with a custom socket and pid file to avoid conflicts
mysqld_safe --datadir='/var/lib/mysql' --socket='/run/mysqld/mysqld.sock' --pid-file='/run/mysqld/mysqld.pid' &

# Wait for MariaDB to start up
while ! mysqladmin ping --socket='/run/mysqld/mysqld.sock' --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Create the user and database
echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;" | mysql --socket='/run/mysqld/mysqld.sock' -u root

# Keep MariaDB running in the foreground
wait