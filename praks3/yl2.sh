#!/bin/bash

echo -n "Sisesta aluskandiku pikkus (cm): "
read kandik_pikkus

echo -n "Sisesta aluskandiku laius (cm): "
read kandik_laius

echo -n "Sisesta ühe küpsise pikkus (cm): "
read kypsis_pikkus

echo -n "Sisesta ühe küpsise laius (cm): "
read kypsis_laius

echo -n "Mitu kihti tordil on: "
read kihte

echo -n "Mitu küpsist on ühes pakis: "
read kypsiseid_pakis

# Expr 
pikkusesse=$(expr $kandik_pikkus / $kypsis_pikkus)
laiusesse=$(expr $kandik_laius / $kypsis_laius)
kypsiseid_kihis=$(expr $pikkusesse \* $laiusesse)
kypsised_kokku=$(expr $kypsiseid_kihis \* $kihte)

pakkide_arv=$(expr \( $kypsised_kokku + $kypsiseid_pakis - 1 \) / $kypsiseid_pakis)

echo "Tordi jaoks on vaja kokku $kypsised_kokku küpsist."
echo "Poest tuleb osta $pakkide_arv pakki küpsiseid."
