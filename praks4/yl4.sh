#!/bin/bash

echo -n "Sisesta esimene sõna: "
read sona1

echo -n "Sisesta teine sõna: "
read sona2

taht1=$(echo "$sona1" | grep -o '.$')
taht2=$(echo "$sona2" | grep -o '.$')

if [ "$taht1" = "$taht2" ]; then
    echo "Mõlema sõna viimane täht on sama"
else
    echo "Mõlema sõna viimane täht ei ole sama"
fi
