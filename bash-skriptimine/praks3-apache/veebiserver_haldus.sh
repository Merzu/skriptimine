#!/bin/bash

# Root-õiguste kontroll
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Käivita skript root-õigustes (sudo $0)"
    exit 1
fi

# Värvid väljundi jaoks
ROHELINE='\033[0;32m'
PUNANE='\033[0;31m'
KOLLANE='\033[1;33m'
SININE='\033[0;36m'
LOPP='\033[0m'

PAKK=""
TEENUS=""

# Kontrollib, kas pakk on paigaldatud (0 või 1)
on_paigaldatud() {
    dpkg-query -W -f='${Status}' "$PAKK" 2>/dev/null | grep -c 'ok installed'
}

# Kontrollib pordi 80 hõivatust teise teenuse poolt
kontrolli_porti() {
    if ss -tulpn | grep -q ':80 '; then
        if ! systemctl is-active --quiet "$TEENUS"; then
            echo -e "${KOLLANE}Hoiatus: Port 80 on juba teise teenuse poolt hõivatud!${LOPP}"
            ss -tulpn | grep ':80 '
            read -rp "Kas peatame teised veebiserverid enne käivitamist? (j/e): " VASTUS
            if [[ "$VASTUS" =~ ^[jJyY]$ ]]; then
                for srv in apache2 nginx lighttpd caddy; do
                    [ "$srv" != "$TEENUS" ] && systemctl stop "$srv" 2>/dev/null
                done
                echo -e "${ROHELINE}Konfliktsed teenused peatatud.${LOPP}"
            fi
        fi
    fi
}

# Paigaldab teenuse või kuvab olemasoleva staatuse
paigalda_voi_kontrolli() {
    local STAATUS
    STAATUS=$(on_paigaldatud)

    if [ "$STAATUS" -eq 0 ]; then
        if ! apt-cache show "$PAKK" >/dev/null 2>&1; then
            echo -e "${PUNANE}Viga: Paketti '$PAKK' ei leitud repositooriumist!${LOPP}"
            return 1
        fi
        echo -e "${SININE}Paigaldame teenuse: $PAKK...${LOPP}"
        apt-get update -y && apt-get install -y "$PAKK"
        kontrolli_porti
        systemctl enable --now "$TEENUS" 2>/dev/null
        echo -e "${ROHELINE}$PAKK on paigaldatud ja käivitatud.${LOPP}"
    else
        echo -e "${ROHELINE}$PAKK on juba paigaldatud.${LOPP}"
        kontrolli_porti
        systemctl start "$TEENUS" 2>/dev/null
        systemctl status "$TEENUS" --no-pager -l
    fi
}

# Teenuse käivitamine, peatamine või taaskäivitamine
juhi_teenust() {
    local TEGEVUS="$1"
    if [ "$(on_paigaldatud)" -eq 0 ]; then
        echo -e "${PUNANE}Teenus '$PAKK' pole veel paigaldatud!${LOPP}"
        return
    fi
    [ "$TEGEVUS" = "start" ] && kontrolli_porti
    systemctl "$TEGEVUS" "$TEENUS"
    echo -e "${ROHELINE}Käsk 'systemctl $TEGEVUS $TEENUS' täidetud.${LOPP}"
}

# Kuvab teenuse oleku ja kuulatavad pordid
kuva_staatus() {
    if [ "$(on_paigaldatud)" -eq 0 ]; then
        echo -e "${PUNANE}Teenus '$PAKK' pole paigaldatud.${LOPP}"
        return
    fi
    systemctl status "$TEENUS" --no-pager -l
    echo -e "\n${SININE}Aktiivsed veebiportide ühendused:${LOPP}"
    ss -tulpn | grep -E ':80|:443' || echo "Ükski teenus ei kuula porte 80/443."
}

# Testib HTTP vastust ja näitab serveri IP-aadressi
testi_veebi() {
    local IP
    IP=$(hostname -I | awk '{print $1}')
    echo -e "${SININE}Serveri IP-aadress:${LOPP} http://${IP:-localhost}"
    if command -v curl >/dev/null 2>&1; then
        echo -e "${SININE}HTTP päise vastus (localhost):${LOPP}"
        curl -sI http://localhost | head -n 5 || echo -e "${PUNANE}Veebiserver ei vasta pordil 80.${LOPP}"
    else
        echo "Paigalda 'curl' HTTP päringu testimiseks (apt install -y curl)."
    fi
}

# Eemaldab veebiserveri täielikult
eemalda_server() {
    if [ "$(on_paigaldatud)" -eq 0 ]; then
        echo -e "${KOLLANE}'$PAKK' ei ole paigaldatud.${LOPP}"
        return
    fi
    read -rp "Kas oled kindel, et soovid '$PAKK' täielikult eemaldada? (j/e): " KINNITUS
    if [[ "$KINNITUS" =~ ^[jJyY]$ ]]; then
        systemctl stop "$TEENUS" 2>/dev/null
        apt-get purge -y "$PAKK" && apt-get autoremove -y
        echo -e "${ROHELINE}$PAKK on süsteemist eemaldatud.${LOPP}"
    fi
}

# Veebiserveri valiku menüü
vali_server() {
    while true; do
        echo -e "\n${SININE}=== VALI VEEBISERVER ===${LOPP}"
        echo "1) Apache2  (apache2)"
        echo "2) Nginx    (nginx)"
        echo "3) Lighttpd (lighttpd)"
        echo "4) Caddy    (caddy)"
        echo "5) Muu      (sisesta paki nimi käsitsi)"
        echo "0) Välju"
        read -rp "Valik [0-5]: " VALIK

        case "$VALIK" in
            1) PAKK="apache2";  TEENUS="apache2";  return ;;
            2) PAKK="nginx";    TEENUS="nginx";    return ;;
            3) PAKK="lighttpd"; TEENUS="lighttpd"; return ;;
            4) PAKK="caddy";    TEENUS="caddy";    return ;;
            5)
                read -rp "Sisesta veebiserveri paki nimi: " CUSTOM
                if [[ "$CUSTOM" =~ ^[a-zA-Z0-9._+-]+$ ]]; then
                    PAKK="$CUSTOM"
                    read -rp "Sisesta teenuse nimi [vaikimisi $PAKK]: " CUSTOM_SRV
                    TEENUS="${CUSTOM_SRV:-$PAKK}"
                    return
                else
                    echo -e "${PUNANE}Vigane paki nimi!${LOPP}"
                fi
                ;;
            0) exit 0 ;;
            *) echo -e "${PUNANE}Tundmatu valik!${LOPP}" ;;
        esac
    done
}

# Põhimenüü
vali_server
while true; do
    if [ "$(on_paigaldatud)" -eq 1 ]; then
        OLEK="${ROHELINE}PAIGALDATUD${LOPP}"
    else
        OLEK="${PUNANE}POLE PAIGALDATUD${LOPP}"
    fi

    echo -e "\n${SININE}=========================================${LOPP}"
    echo -e "Valitud server: ${KOLLANE}$PAKK${LOPP} ($OLEK)"
    echo -e "${SININE}=========================================${LOPP}"
    echo "1) Paigalda / Kontrolli staatust"
    echo "2) Käivita teenus (start)"
    echo "3) Peata teenus (stop)"
    echo "4) Taaskäivita teenus (restart)"
    echo "5) Kuva detailne staatus ja pordid"
    echo "6) Testi veebilehte (IP ja HTTP vastus)"
    echo "7) Eemalda veebiserver (purge)"
    echo "8) Vali teine veebiserver"
    echo "0) Välju"
    read -rp "Vali tegevus [0-8]: " TEGEVUS

    case "$TEGEVUS" in
        1) paigalda_voi_kontrolli ;;
        2) juhi_teenust "start" ;;
        3) juhi_teenust "stop" ;;
        4) juhi_teenust "restart" ;;
        5) kuva_staatus ;;
        6) testi_veebi ;;
        7) eemalda_server ;;
        8) vali_server ;;
        0) exit 0 ;;
        *) echo -e "${PUNANE}Tundmatu valik!${LOPP}" ;;
    esac
done
