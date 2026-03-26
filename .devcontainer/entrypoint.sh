#!/bin/bash
set -e

echo "==> Starting MariaDB..."
usermod -d /var/lib/mysql mysql 2>/dev/null || true
mysqld_safe --skip-grant-tables &
sleep 5

echo "==> Importing database..."
mysql -u root < /var/www/html/database.sql

echo "==> Starting Apache..."
apache2-foreground
