#!/bin/bash
set -e

echo "==> Waiting for MySQL to be ready..."
for i in {1..30}; do
  if mysql -h db -u root -e "SELECT 1" &>/dev/null; then
    echo "MySQL is up."
    break
  fi
  echo "Waiting... ($i)"
  sleep 3
done

echo "==> Importing database..."
mysql -h db -u root < /var/www/html/database.sql

echo ""
echo "✅ Done! Site is at http://localhost:8080"
echo "   Admin  → admin / admin123"
echo "   User   → alice / alice123"
