#!/bin/sh

# Create directories if they don't exist
mkdir -p /var/www/html/wordpress

# Change to the directory where WordPress should be installed
cd /var/www/html/wordpress

# Check if WordPress is already downloaded and wp-config.php exists
if [ -f wp-config.php ]; then
    echo "WordPress is already downloaded."
else
    echo "Downloading WordPress..."
    curl -LO https://wordpress.org/latest.tar.gz
    # Extract WordPress, strip the top-level directory
    tar xzvf latest.tar.gz --strip-components=1
    rm -rf latest.tar.gz
    
    echo "Creating wp-config.php..."
    # Assumes wp-cli is available in the PATH
    wp config create --dbname="$MYSQL_DATABASE" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --dbcharset="utf8" \
    --dbcollate="" \
    --allow-root \
    --path=$(pwd) \
    --extra-php <<PHP
    define('FS_METHOD', 'direct');
PHP

    echo "Installing WordPress..."
    wp core install --url="$WORDPRESS_URL" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_DB_ADMIN_USER" \
    --admin_password="$WORDPRESS_DB_ADMIN_PASSWORD" \
    --admin_email="$WORDPRESS_DB_ADMIN_EMAIL" \
    --skip-email \
    --allow-root \
    --path=$(pwd)

    echo "Creating additional WordPress user..."
    wp user create --allow-root ${WORDPRESS_DB_USER} ${WORDPRESS_DB_USER_EMAIL} --user_pass=${WORDPRESS_DB_PASSWORD} --path=$(pwd)
fi

echo "Starting PHP-FPM..."
# Make sure the path to PHP-FPM executable is correct for your setup
exec /usr/sbin/php-fpm82 -F
