#!/usr/bin/env bash

HOST="${1:-google.com}"

echo "=== Võrgu ühenduse kontroll ($HOST) ==="

if ping -c 1 -W 2 "$HOST" >/dev/null 2>&1; then
    echo "Ühendus serveriga $HOST toimib (OK)."
    exit 0
else
    echo "VIGA: Serveriga $HOST ei saa ühendust!"
    exit 1
fi
