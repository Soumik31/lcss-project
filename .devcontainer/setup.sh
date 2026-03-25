#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project directory: $PROJECT_DIR"

echo "==> Starting MySQL..."
# The mysql devcontainer feature uses mysqld_safe or mysqld directly
mysqld_safe --daemonize 2>/dev/null || mysqld --daemonize 2>/dev/null || true

echo "==> Waiting for MySQL to be ready..."
for i in {1..30}; do
  if mysqladmin ping -u root --silent 2>/dev/null; then
    echo "MySQL is up."
    break
  fi
  echo "Waiting... ($i)"
  sleep 2
done

echo "==> Importing database..."
mysql -u root < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache virtual host..."
sudo tee /etc/apache2/sites-available/000-default.conf > /dev/null <<EOF
<VirtualHost *:8080>
    DocumentRoot $PROJECT_DIR
    <Directory $PROJECT_DIR>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

echo "==> Setting Apache to listen on port 8080..."
sudo sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf

sudo a2enmod rewrite

echo "==> Starting Apache..."
sudo apachectl start || sudo apachectl restart

echo ""
echo "✅ Done! Site is at http://localhost:8080"
echo "   Admin  → admin / admin123"
echo "   User   → alice / alice123"
