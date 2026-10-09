#!/usr/bin/env bash

service="$1"

if [ -z "$service" ]; then
    echo "Viga: Teenuse nimi puudub! Kasutus: $0 <teenuse_nimi>"
    exit 1
fi

if systemctl is-active --quiet "$service" 2>/dev/null; then
    echo "Teenus $service töötab."
    exit 0
else
    echo "Teenus $service ei tööta või puudub süsteemist."
    exit 1
fi
