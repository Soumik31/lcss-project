#!/bin/bash
set -e

echo "==> Starting MySQL..."
sudo service mysql start

echo "==> Waiting for MySQL to be ready..."
until sudo mysqladmin ping --silent; do
  sleep 1
done

echo "==> Importing database..."
# In Codespaces the project is mounted at /workspaces/<repo-name>
PROJECT_DIR=$(pwd)
sudo mysql -u root < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache to serve from project folder..."
sudo bash -c "cat > /etc/apache2/sites-available/000-default.conf <<EOF
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
EOF"

# Set Apache to listen on port 8080
sudo sed -i 's/Listen 80$/Listen 8080/' /etc/apache2/ports.conf

sudo a2enmod rewrite
sudo service apache2 restart

echo ""
echo "✅ Setup complete!"
echo "   Site running at http://localhost:8080"
echo "   Admin  → admin / admin123"
echo "   User   → alice / alice123"
