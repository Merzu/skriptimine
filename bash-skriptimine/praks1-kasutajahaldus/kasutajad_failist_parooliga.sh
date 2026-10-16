cat << 'EOF' > kasutajad_failist_parooliga.sh
#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo "Sul ei ole õigust antud skripti käivitamiseks!"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 failinimi"
    exit 1
fi

failinimi="$1"

if [ -f "$failinimi" ] && [ -r "$failinimi" ]; then
    echo "fail on korras"
    while IFS= read -r rida || [ -n "$rida" ]; do
        [ -z "$rida" ] && continue
        kasutajanimi=$(echo "$rida" | cut -d: -f1)
        parool=$(echo "$rida" | cut -d: -f2)

        ./lisa_kasutaja.sh "$kasutajanimi"
        if [ $? -eq 0 ]; then
            echo "$kasutajanimi:$parool" | chpasswd
            echo "Kasutajale $kasutajanimi määratud parool."
        fi
    done < "$failinimi"
else
    echo "probleem failiga $failinimi"
    exit 1
fi
EOF
chmod +x kasutajad_failist_parooliga.sh
