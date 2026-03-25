FROM mcr.microsoft.com/devcontainers/php:8.1-apache

# Install MySQL server + client + php mysqli extension in one layer
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends default-mysql-server default-mysql-client \
    && docker-php-ext-install mysqli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
