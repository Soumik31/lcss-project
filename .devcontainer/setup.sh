#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project: $PROJECT_DIR"

echo "==> Starting MySQL..."
mysqld_safe --daemonize 2>/dev/null || true
sleep 5

echo "==> Waiting for MySQL..."
for i in {1..20}; do
  if mysqladmin ping --silent 2>/dev/null; then
    echo "MySQL ready."
    break
  fi
  sleep 2
done

echo "==> Importing database..."
mysql < "$PROJECT_DIR/database.sql"

echo "==> Linking project to web root..."
rm -rf /var/www/html
ln -s "$PROJECT_DIR" /var/www/html

echo "==> Restarting Apache..."
apachectl restart 2>/dev/null || apache2ctl restart 2>/dev/null || true

echo ""
echo "✅ Done! Open port 80 to see the site."
echo "   Admin → admin / admin123"
echo "   User  → alice / alice123"
