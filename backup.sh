#!/bin/bash
set -euo pipefail

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

LOG_PREFIX="[AUTO-BACKUP]"

echo "$LOG_PREFIX Starting backup..."

mkdir -p "$BACKUP_DIR"

./scripts/backup_mysql.sh

./scripts/backup_postgres.sh

./scripts/rotate.sh

echo "$LOG_PREFIX Backup process completed."
