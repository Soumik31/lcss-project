#!/bin/bash
set -e

echo "==> Waiting for MySQL to be ready..."
for i in {1..30}; do
  if mysqladmin ping -h db -u root --silent 2>/dev/null; then
    echo "MySQL is up."
    break
  fi
  echo "Waiting... ($i)"
  sleep 2
done

echo "==> Importing database..."
mysql -h db -u root < /var/www/html/database.sql

echo "✅ Database imported!"
echo "   Site is at http://localhost:8080"
echo "   Admin  → admin / admin123"
echo "   User   → alice / alice123"
