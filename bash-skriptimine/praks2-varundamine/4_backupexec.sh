#!/bin/bash
set -o pipefail

BASE_DIR="$HOME/praks2"
SRC_DIR="$BASE_DIR/src"
BACKUP_DIR="$BASE_DIR/backup"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/backup.log"
IGNORE_FILE="$SRC_DIR/.backupignore"

mkdir -p "$BACKUP_DIR" "$LOG_DIR"

logi() {
    local teade="[$(date '+%F %T')] $1"
    echo "$teade"
    echo "$teade" >> "$LOG_FILE"
}

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

logi "BACKUP START"

if [ ! -d "$SRC_DIR" ]; then
    logi "VIGA: Lähtekausta '$SRC_DIR' ei leitud!"
    exit 1
fi

VAJALIK_RUUM=$(du -sb "$SRC_DIR" | awk '{print $1}')
VABA_RUUM=$(df -B1 "$BACKUP_DIR" | awk 'NR==2 {print $4}')
MIN_RUUM=$((VAJALIK_RUUM * 2))

if [ "$VABA_RUUM" -lt "$MIN_RUUM" ]; then
    logi "VIGA: Ebapiisav kettaruum! Vaba: ${VABA_RUUM} B, vaja: ${MIN_RUUM} B."
    exit 1
fi
logi "OK: Kettaruumi kontroll läbitud (vaba: ${VABA_RUUM} B)."

KOMPRESSOR="${1:-auto}"
if [ "$KOMPRESSOR" = "auto" ]; then
    if command -v zstd >/dev/null 2>&1; then
        KOMPRESSOR="zstd"
    elif command -v xz >/dev/null 2>&1; then
        KOMPRESSOR="xz"
    else
        KOMPRESSOR="gz"
    fi
fi

AJATEMPEL=$(date '+%Y%m%d_%H%M%S')
case "$KOMPRESSOR" in
    zstd) LAIEND="tar.zst"; TAR_ARGS=(-I "zstd -19 -T0"); TEST_ARGS=(-I "zstd -d") ;;
    gz)   LAIEND="tar.gz";  TAR_ARGS=(-z);               TEST_ARGS=(-z) ;;
    xz)   LAIEND="tar.xz";  TAR_ARGS=(-J);               TEST_ARGS=(-J) ;;
    *)    logi "VIGA: Tundmatu kompressor '$KOMPRESSOR'."; exit 1 ;;
esac

FAILINIMI="src_${AJATEMPEL}.${LAIEND}"
AJUTINE_ARHIIV="$TMP_DIR/$FAILINIMI"
LOPP_ARHIIV="$BACKUP_DIR/$FAILINIMI"

if [ -e "$LOPP_ARHIIV" ]; then
    logi "VIGA: Arhiiv '$LOPP_ARHIIV' on juba olemas!"
    exit 1
fi

EXCLUDE_ARGS=()
if [ -f "$IGNORE_FILE" ]; then
    EXCLUDE_ARGS=(--exclude-from="$IGNORE_FILE")
    logi "INFO: Kasutan välistusfaili $IGNORE_FILE."
fi

logi "INFO: Loon arhiivi kompressoriga '$KOMPRESSOR'..."
if ! tar "${TAR_ARGS[@]}" "${EXCLUDE_ARGS[@]}" -cf "$AJUTINE_ARHIIV" -C "$BASE_DIR" "src"; then
    logi "VIGA: Arhiivi loomine ebaõnnestus!"
    exit 1
fi

SISU=$(tar "${TEST_ARGS[@]}" -tf "$AJUTINE_ARHIIV" 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$SISU" ]; then
    logi "VIGA: Loodud arhiiv on vigane ega avane!"
    exit 1
fi

ALAMKAUSTAD=$(echo "$SISU" | grep -E '^src/.+/$' | wc -l)
if [ "$ALAMKAUSTAD" -lt 1 ]; then
    logi "VIGA: Arhiivis ei tuvastatud alamkaustu!"
    exit 1
fi
logi "OK: Arhiiv avaneb korrektselt (alamkaustu: $ALAMKAUSTAD)."

(
    cd "$TMP_DIR" || exit 1
    sha256sum "$FAILINIMI" > "${FAILINIMI}.sha256"
    sha256sum -c "${FAILINIMI}.sha256" >/dev/null 2>&1
) || { logi "VIGA: SHA-256 kontrollsumma viga!"; exit 1; }
logi "OK: SHA-256 kontrollsumma kinnitatud."

mv "$AJUTINE_ARHIIV" "$LOPP_ARHIIV"
mv "${AJUTINE_ARHIIV}.sha256" "${LOPP_ARHIIV}.sha256"
SUURUS=$(du -h "$LOPP_ARHIIV" | awk '{print $1}')
logi "OK: Varukoopia salvestatud: $LOPP_ARHIIV (Suurus: $SUURUS)"

cd "$BACKUP_DIR" || exit 1
VANAD_FAILID=$(ls -1t src_*.tar.* 2>/dev/null | grep -v '\.sha256$' | tail -n +4)
for vana in $VANAD_FAILID; do
    rm -f "$vana" "${vana}.sha256"
    logi "INFO: Kustutatud vana varukoopia: $vana"
done

logi "BACKUP END (Edukas)"
exit 0
