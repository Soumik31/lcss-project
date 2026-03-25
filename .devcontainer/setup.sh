#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project: $PROJECT_DIR"

echo "==> Updating Alpine packages..."
sudo apk update

echo "==> Installing PHP, Apache, MariaDB..."
sudo apk add --no-cache php83 php83-apache2 php83-mysqli apache2 mariadb mariadb-client

echo "==> Initializing MariaDB..."
sudo mysql_install_db --user=mysql --datadir=/var/lib/mysql 2>/dev/null || true

echo "==> Starting MariaDB..."
sudo mysqld_safe --datadir=/var/lib/mysql &
sleep 6

echo "==> Importing database..."
sudo mysql < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache..."
sudo ln -sf "$PROJECT_DIR" /var/www/localhost/htdocs
sudo sed -i 's/^Listen 80/Listen 8080/' /etc/apache2/httpd.conf
echo "ServerName localhost" | sudo tee -a /etc/apache2/httpd.conf

echo "==> Starting Apache..."
sudo httpd -D FOREGROUND &

echo ""
echo "✅ Done! Site at http://localhost:8080"
echo "   Admin → admin / admin123"
echo "   User  → alice / alice123"
