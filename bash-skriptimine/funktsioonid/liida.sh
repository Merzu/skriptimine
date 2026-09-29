#!/bin/bash

liida() {
    # Kontrollime, kas funktsioonile anti täpselt 2 argumenti
    if [ $# -ne 2 ]; then
        echo "Viga: sisesta kaks arvu!"
        return 1
    fi

    local a="$1"
    local b="$2"

    echo $((a + b))
}

# Kontrollime käsurea argumente
if [ $# -ne 2 ]; then
    echo "Kasutamine: $0 <arv1> <arv2>"
    exit 1
fi

tulemus=$(liida "$1" "$2")
if [ $? -eq 0 ]; then
    echo "Tulemus: $tulemus"
fi
