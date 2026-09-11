#!/bin/bash

while true; do
    echo -n "Sisesta number (0 lõpetab): "
    read nr

    if [ $nr -eq 0 ]; then
        break
    fi

    if [ $nr -lt 0 ]; then
        continue
    fi

    echo "Sisestati positiivne number: $nr"
done

