#!/usr/bin/env bash

echo "======================================================"
echo "          SÜSTEEMI VÕRGU DIAGNOSTIKA RAPORT"
echo "======================================================"
echo "Kuupäev: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Seade:   $(hostname)"
echo "------------------------------------------------------"

# 1. VÕRGULIIDESED JA NENDE OLEK
echo -e "\n[1] Võrguliidesed ja staatus:"
if command -v ip >/dev/null 2>&1; then
    ip -br link show
else
    ifconfig -a | grep -E "^[a-z0-9]+"
fi

# 2. KOHALIKUD IP-AADRESSID
echo -e "\n[2] Kohalikud IP-aadressid:"
if command -v ip >/dev/null 2>&1; then
    ip -br addr show | grep -v "127.0.0.1"
else
    hostname -I
fi

# 3. VAIKELÜÜS (DEFAULT GATEWAY) JA SELLE KÄTTESAADAVUS
echo -e "\n[3] Vaikelüüs (Gateway) ja ühenduse kontroll:"
GATEWAY=$(ip route 2>/dev/null | grep default | awk '{print $3}' | head -n 1)

if [ -n "$GATEWAY" ]; then
    echo "  Tuvastatud vaikelüüs: $GATEWAY"
    if ping -c 2 -W 2 "$GATEWAY" >/dev/null 2>&1; then
        echo "  [OK] Ühendus vaikelüüsiga ($GATEWAY) toimib."
    else
        echo "  [VIGA] Vaikelüüs ($GATEWAY) ei vasta pingile!"
    fi
else
    echo "  [HOIATUS] Vaikelüüsi ei leitud!"
fi

# 4. INTERNETI OTSEÜHENDUS (IP TASEMEL)
echo -e "\n[4] Internetiühendus (IP tase - Cloudflare 1.1.1.1):"
TEST_IP="1.1.1.1"
if ping -c 2 -W 2 "$TEST_IP" >/dev/null 2>&1; then
    echo "  [OK] Otseühendus välise IP-ga ($TEST_IP) toimib."
else
    echo "  [VIGA] Välise IP-ga ($TEST_IP) puudub ühendus!"
fi

# 5. DNS SERVERID JA DOMEENINIMEDE LAHENDAMINE
echo -e "\n[5] DNS ja domeeninimede lahendamine:"
if [ -f /etc/resolv.conf ]; then
    DNS_SERVERS=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | xargs)
    echo "  Kasutusel DNS serverid: $DNS_SERVERS"
fi

TEST_DOMAIN="google.com"
if ping -c 2 -W 2 "$TEST_DOMAIN" >/dev/null 2>&1; then
    echo "  [OK] DNS nimeseostamine toimib ($TEST_DOMAIN lahendatakse)."
else
    echo "  [VIGA] DNS ei lahenda domeeninime ($TEST_DOMAIN)!"
fi

# 6. KUULATAVAD VÕRGUPORDID JA TEENUSED
echo -e "\n[6] Avatud ja kuulatavad võrgupordid:"
if command -v ss >/dev/null 2>&1; then
    ss -tuln | head -n 12
elif command -v netstat >/dev/null 2>&1; then
    netstat -tuln | head -n 12
else
    echo "  ss või netstat tööriist puudub."
fi

echo "------------------------------------------------------"
echo "Võrgukontroll lõpetatud."
echo "======================================================"
