#!/bin/bash

echo -n "Sisesta suvaline täisarv: "
read arv

jaak=$(($arv % 2))

if [ $jaak -eq 0 ]; then
    echo "Antud arv on paaris"
else
    echo "Antud arv on paaritu"
fi
