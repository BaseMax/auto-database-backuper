#!/bin/bash
set -euo pipefail

echo "[ROTATE] Keeping last $KEEP_BACKUPS backups..."

ls -1t "$BACKUP_DIR"/*.gz | tail -n +$KEEP_BACKUPS | xargs -r rm -- || true

echo "[ROTATE] Rotation completed."
