cat << 'EOF' > kasutajad_kaks_faili.sh
#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo "Sul ei ole õigust antud skripti käivitamiseks!"
    exit 1
fi

if [ $# -ne 2 ]; then
    echo "Kasutusjuhend: $0 kasutajad_fail paroolid_fail"
    exit 1
fi

kasutajad_fail="$1"
paroolid_fail="$2"

if [ -f "$kasutajad_fail" ] && [ -r "$kasutajad_fail" ] && [ -f "$paroolid_fail" ] && [ -r "$paroolid_fail" ]; then
    echo "failid on korras"
    paste -d: "$kasutajad_fail" "$paroolid_fail" | while IFS=: read -r kasutajanimi parool; do
        [ -z "$kasutajanimi" ] && continue

        if getent passwd "$kasutajanimi" >/dev/null 2>&1; then
            echo "Kasutaja $kasutajanimi on juba olemas!"
            continue
        fi

        useradd "$kasutajanimi" -m -s /bin/bash
        if [ $? -eq 0 ]; then
            echo "$kasutajanimi:$parool" | chpasswd
            echo "Kasutaja $kasutajanimi lisatud ja parool määratud."
        fi
    done
else
    echo "probleem sisendfailidega"
    exit 1
fi
EOF
chmod +x kasutajad_kaks_faili.sh
