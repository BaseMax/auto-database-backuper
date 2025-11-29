#!/bin/bash
set -euo pipefail

if [[ -z "${MONGO_DBS:-}" ]]; then
  echo "[MONGO] No MongoDB databases configured. Skipping..."
  exit 0
fi

echo "[MONGO] Starting MongoDB backup..."

AUTH_ARGS=()
if [[ -n "${MONGO_USER:-}" ]]; then
  AUTH_ARGS+=( --username "$MONGO_USER" )
fi
if [[ -n "${MONGO_PASS:-}" ]]; then
  AUTH_ARGS+=( --password "$MONGO_PASS" )
fi
if [[ -n "${MONGO_AUTH_DB:-}" ]]; then
  AUTH_ARGS+=( --authenticationDatabase "$MONGO_AUTH_DB" )
fi

for DB in $MONGO_DBS; do
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  OUT_DIR="$BACKUP_DIR/mongo_${DB}_${TIMESTAMP}"
  TAR_FILE="$BACKUP_DIR/mongo_${DB}_${TIMESTAMP}.tar.gz"

  echo "[MONGO] Backing up DB: $DB"

  if mongodump \
      --host "$MONGO_HOST" \
      --port "$MONGO_PORT" \
      --db "$DB" \
      "${AUTH_ARGS[@]}" \
      --out "$OUT_DIR"; then

      tar -czf "$TAR_FILE" -C "$OUT_DIR" .

      rm -rf "$OUT_DIR"

      echo "[MONGO] OK → $TAR_FILE"
  else
      echo "[MONGO] ERROR while backing up $DB" >&2
      rm -rf "$OUT_DIR"
  fi
done

echo "[MONGO] MongoDB backup completed."
