FROM alpine:3.18

RUN apk add --no-cache \
	php82 \
	php82-fpm \
	php82-opcache \
	php82-gd \
	php82-mysqli \
	php82-zlib \
	php82-curl \
	php82-mbstring \
	php82-json \
	php82-xml \
	php82-phar \
	php82-intl \
	php82-dom \
	php82-xmlreader \
	php82-ctype \
	php82-session \
	php82-iconv \
	php82-simplexml \
	curl \
	wget \
	tar 

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN mkdir -p /var/www/html/wordpress

WORKDIR /var/www/html/wordpress
RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz

COPY ./configs/www.conf /etc/php82/php-fpm.d/www.conf
COPY ./scripts/run.sh /tmp/run.sh

RUN chmod +x /tmp/run.sh

RUN chmod 777 /var/www/html/wordpress

WORKDIR /tmp/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT ["ash","-c", "/bin/ash /tmp/run.sh;"]

WORKDIR /var/www/html/wordpress
