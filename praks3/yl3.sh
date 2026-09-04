#!/bin/bash
# Skripti eesmärk: Arvutab täidetud busside ja maha jäänud inimeste arvu[cite: 1].

echo -n "Mitu reisijat on grupis: "
read reisijad

echo -n "Mitu kohta on bussis: "
read kohtade_arv

bussid=$(expr $reisijad / $kohtade_arv)
maha_jaanud=$(expr $reisijad % $kohtade_arv)

echo "Täielikult täidetud busse: $bussid"
echo "Maha jäänud inimesi: $maha_jaanud"
