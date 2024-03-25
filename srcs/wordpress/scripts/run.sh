#!/bin/sh

while [ ! -e /var/www/html/wordpress/ ]
do
	sleep 1;
done

sleep 5;

# WordPress path
WP_PATH="/var/www/html/wordpress"

# Check if WordPress is installed or wp-config.php exists
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "WordPress is not installed. Installing..."

    # Ensure WordPress files are present
    if [ ! -f "$WP_PATH/wp-load.php" ]; then
        echo "Downloading WordPress..."
        wp core download --path="$WP_PATH" --allow-root
    fi

    echo "Creating wp-config.php..."
    wp config create --path="$WP_PATH" --allow-root \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST:-localhost}"
fi

# Install WordPress if not already installed
if ! wp core is-installed --path="$WP_PATH" --allow-root; then
    echo "Installing WordPress..."
    wp core install --path="$WP_PATH" --allow-root \
        --url="${WORDPRESS_SITE_URL}" \
        --title="${WORDPRESS_SITE_TITLE}" \
        --admin_user="${WORDPRESS_DB_ADMIN_USER}" \
        --admin_password="${WORDPRESS_DB_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_DB_ADMIN_EMAIL}"

    # Create additional user
    wp user create --path="$WP_PATH" --allow-root \
        $WORDPRESS_DB_USER \
        $WORDPRESS_DB_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_DB_PASSWORD
fi

# Config php.ini (adjust for your PHP version)
sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php82/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 128M/" /etc/php82/php.ini
sed -i "s/zlib.output_compression = .*/zlib.output_compression = on/" /etc/php82/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 18000/" /etc/php82/php.ini

# Start PHP-FPM
php-fpm82 -F -R
