#!/bin/bash

# Root-õiguste kontroll
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Käivita root-õigustes (sudo $0)"
    exit 1
fi

# Kontrollime apache2 olemasolu
APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')

# Kui pole paigaldatud, paigaldame
if [ "$APACHE2" -eq 0 ]; then
    echo "Paigaldame apache2"
    apt-get update -y && apt-get install -y apache2
    echo "Apache on paigaldatud"

# Kui on paigaldatud, käivitame ja näitame staatust
elif [ "$APACHE2" -eq 1 ]; then
    echo "apache2 on juba paigaldatud"
    service apache2 start
    service apache2 status --no-pager
fi
