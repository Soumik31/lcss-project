#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project: $PROJECT_DIR"

echo "==> Starting MySQL (installed by devcontainer feature)..."
sudo service mysql start || true
sleep 3

echo "==> Waiting for MySQL..."
for i in {1..20}; do
  if sudo mysqladmin ping --silent 2>/dev/null; then
    echo "MySQL ready."
    break
  fi
  echo "  ($i)..."
  sleep 2
done

echo "==> Importing database..."
sudo mysql < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache..."
sudo chmod a+x "$PROJECT_DIR"
sudo rm -rf /var/www/html
sudo ln -s "$PROJECT_DIR" /var/www/html
sudo sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/:80>/:8080>/' /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo service apache2 restart || true

echo "✅ Done! http://localhost:8080"
echo "   Admin → admin / admin123"
echo "   User  → alice / alice123"
