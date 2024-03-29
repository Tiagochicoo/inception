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

COPY configs/index.html /var/www/42.html

# Expose the port Adminer listens on
EXPOSE 4242

# Start PHP's built-in web server
CMD php -S 0.0.0.0:4242 -t /var/www/ /var/www/42.html