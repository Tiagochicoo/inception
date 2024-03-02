FROM alpine:3.18

# Install the required packages
RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen

# Create mysql user and group
RUN addgroup -S mysql && adduser -S mysql -G mysql

# Initialize the data directory
RUN mkdir /var/lib/mysql /var/run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
  && chmod 777 /var/run/mysqld

# Expose the port MariaDB is reachable on
EXPOSE 3306

# Copy the MariaDB configuration
COPY my.cnf /etc/mysql/my.cnf

# Copy your script into the container
COPY create_db.sh /create_db.sh

# Make sure scripts are executable
RUN chmod +x /create_db.sh

# Start MariaDB
CMD ["/bin/sh", "/create_db.sh"]
