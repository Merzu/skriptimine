#!/bin/bash

# Värvikoodid
PUNANE='\033[0;31m'
ROHELINE='\033[0;32m'
RESET='\033[0m'

# 1. Marsruudi valimine
echo "ELRONI RONGIINFO"
echo ""
echo "Vali marsruut:"
echo ""
echo "1 - Tartu → Tallinn"
echo "2 - Tartu → Valga"
echo "3 - Tartu → Koidula"
echo ""
echo -n "Sisesta valik: "
read valik

# 2. Kontrolli kasutaja sisendit
if [ -z "$valik" ]; then
    echo "Valik jäi sisestamata."
    exit 1
fi

case $valik in
    1)
        lahtejaam="Tartu"
        sihtjaam="Tallinn"
        ;;
    2)
        lahtejaam="Tartu"
        sihtjaam="Valga"
        ;;
    3)
        lahtejaam="Tartu"
        sihtjaam="Koidula"
        ;;
    *)
        echo "Vigane valik. Sellist marsruuti ei ole."
        exit 1
        ;;
esac

# 3. Küsi andmed Elroni API-st
api_vastus=$(wget -qO- "https://elron.ee/live-map/stop/$lahtejaam")

if [ $? -ne 0 ] || [ -z "$api_vastus" ]; then
    echo "Elroni API päring ebaõnnestus."
    exit 1
fi

# 4. ja 5. Filtreeri vajalikud rongid
filtreeritud=$(echo "$api_vastus" | grep -o '{[^}]*}' | grep "\"sihtjaam\":\"$sihtjaam\"")

# 6. Kontrolli, kas sobivaid ronge leiti
if [ -z "$filtreeritud" ]; then
    echo "Sobivaid ronge ei leitud."
    exit 1
fi

# 7. Leia rongide väljumisajad
ajad=$(echo "$filtreeritud" | grep -o '"plaaniline_aeg":"[0-9:]*"' | cut -d'"' -f4)

# 8. Leia praegune kuupäev ja kellaaeg (Eesti ajavööndis)
praegune_kuupaev=$(TZ='Europe/Tallinn' date +%d.%m.%Y)
praegune_aeg=$(TZ='Europe/Tallinn' date +%H:%M)

echo ""
echo "$lahtejaam → $sihtjaam"
echo "Kuupäev: $praegune_kuupaev"
echo "Praegune kellaaeg: $praegune_aeg"
echo ""
echo "Väljumised:"
echo ""

# 9. ja 10. Kontrolli väljumisaegu (kontrollime kuni 10 rongi)

aeg1=$(echo "$ajad" | sed -n '1p')
if [ -n "$aeg1" ]; then
    if [[ "$aeg1" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg1}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg1}  rong on veel ees${RESET}"
    fi
fi

aeg2=$(echo "$ajad" | sed -n '2p')
if [ -n "$aeg2" ]; then
    if [[ "$aeg2" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg2}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg2}  rong on veel ees${RESET}"
    fi
fi

aeg3=$(echo "$ajad" | sed -n '3p')
if [ -n "$aeg3" ]; then
    if [[ "$aeg3" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg3}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg3}  rong on veel ees${RESET}"
    fi
fi

aeg4=$(echo "$ajad" | sed -n '4p')
if [ -n "$aeg4" ]; then
    if [[ "$aeg4" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg4}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg4}  rong on veel ees${RESET}"
    fi
fi

aeg5=$(echo "$ajad" | sed -n '5p')
if [ -n "$aeg5" ]; then
    if [[ "$aeg5" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg5}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg5}  rong on veel ees${RESET}"
    fi
fi

aeg6=$(echo "$ajad" | sed -n '6p')
if [ -n "$aeg6" ]; then
    if [[ "$aeg6" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg6}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg6}  rong on veel ees${RESET}"
    fi
fi

aeg7=$(echo "$ajad" | sed -n '7p')
if [ -n "$aeg7" ]; then
    if [[ "$aeg7" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg7}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg7}  rong on veel ees${RESET}"
    fi
fi

aeg8=$(echo "$ajad" | sed -n '8p')
if [ -n "$aeg8" ]; then
    if [[ "$aeg8" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg8}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg8}  rong on veel ees${RESET}"
    fi
fi

aeg9=$(echo "$ajad" | sed -n '9p')
if [ -n "$aeg9" ]; then
    if [[ "$aeg9" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg9}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg9}  rong on veel ees${RESET}"
    fi
fi

aeg10=$(echo "$ajad" | sed -n '10p')
if [ -n "$aeg10" ]; then
    if [[ "$aeg10" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}${aeg10}  rong on juba väljunud${RESET}"
    else
        echo -e "${ROHELINE}${aeg10}  rong on veel ees${RESET}"
    fi
fi
