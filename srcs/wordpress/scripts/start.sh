#!/bin/bash

# Replace all occurrences of a string in a file, overwriting the file (i.e., in-place):
sed -i "s/listen = \/run\/php\/php-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
# -R recursive change of access rights for directories and their contents
chmod -R 775 /var/www/html/;
# The following example will change the owner of all files and
# subdirectories in the /var/www/html/ directory to a new owner and group named www-data:
chown -R www-data /var/www/html/;
mkdir -p /run/php/;
touch /run/php/php-fpm.pid;

# Start PHP server on 0.0.0.0:9000 serving the WordPress directory
php -S 0.0.0.0:9000 -t /var/www/html/

if [ ! -f /var/www/html//wp-config.php ]; then
echo "Wordpress: setting up..."
# After checking requirements, download the wp-cli.phar file using wget or curl:
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
# "+x" means — set execute (x) permission for the file for all users.
chmod +x wp-cli.phar;
# To use WP-CLI from the command line by typing wp, make the file executable and
# move it somewhere in your PATH. For example:
mv wp-cli.phar /usr/local/bin/wp;
cd /var/www/html/;
# Downloads and extracts WordPress core files to the specified path

# static website
	mkdir -p /var/www/html//mysite;
    mv /var/www/index.html /var/www/html//mysite/index.html;

wp core download --allow-root;
mv /var/www/wp-config.php /var/www/html/;
echo "Wordpress: creating users..."
# Creates WordPress tables in the database using the URL, title, and default admin user data provided
# --url=<site-url>
# The address of the new site.
# --title=<site-title>
# The title of the new site.
# --admin_user=<username>
# The admin username.
# [--admin_password=<password>]
# Password for the admin user. Default: A randomly generated string.
# --admin_email=<email>
# The admin email address.
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
# Creates a new user
# <user-login>
# The user login to create.
# <user-email>
# The user email address to create.
# [--role=<role>]
# The role for the new user. Default: default role
# Possible values include "administrator", "editor", "author", "contributor", "subscriber".
# [--user_pass=<password>]
# The user password. Default: Randomly generated
wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;
# Theme for WordPress
wp theme install inspiro --activate --allow-root

# # enable redis cache
#     sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
#     sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
#     #sed -i "42i define( 'WP_REDIS_PASSWORD', '$REDIS_PWD' );"   wp-config.php
#     sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
#     sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
#     sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

#     wp plugin install redis-cache --activate --allow-root
#     wp plugin update --all --allow-root

echo "Wordpress: set up!"
else
echo "Wordpress: is already set up!"
fi

# wp redis enable --allow-root

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7.3 -F
