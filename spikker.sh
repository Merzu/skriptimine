#!/bin/bash

# Värvid parema loetavuse jaoks
BOLD='\033[1m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Värvi lähtestamine

echo -e "${BOLD}${YELLOW}==================================================${NC}"
echo -e "${BOLD}${YELLOW}          🐚 BASH / SHELLI LÜHISPIKKER 🐚          ${NC}"
echo -e "${BOLD}${YELLOW}==================================================${NC}"

echo -e "\n${BOLD}${BLUE}1. NAVIGEERIMINE${NC}"
echo -e "  ${GREEN}pwd${NC}              - Näita praegust kausta (Print Working Directory)"
echo -e "  ${GREEN}ls -la${NC}           - Loetle kõik failid (sh peidetud) detailidega"
echo -e "  ${GREEN}cd <kaust>${NC}       - Mine kausta (${GREEN}cd ..${NC} tase üles, ${GREEN}cd ~${NC} kodukaust)"

echo -e "\n${BOLD}${BLUE}2. FAILID JA KAUSTAD${NC}"
echo -e "  ${GREEN}mkdir <nimi>${NC}     - Loo uus kaust"
echo -e "  ${GREEN}touch <nimi>${NC}     - Loo tühi fail"
echo -e "  ${GREEN}cp -r <kust> <kuhu>${NC}- Kopeeri (kaustade jaoks kasuta -r)"
echo -e "  ${GREEN}mv <kust> <kuhu>${NC}- Teisalda või nimeta ümber"
echo -e "  ${GREEN}rm -rf <nimi>${NC}    - Kustuta fail/kaust (ettevaatust!)"

echo -e "\n${BOLD}${BLUE}3. FAILIDE VAATAMINE ENNISTUSTETA${NC}"
echo -e "  ${GREEN}cat <fail>${NC}       - Kuva faili kogu sisu ekraanile"
echo -e "  ${GREEN}less <fail>${NC}      - Vaata faili lehekülje kaupa (väljumiseks press 'q')"
echo -e "  ${GREEN}head -n 10${NC}       - Näita esimest 10 rida"
echo -e "  ${GREEN}tail -f <fail>${NC}   - Jälgi faili lõppu reaalajas (logide jaoks)"

echo -e "\n${BOLD}${BLUE}4. OTSING JA SUUNAMINE${NC}"
echo -e "  ${GREEN}grep \"tekst\" <fail>${NC}- Otsi failist konkreetset teksti"
echo -e "  ${GREEN}find . -name \"*.txt\"${NC}- Otsi praegusest kaustast .txt faile"
echo -e "  ${GREEN}käsk1 | käsk2${NC}    - Torustik (pipe): saada käsk1 väljund käsk2 sisendiks"
echo -e "  ${GREEN}käsk > fail${NC}      - Kirjuta väljund faili (kirjutab üle)"
echo -e "  ${GREEN}käsk >> fail${NC}     - Lisa väljund faili lõppu"

echo -e "\n${BOLD}${BLUE}5. SÜSTEEM JA ÕIGUSED${NC}"
echo -e "  ${GREEN}chmod +x <fail>${NC}  - Tee fail käivitatavaks"
echo -e "  ${GREEN}sudo <käsk>${NC}      - Käivita admini (root) õigustes"
echo -e "  ${GREEN}df -h${NC}            - Kontrolli ketta vaba ruumi"
echo -e "  ${GREEN}top${NC} / ${GREEN}htop${NC}        - Jälgi ressursikasutust ja protsesse"

echo -e "\n${BOLD}${CYAN}6. SKRIPTI KIRJUTAMINE JA MUUTUJAD (\$)${NC}"
echo -e "  ${GREEN}VAR=\"väärtus\"${NC}    - Muutuja määramine (NB! ilma tühikuteta ümber '='!)"
echo -e "  ${GREEN}\$VAR${NC} või ${GREEN}\${VAR}${NC}   - Muutuja väärtuse lugemine/kasutamine"
echo -e "  ${GREEN}\$(käsk)${NC}          - Käsu tulemuse salvestamine muutujasse (nt: DATUM=\$(date))"
echo -e "  ${GREEN}\$0${NC}               - Skripti enda nimi / käivitamistee"
echo -e "  ${GREEN}\$1, \$2, \$3 ...${NC}   - Skriptile kaasa antud argumentid (esimene, teine jne)"
echo -e "  ${GREEN}\$#${NC}               - Argumentide koguarv"
echo -e "  ${GREEN}\$@${NC}               - Kõik argumendid eraldi nimekirjana"
echo -e "  ${GREEN}\$?${NC}               - Viimati käivitatud käsu tagastuskood (0 = edu/korras)"
echo -e "  ${GREEN}\$\$${NC}               - Käesoleva skripti/protsessi ID (PID)"

echo -e "\n${BOLD}${CYAN}7. TINGIMUSED JA TSÜKLID (LOGIKA)${NC}"
echo -e "  ${GREEN}if [ \$VAR -eq 5 ]; then ... fi${NC}   - Arvude võrdlus (-eq, -ne, -lt, -gt)"
echo -e "  ${GREEN}if [ \"\$VAR\" == \"tere\" ]; then ... fi${NC} - Teksti võrdlus"
echo -e "  ${GREEN}if [ -f \"fail.txt\" ]; then ... fi${NC} - Kontrolli, kas fail on olemas (-d = kaust)"
echo -e "  ${GREEN}for i in 1 2 3; do ... done${NC}      - For-tsükkel"
echo -e "  ${GREEN}while [ ... ]; do ... done${NC}       - While-tsükkel"

echo -e "\n${BOLD}${YELLOW}💡 KASULIKUD KLAVIATUURIOTSETEED:${NC}"
echo -e "  ${BOLD}Tab${NC}              - Automaatne nime täiendus"
echo -e "  ${BOLD}Ctrl + C${NC}         - Katkesta praegu töötav käsk"
echo -e "  ${BOLD}Ctrl + R${NC}         - Otsi varem sisestatud käskude ajaloost"
echo -e "  ${GREEN}history${NC}          - Vaata kõigi varem sisestatud käskude nimekirja"
echo -e "${BOLD}${YELLOW}==================================================${NC}\n"
