#!/usr/bin/env bash

# Määrame sa-test juurkausta asukoha (skript asub kaustas sa-test/scripts/)
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/settings.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Viga: Seadistusfaili $CONFIG_FILE ei leitud!"
    exit 1
fi

BACKUP_SOURCE="${BACKUP_SOURCE:-$BASE_DIR/testdata/source}"
BACKUP_DIR="${BACKUP_DIR:-$BASE_DIR/backups}"

# 1. Kontrollime, kas lähtekaust eksisteerib
if [ ! -d "$BACKUP_SOURCE" ]; then
    echo "Viga: Lähtekausta '$BACKUP_SOURCE' ei leitud!"
    echo "Käivita enne jooksu: ./setup.sh"
    exit 1
fi

# 2. Kontrollime, ega lähtekaust pole tühi
if [ -z "$(ls -A "$BACKUP_SOURCE" 2>/dev/null)" ]; then
    echo "Hoiatus: Lähtekaust '$BACKUP_SOURCE' on tühi, varukoopiat ei luua."
    exit 1
fi

# 3. Loome varukoopiate kausta
mkdir -p "$BACKUP_DIR"

DATE=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

echo "=== Alustan varukoopia loomist ==="
echo "Lähtekoht (Kust): $BACKUP_SOURCE"
echo "Sihtkoht (Kuhu):  $ARCHIVE"

# 4. Pakime kogu BACKUP_SOURCE sisu (.tar.gz)
if tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" . 2>/dev/null; then
    # Kontrollime arhiivi olemasolu ja loetavust
    if [ -s "$ARCHIVE" ] && tar -tzf "$ARCHIVE" >/dev/null 2>&1; then
        FAILIDE_ARV=$(tar -tzf "$ARCHIVE" | grep -v '/$' | wc -l)
        echo "[OK] Varukoopia edukalt loodud!"
        echo "Arhiivi asukoht: $ARCHIVE"
        echo "Pakitud failide arv: $FAILIDE_ARV"
        exit 0
    fi
fi

echo "[VIGA] Varukoopia loomine või arhiivi kontroll ebaõnnestus!"
exit 1
