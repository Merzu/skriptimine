#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Käivita skript sudo-ga!"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 kasutajad_fail"
    exit 1
fi

kasutajad_fail="$1"

if [ ! -f "$kasutajad_fail" ]; then
    echo "Viga: Sisendfaili '$kasutajad_fail' ei leitud!"
    exit 1
fi

if ! command -v pwgen >/dev/null 2>&1; then
    echo "Paigaldan pwgen..."
    apt-get update -y >/dev/null 2>&1 && apt-get install -y pwgen >/dev/null 2>&1
fi

logifail="loodud_kasutajad_paroolidega"
echo "Failid on korras, alustan kasutajate lisamist..."

while IFS= read -r kasutajanimi || [ -n "$kasutajanimi" ]; do
    kasutajanimi=$(echo "$kasutajanimi" | tr -d '\r' | xargs)
    [ -z "$kasutajanimi" ] && continue

    if id "$kasutajanimi" >/dev/null 2>&1; then
        echo "Kasutaja '$kasutajanimi' on juba olemas!"
        continue
    fi

    useradd "$kasutajanimi" -m -s /bin/bash
    if [ $? -eq 0 ]; then
        parool=$(pwgen -s 8 1)
        echo "$kasutajanimi:$parool" | chpasswd
        echo "$kasutajanimi $parool" >> "$logifail"
        echo "Kasutaja '$kasutajanimi' lisati süsteemi ja parool salvestati."
    fi
done < "$kasutajad_fail"

echo "Töö valmis! Logifail loodud."
