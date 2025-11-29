#!/bin/bash
set -euo pipefail

if [[ -z "${POSTGRES_DBS:-}" ]]; then
  echo "[POSTGRES] No PostgreSQL DBs configured. Skipping..."
  exit 0
fi

export PGPASSWORD="$POSTGRES_PASS"

for DB in $POSTGRES_DBS; do
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  FILE="$BACKUP_DIR/${DB}_pgsql_${TIMESTAMP}.sql.gz"

  echo "[POSTGRES] Backing up: $DB"

  if pg_dump \
      -h "$POSTGRES_HOST" \
      -p "$POSTGRES_PORT" \
      -U "$POSTGRES_USER" \
      "$DB" | gzip > "$FILE"; then
      echo "[POSTGRES] OK → $FILE"
  else
      echo "[POSTGRES] ERROR while backing up $DB" >&2
  fi
done
