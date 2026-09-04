#!/bin/bash
# Skript väljastab praeguse kuupäeva, kellaaja ja käesoleva kuu kalendri

# 1. Kuupäeva ja kellaaja väljastamine
date +"Today is %A, %B %d, %Y"
date +"Time is %H:%M"

# Tühi rida vahele
echo ""

# 2. Kalendri pealkiri ja päevade tabel
date +"Calendar of %B %Y"
cal | tail -n 7
