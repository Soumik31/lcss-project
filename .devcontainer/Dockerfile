FROM php:8.1-apache

# Install MariaDB
RUN apt-get update && apt-get install -y \
    default-mysql-server \
    default-mysql-client \
    && docker-php-ext-install mysqli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy project files into Apache web root
COPY .. /var/www/html/

# Copy and set entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
