#!/bin/bash

# Root kasutaja kontroll
if [ "$(whoami)" != "root" ]; then
    echo "Sul ei ole õigust antud skripti käivitamiseks!"
    exit 1
fi

# Parameetri kontroll
if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 kasutajanimi"
    exit 1
fi

kasutajanimi="$1"

# Kontrolli, kas kasutaja on juba olemas
if getent passwd "$kasutajanimi" >/dev/null 2>&1; then
    echo "Viga: Kasutaja '$kasutajanimi' on juba olemas!"
    exit 1
fi

# Loome kasutaja 
useradd "$kasutajanimi" -m -s /bin/bash
kasu_tulemus=$?

if [ $kasu_tulemus -eq 0 ]; then
    echo "Kasutaja nimega $kasutajanimi on lisatud süsteemi"
    grep "^$kasutajanimi:" /etc/passwd
    ls -la "/home/$kasutajanimi"
else
    echo "Probleem kasutaja $kasutajanimi lisamisega (kood: $kasu_tulemus)"
    exit 1
fi
