#!/bin/sh

# Initialize MariaDB Data Directory
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB
/usr/bin/mysqld_safe --datadir='/var/lib/mysql' &
pid="$!"

# Wait for MariaDB to start
sleep 10

# Secure MariaDB
mysql_secure_installation <<EOF

y
${MYSQL_ROOT_PASSWORD}
${MYSQL_ROOT_PASSWORD}
y
y
y
y
EOF

# Create a database and user
if [ -n "${MYSQL_DATABASE}" ]; then
    echo "Creating database: ${MYSQL_DATABASE}"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
fi

if [ -n "${MYSQL_USER}" ] && [ -n "${MYSQL_PASSWORD}" ]; then
    echo "Creating user: ${MYSQL_USER}"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; FLUSH PRIVILEGES;"
fi

# Keep MariaDB running in the foreground
wait
