FROM wordpress:php7.4-fpm-alpine

# Install additional dependencies
RUN apk add --no-cache openssl bash

# Add php configuration
# COPY ./srcs/wordpress/php.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www/html

# Add a health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
	CMD curl -f http://localhost:9000/ || exit 1

EXPOSE 9000

CMD ["php-fpm"]
