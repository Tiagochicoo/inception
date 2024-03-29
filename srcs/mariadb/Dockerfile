FROM alpine:3.18

RUN apk --no-cache add mariadb mariadb-client \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY scripts/init_db.sh /usr/local/bin/init_db.sh

RUN chmod +x /usr/local/bin/init_db.sh

COPY configs/my.cnf /etc/my.cnf

RUN chown mysql:mysql /etc/my.cnf

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_db.sh"]
