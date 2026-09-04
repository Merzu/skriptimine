#!/bin/bash
# Skript väljastab tervituse (esitäht suurega ja ilma tühikuta hüüumärgi ees) ilma muutujaid kasutamata

# 1. Väljasta "Tere, " ilma reavahetuseta
echo -n "Tere, "

# 2. Väljasta kasutajanimi suure algustähega ja ilma reavahetuseta
whoami | sed 's/./\U&/' | tr -d '\n'

# 3. Väljasta "!" koos reavahetusega
echo "!"
