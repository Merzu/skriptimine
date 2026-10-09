#!/usr/bin/env bash

username="$1"

if [ -z "$username" ]; then
    echo "Viga: Kasutajanimi puudub! Kasutus: $0 <kasutajanimi>"
    exit 1
fi

if getent passwd "$username" >/dev/null 2>&1; then
    echo "Kasutaja $username eksisteerib."
    exit 0
else
    echo "Kasutajat $username ei leitud."
    exit 1
fi
