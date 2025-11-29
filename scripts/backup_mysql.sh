#!/bin/bash
set -euo pipefail

if [[ -z "${MYSQL_DBS:-}" ]]; then
  echo "[MYSQL] No MySQL/MariaDB DBs configured. Skipping..."
  exit 0
fi

for DB in $MYSQL_DBS; do
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  FILE="$BACKUP_DIR/${DB}_mysql_${TIMESTAMP}.sql.gz"

  echo "[MYSQL] Backing up: $DB"

  if mysqldump \
      -h "$MYSQL_HOST" \
      -P "$MYSQL_PORT" \
      -u "$MYSQL_USER" \
      -p"$MYSQL_PASS" \
      "$DB" | gzip > "$FILE"; then
      echo "[MYSQL] OK → $FILE"
  else
      echo "[MYSQL] ERROR while backing up $DB" >&2
  fi
done
