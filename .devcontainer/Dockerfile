FROM mcr.microsoft.com/devcontainers/php:8.1-apache

# Install MySQL server + client + php mysqli extension
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        default-mysql-server \
        default-mysql-client \
    && docker-php-ext-install mysqli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Pre-start MySQL once during build to initialize data directory
RUN mysqld --initialize-insecure --user=mysql 2>/dev/null || true
