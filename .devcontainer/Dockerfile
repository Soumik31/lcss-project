FROM php:8.1-apache

# Install mysqli extension and mysql client
RUN docker-php-ext-install mysqli \
    && apt-get update \
    && apt-get install -y default-mysql-client \
    && rm -rf /var/lib/apt/lists/*
