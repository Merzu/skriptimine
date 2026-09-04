#!/bin/bash

echo -n "Mitu reisijat on grupis: "
read reisijad

echo -n "Mitu kohta on bussis: "
read kohtade_arv

bussid=$(expr $reisijad / $kohtade_arv)
maha_jaanud=$(expr $reisijad % $kohtade_arv)

echo "Täielikult täidetud busse: $bussid"
echo "Maha jäänud inimesi: $maha_jaanud"
