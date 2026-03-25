#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project directory: $PROJECT_DIR"

echo "==> Starting MySQL..."
sudo service mysql start || true

echo "==> Waiting for MySQL to be ready..."
for i in {1..30}; do
  if sudo mysqladmin ping --silent 2>/dev/null; then
    echo "MySQL is up."
    break
  fi
  echo "Waiting... ($i)"
  sleep 2
done

echo "==> Importing database..."
sudo mysql -u root < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache..."

# Write virtual host config
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

# Update Apache to listen on 8080 instead of 80
sudo sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf

# Enable rewrite module
sudo a2enmod rewrite

echo "==> Starting Apache..."
sudo service apache2 restart

echo ""
echo "✅ Done! Site is at http://localhost:8080"
echo "   Admin  → admin / admin123"
echo "   User   → alice / alice123"
