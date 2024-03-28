# Use the specified version of Alpine
FROM alpine:3.18

# Install MariaDB and other necessary packages
RUN apk --no-cache add mariadb mariadb-client \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copy your initialization script into the container
COPY scripts/init_db.sh /usr/local/bin/init_db.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/init_db.sh

# Copy the custom configuration file into the container
COPY configs/my.cnf /etc/my.cnf

# Ensure the configuration file is owned by the MariaDB user
RUN chown mysql:mysql /etc/my.cnf

# Expose the port MariaDB listens on
EXPOSE 3306

# Use the custom script as the entrypoint
ENTRYPOINT ["/usr/local/bin/init_db.sh"]
