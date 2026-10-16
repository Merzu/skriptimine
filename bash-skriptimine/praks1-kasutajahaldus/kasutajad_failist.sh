#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo "Sul ei ole õigust antud skripti käivitamiseks!"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 failinimi"
    exit 1
fi

failinimi="$1"

if [ -f "$failinimi" ] && [ -r "$failinimi" ]; then
    echo "fail on korras"
    while IFS= read -r nimi || [ -n "$nimi" ]; do
        [ -z "$nimi" ] && continue
        ./lisa_kasutaja.sh "$nimi"
    done < "$failinimi"
else
    echo "probleem failiga $failinimi"
    exit 1
fi
