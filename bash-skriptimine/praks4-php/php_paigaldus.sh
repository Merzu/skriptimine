#!/bin/bash

# Root-õiguste kontroll
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Käivita root-õigustes (sudo $0)"
    exit 1
fi

# Kontrollime php olemasolu
PHP=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c 'ok installed')

# Kui php puudub, paigaldame php koos Apache ja MySQL toega
if [ "$PHP" -eq 0 ]; then
    echo "Paigaldame php ja vajalikud lisad"
    apt-get update -y && apt-get install -y php libapache2-mod-php php-mysql
    # Peatame teised veebiserverid ja taaskäivitame Apache
    systemctl stop nginx lighttpd caddy 2>/dev/null
    systemctl restart apache2
    echo "php on paigaldatud"

# Kui php on olemas, siis anname sellest teada
elif [ "$PHP" -eq 1 ]; then
    echo "php on juba paigaldatud"
    which php
    php -v | head -n 1
fi
