#!/bin/bash
# Skript väljastab tervituse koos kasutajanimega .

# 1. Väljasta "Tere, " ilma reavahetuseta
echo -n "Tere, "

# 2. Tekita muutuja kasutaja nimega ning muuda esitäht suureks
kasutaja=$(whoami)
kasutaja=${kasutaja^}
echo -n "$kasutaja"

# 3. Väljasta "!" koos reavahetusega
echo "!"
