FROM alpine:3.18

RUN apk add --no-cache php82 \
	php82-fpm \
	php82-session \
	php82-pdo \
	php82-pdo_mysql \
	lighttpd \
	curl

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN curl -o /var/www/adminer.php -L https://www.adminer.org/latest.php

EXPOSE 8080

CMD php -S 0.0.0.0:8080 -t /var/www/ /var/www/adminer.php