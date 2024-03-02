#!/bin/sh

# Give ownership of the mysql directory to the mysql user
chown -R mysql:mysql /var/lib/mysql

# Initialize the database if it hasn't been initialized yet
if [ ! -d "/var/lib/mysql/mysql" ]; then

    # Initialize the MariaDB data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MariaDB with a temporary bootstrap configuration
    /usr/bin/mysqld_safe --datadir='/var/lib/mysql' --user=mysql --bootstrap --skip-name-resolve --skip-networking=0 < /dev/null &

    pid="$!"
    # Wait for MariaDB to start
    sleep 5

    # Perform necessary commands
    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    cat << EOF > "$tfile"
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    # Run SQL commands
    /usr/bin/mysql -u root --password="${MYSQL_ROOT_PASSWORD}" < "$tfile"
    rm -f "$tfile"

    # Kill the temporary MariaDB instance
    kill "$pid"
    wait "$pid"

fi

# Create the WordPress database if it doesn't exist
if [ ! -d "/var/lib/mysql/${WORDPRESS_DB_NAME}" ]; then

    # Start MariaDB normally
    /usr/bin/mysqld_safe --datadir='/var/lib/mysql' --user=mysql &

    pid="$!"
    # Wait for MariaDB to start
    sleep 5

    # Create the WordPress database and user
    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    cat << EOF > "$tfile"
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Run SQL commands
    /usr/bin/mysql -u root --password="${MYSQL_ROOT_PASSWORD}" < "$tfile"
    rm -f "$tfile"

    # Kill MariaDB
    kill "$pid"
    wait "$pid"

fi
