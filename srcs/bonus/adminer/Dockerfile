# Import the alpine image
FROM alpine:3.18

# Install PHP and PHP extensions along with lighttpd to serve Adminer
RUN apk add --no-cache php82 \
	php82-fpm \
	php82-session \
	php82-pdo \
	php82-pdo_mysql \
	lighttpd \
	curl

# symlink php to php8.2
RUN ln -s /usr/bin/php82 /usr/bin/php

# Download Adminer
RUN curl -o /var/www/adminer.php -L https://www.adminer.org/latest.php

# Expose the port Adminer listens on
EXPOSE 8080

# Start PHP's built-in web server
CMD php -S 0.0.0.0:8080 -t /var/www/ /var/www/adminer.php