#!/bin/bash

PROJECT_DIR=$(pwd)
echo "==> Project: $PROJECT_DIR"

echo "==> Initializing MySQL data directory..."
sudo mkdir -p /var/lib/mysql
sudo chown -R mysql:mysql /var/lib/mysql
sudo mysqld --initialize-insecure --user=mysql 2>/dev/null || true

echo "==> Starting MySQL..."
sudo mysqld_safe --daemonize --user=mysql 2>/dev/null || true
sleep 6

echo "==> Waiting for MySQL..."
for i in {1..15}; do
  if mysqladmin ping -u root --silent 2>/dev/null; then
    echo "MySQL ready."
    break
  fi
  echo "  ($i)..."
  sleep 2
done

echo "==> Importing database..."
mysql -u root < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache..."
sudo chmod a+x "$PROJECT_DIR"
sudo rm -rf /var/www/html
sudo ln -s "$PROJECT_DIR" /var/www/html
sudo sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/:80>/:8080>/' /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo apachectl restart 2>/dev/null || true

echo "✅ Done! http://localhost:8080"
echo "   Admin → admin / admin123"
echo "   User  → alice / alice123"
