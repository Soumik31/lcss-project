#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
echo "==> Project: $PROJECT_DIR"

# Install MySQL if not present
if ! command -v mysql &>/dev/null; then
  echo "==> Installing MySQL..."
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -qq
  apt-get install -y -qq default-mysql-server default-mysql-client
fi

echo "==> Starting MySQL..."
mysqld_safe --daemonize --skip-grant-tables 2>/dev/null || \
  mysqld --daemonize --skip-grant-tables 2>/dev/null || true
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

echo "==> Linking project to Apache web root..."
rm -rf /var/www/html
ln -s "$PROJECT_DIR" /var/www/html

echo "==> Restarting Apache..."
apachectl restart 2>/dev/null || apache2ctl restart 2>/dev/null || true

echo ""
echo "✅ Done!"
echo "   Admin → admin / admin123"
echo "   User  → alice / alice123"
