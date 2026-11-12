#!/bin/bash
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Skript tuleb käivitada root-õigustes (kasuta: sudo $0)!"
    exit 1
fi

LAHTEKAUST="${1:-/home}"
SIHTKAUST="${2:-/home_bcp}"
KUUPAEV=$(date +'%d.%m.%Y')

if [ ! -d "$LAHTEKAUST" ]; then
    echo "Viga: Lähtekataloogi '$LAHTEKAUST' ei leitud!"
    exit 1
fi

mkdir -p "$SIHTKAUST"

echo "=== Alustan kodukataloogide varundamist ==="
echo "Lähtekataloog: $LAHTEKAUST"
echo "Sihtkataloog:  $SIHTKAUST"
echo "Kuupäev:       $KUUPAEV"
echo "-------------------------------------------"

for tee in "$LAHTEKAUST"/*; do
    [ -e "$tee" ] || continue
    nimi=$(basename "$tee")

    if [ -f "$tee" ]; then
        echo "[VAHELE JÄETUD] '$nimi' on tavaline fail, mitte kataloog."
    elif [ -d "$tee" ]; then
        arhiiv="${SIHTKAUST}/${nimi}.${KUUPAEV}.tar.gz"
        echo "[VARUNDAN] '$nimi' -> $arhiiv"
        if tar -czf "$arhiiv" -C "$LAHTEKAUST" "$nimi"; then
            suurus=$(du -h "$arhiiv" | awk '{print $1}')
            echo "[OK] Varukoopia loodud: $arhiiv ($suurus)"
        else
            echo "[VIGA] Kasutaja '$nimi' varundamine ebaõnnestus!"
        fi
    fi
done

echo "-------------------------------------------"
echo "Valmis! Kõik varukoopiad kaustas $SIHTKAUST:"
ls -lh "$SIHTKAUST"
