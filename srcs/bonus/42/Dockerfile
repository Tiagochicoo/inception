FROM alpine:3.18

RUN apk add --no-cache php82 \
	php82-fpm \
	php82-session \
	php82-pdo \
	php82-pdo_mysql \
	lighttpd \
	curl

RUN ln -s /usr/bin/php82 /usr/bin/php

COPY configs/index.html /var/www/42.html

EXPOSE 9999 

CMD php -S 0.0.0.0:9999 -t /var/www/ /var/www/42.html
