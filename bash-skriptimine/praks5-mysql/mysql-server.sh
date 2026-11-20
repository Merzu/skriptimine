#!/bin/bash
set -e

# Root-õiguste kontroll
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Käivita root-õigustes (sudo $0)"
    exit 1
fi

# Kontrollime mysql-server olemasolu (0 = puudub, 1 = paigaldatud)
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed' || true)

if [ "$MYSQL" -eq 0 ]; then
    echo "Paigaldame Oracle MySQL 8.4 LTS serveri..."
    export DEBIAN_FRONTEND=noninteractive

    # Abipaketid
    apt-get update -y
    apt-get install -y gnupg ca-certificates debconf-utils wget lsb-release

    # Eelseadistame mysql-apt-config (Debian 13 trixie toetab mysql-8.4-lts)
    debconf-set-selections <<< "mysql-apt-config mysql-apt-config/select-server select mysql-8.4-lts"
    debconf-set-selections <<< "mysql-apt-config mysql-apt-config/select-tools select Disabled"
    debconf-set-selections <<< "mysql-apt-config mysql-apt-config/select-product select Ok"

    # Eelseadistame MySQL root-parooli (qwerty)
    debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password qwerty"
    debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password qwerty"

    # Laeme alla ja paigaldame MySQL APT seadistuspaki
    DEB_URL="https://dev.mysql.com/get/mysql-apt-config_0.8.40-1_all.deb"
    wget -O /tmp/mysql-apt-config.deb "$DEB_URL"
    dpkg -i /tmp/mysql-apt-config.deb
    rm -f /tmp/mysql-apt-config.deb

    # Paigaldame ja käivitame MySQL serveri
    apt-get update -y
    apt-get install -y mysql-server
    systemctl enable --now mysql

    echo "Valmis: Oracle MySQL on paigaldatud. Root-parool: qwerty"
    mysql --version
else
    echo "mysql-server on juba paigaldatud"
    systemctl start mysql
    systemctl status mysql --no-pager
    mysql --version
fi
