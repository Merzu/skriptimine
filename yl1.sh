#!/bin/bash
# Skript kirjutab tervituse sisselogitud kasutajale

# 1. Väljasta "Tere, " 
echo -n "Tere, "

# 2. Tekita muutuja kasutaja nimega ning väljasta see.
kasutaja=$(whoami)
echo -n "$kasutaja"

# 3. Väljasta " !" koos reavahetusega
echo " !"
