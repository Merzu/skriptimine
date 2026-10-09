#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
source "$BASE_DIR/config/settings.conf"

cd "$BASE_DIR" || exit 1

DATE=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

if [ ! -d "$BACKUP_SOURCE" ]; then
    mkdir -p "$BACKUP_SOURCE"
    echo "Loodi puudunud lähtekaust: $BACKUP_SOURCE"
fi

mkdir -p "$BACKUP_DIR"

echo "Varukoopia loomine..."

if tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" . 2>/dev/null; then
    if [ -s "$ARCHIVE" ] && tar -tzf "$ARCHIVE" >/dev/null 2>&1; then
        echo "Varukoopia valmis: $ARCHIVE"
        echo "Failide arv: $(tar -tzf "$ARCHIVE" | wc -l)"
        exit 0
    fi
fi

echo "Varukoopia ebaõnnestus."
exit 1
