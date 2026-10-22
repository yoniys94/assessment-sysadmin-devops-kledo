#!/usr/bin/env bash
# backup-website.sh — backup file + database harian dengan retensi
set -euo pipefail
BACKUP_DIR=/backup
DATE=$(date +%F)
WEB_ROOT=/var/www
declare -A DBS=( [wp_yoni_db]="" [laravel_yoni_db]="" )

mkdir -p "$BACKUP_DIR"
for domain in wp.yoni.efs.my.id laravel.yoni.efs.my.id; do
    tar -czf "$BACKUP_DIR/${domain}-${DATE}.tar.gz" -C "$WEB_ROOT" "$domain"
done
for db in "${!DBS[@]}"; do
    mysqldump "$db" > "$BACKUP_DIR/${db}-${DATE}.sql"
done
find "$BACKUP_DIR" -name "*-${DATE}.tar.gz" -o -name "*-${DATE}.sql" | xargs ls -lh
find "$BACKUP_DIR" \( -name '*.tar.gz' -o -name '*.sql' \) -mtime +7 -delete   # retensi 7 hari
echo "Backup selesai: $BACKUP_DIR ($(date))"
