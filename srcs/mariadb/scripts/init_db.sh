#!/bin/sh

echo "Creating MariaDB Database..."

DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

chown -R mysql:mysql /var/lib/mysql

mysqld_safe --datadir='/var/lib/mysql' --socket='/run/mysqld/mysqld.sock' --pid-file='/run/mysqld/mysqld.pid' &

while ! mysqladmin ping --socket='/run/mysqld/mysqld.sock' --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Secure the installation (including setting root password, removing anonymous users, disallowing root login remotely)
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${ROOT_PASSWORD}');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;" | mysql --socket='/run/mysqld/mysqld.sock' -uroot -p${ROOT_PASSWORD}

# Keep MariaDB running in the foreground
wait
