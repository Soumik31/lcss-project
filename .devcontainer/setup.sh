#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project: $PROJECT_DIR"

echo "==> Starting MySQL..."
service mysql start || true

echo "==> Waiting for MySQL..."
for i in {1..30}; do
  if mysqladmin ping -u root --silent 2>/dev/null; then
    echo "MySQL ready."
    break
  fi
  echo "  ($i) waiting..."
  sleep 2
done

echo "==> Importing database..."
mysql -u root < "$PROJECT_DIR/database.sql"

echo "==> Configuring Apache on port 8080..."
cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:8080>
    DocumentRoot $PROJECT_DIR
    <Directory $PROJECT_DIR>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf
a2enmod rewrite
service apache2 restart || apache2ctl restart || true

echo ""
echo "✅ Done! Site at http://localhost:8080"
echo "   Admin → admin / admin123"
echo "   User  → alice / alice123"
