#!/usr/bin/env bash
# deploy-laravel.sh — deploy versi baru dengan rollback mudah
set -euo pipefail
APP=/var/www/laravel.yoni.efs.my.id
REL=$APP/releases/$(date +%Y%m%d%H%M%S)

mkdir -p "$REL"
rsync -a --exclude=vendor --exclude=.env "$APP/current/" "$REL/"
cd "$REL"
composer install --no-dev --optimize-autoloader -q
[ -f "$APP/current/.env" ] && cp "$APP/current/.env" "$REL/.env"
php artisan key:generate --force -q 2>/dev/null || true
ln -sfn "$REL" "$APP/current"          # switch versi atomik
php artisan migrate --force
php artisan config:cache && php artisan route:cache && php artisan view:cache
echo "Deployed: $REL"
echo "Rollback: ln -sfn $APP/releases/<versi-lama> $APP/current"
