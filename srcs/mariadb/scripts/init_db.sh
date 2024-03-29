#!/bin/sh

echo "Creating MariaDB Database..."

# Ensure the environment variables are passed correctly
DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# Initialize the data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background with a custom socket and pid file to avoid conflicts
mysqld_safe --datadir='/var/lib/mysql' --socket='/run/mysqld/mysqld.sock' --pid-file='/run/mysqld/mysqld.pid' &

# Wait for MariaDB to start up
while ! mysqladmin ping --socket='/run/mysqld/mysqld.sock' --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Secure the installation (including setting root password, removing anonymous users, disallowing root login remotely)
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${ROOT_PASSWORD}');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;" | mysql --socket='/run/mysqld/mysqld.sock' -u root

# Create the user and database
echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;" | mysql --socket='/run/mysqld/mysqld.sock' -u root

# Keep MariaDB running in the foreground
wait