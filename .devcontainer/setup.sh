#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Installing MySQL server and client..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq default-mysql-server default-mysql-client

echo "==> Starting MySQL..."
mysqld_safe --daemonize --skip-grant-tables 2>/dev/null || true
sleep 5

echo "==> Waiting for MySQL..."
for i in {1..20}; do
  if mysqladmin ping -u root --silent 2>/dev/null; then
    echo "MySQL is up."
    break
  fi
  sleep 2
done

echo "==> Importing database..."
mysql -u root < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache on port 8080..."
sudo tee /etc/apache2/sites-available/000-default.conf > /dev/null <<EOF
<VirtualHost *:8080>
    DocumentRoot $PROJECT_DIR
    <Directory $PROJECT_DIR>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

sudo sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf
sudo a2enmod rewrite
sudo apachectl start

echo ""
echo "✅ Done! Site is at http://localhost:8080"
echo "   Admin  → admin / admin123"
echo "   User   → alice / alice123"
