#!/bin/bash

TEMP_FILE="ajutine_loto.txt"
> "$TEMP_FILE"

while [ $(wc -l < "$TEMP_FILE") -lt 5 ]; do
    nr=$(( (RANDOM % 50) + 1 ))
    
    if ! grep -qx "$nr" "$TEMP_FILE"; then
        echo "$nr" >> "$TEMP_FILE"
    fi
done

numbrid=$(tr '\n' ' ' < "$TEMP_FILE")

rm -f "$TEMP_FILE"

kuupaev=$(TZ='Europe/Tallinn' date +'%d.%m.%Y %H:%M:%S')

tulemus="[$kuupaev] Genereeritud numbrid: $numbrid"

echo "Lotonumbrite genereerimine (1-50)"
echo "1 - Kuva terminalis"
echo "2 - Salvesta faili (loto_tulemused.txt)"
echo -n "Sisesta valik (1 või 2): "
read valik

case $valik in
    1)
        echo ""
        echo "$tulemus"
        ;;
    2)
        echo "$tulemus" >> loto_tulemused.txt
        echo "Tulemus salvestatud faili loto_tulemused.txt"
        ;;
    *)
        echo "Vigane valik."
        ;;
esac
