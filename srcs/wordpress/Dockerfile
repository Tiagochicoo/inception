FROM wordpress:php7.4-fpm-alpine

# FROM alpine:3.12

# # Install packages

# RUN apk add --no-cache \
#     php7 \
#     php7-fpm \
#     php7-mysqli \
#     php7-json \
#     php7-openssl \
#     php7-curl \
#     php7-zlib \
#     php7-xml \
#     php7-phar \
#     php7-intl \
#     php7-dom \
#     php7-xmlreader \
#     php7-ctype \
#     php7-session \
#     php7-mbstring \
#     nginx \
#     curl


# # Configure nginx and php-fpm
# # COPY ../srcs/nginx.conf /etc/nginx/conf.d/default.conf

# COPY ./php-fpm.conf /etc/php7/php-fpm.d/www.conf

# # Install wordpress
# RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
#     tar -xvf wordpress.tar.gz && \
#     rm wordpress.tar.gz && \
#     mv wordpress /var/www/wordpress

# EXPOSE 9000

# # Copy wordpress config file
# # COPY ../srcs/wp-config.php /var/www/wordpress/wp-config.php

# # Start Nginx and PHP-FPM
# CMD ["php-fpm7", "-F", "-g", "daemon off;"]