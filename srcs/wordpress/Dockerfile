FROM wordpress:php7.4-fpm-alpine

# Install additional dependencies
RUN apk add --no-cache openssl bash

# Add your php configuration if needed
# COPY ./srcs/wordpress/php.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
