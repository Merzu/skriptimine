#!/bin/bash

# 1. Loome või tühjendame vajalikud failid
> player_numbers.txt
> lottery_numbers.txt

# 2. Küsime mängija nime (kui tühjaks jäetakse, kasuta "Unknown")
read -p "Sisesta oma nimi: " player_name
if [ -z "$player_name" ]; then
    player_name="Unknown"
fi

# 3, 4 & 5. Küsimine ja valideerimine (5 erinevat numbrit vahemikus 1-50)
echo "Sisesta 5 erinevat numbrit vahemikust 1-50:"
player_numbers=()

while [ ${#player_numbers[@]} -lt 5 ]; do
    current_count=$((${#player_numbers[@]} + 1))
    read -p "Sisesta $current_count. number: " input_num

    # Kontroll: kas midagi sisestati ja kas tegemist on täisarvuga
    if [[ -z "$input_num" || ! "$input_num" =~ ^[0-9]+$ ]]; then
        echo "Viga: Sisend peab olema täisarv!"
        continue
    fi

    # Kontroll: kas on vahemikus 1-50
    if [ "$input_num" -lt 1 ] || [ "$input_num" -gt 50 ]; then
        echo "Viga: Number peab olema vahemikus 1-50!"
        continue
    fi

    # Kontroll: kas number on juba varem valitud
    already_selected=0
    for num in "${player_numbers[@]}"; do
        if [ "$num" -eq "$input_num" ]; then
            already_selected=1
            break
        fi
    done

    if [ "$already_selected" -eq 1 ]; then
        echo "Viga: Oled selle numbri juba sisestanud!"
        continue
    fi

    # Kui kõik kontrollid läbitud, lisame numbri nimekirja
    player_numbers+=("$input_num")
done

# 6. Salvestame mängija numbrid faili player_numbers.txt
for num in "${player_numbers[@]}"; do
    echo "$num" >> player_numbers.txt
done

# 7. Kuvame mängija valitud numbrid
echo ""
echo "Sinu valitud numbrid:"
for num in "${player_numbers[@]}"; do
    echo "$num"
done
echo ""

# LOOSIMINE: 5 erinevat juhuslikku numbrit vahemikus 1-50
lottery_numbers=()

while [ ${#lottery_numbers[@]} -lt 5 ]; do
    rand_num=$(( RANDOM % 50 + 1 ))

    # Kontrollime duplikaate
    is_duplicate=0
    for num in "${lottery_numbers[@]}"; do
        if [ "$num" -eq "$rand_num" ]; then
            is_duplicate=1
            break
        fi
    done

    if [ "$is_duplicate" -eq 0 ]; then
        lottery_numbers+=("$rand_num")
    fi
done

# Salvestame loositud numbrid faili lottery_numbers.txt
for num in "${lottery_numbers[@]}"; do
    echo "$num" >> lottery_numbers.txt
done

# Kuvame loositud võidunumbrid
echo "Loositud võidunumbrid:"
for num in "${lottery_numbers[@]}"; do
    echo "$num"
done
echo ""

# TULEMUSE KONTROLLIMINE
matches=0
for p_num in "${player_numbers[@]}"; do
    echo "Kontrollin numbrit $p_num..."
    is_hit=0
    for l_num in "${lottery_numbers[@]}"; do
        if [ "$p_num" -eq "$l_num" ]; then
            is_hit=1
            break
        fi
    done

    if [ "$is_hit" -eq 1 ]; then
        echo "TABAMUS!"
        matches=$((matches + 1))
    else
        echo "Ei tabanud."
    fi
done

echo ""
echo "Mängija: $player_name"
echo "Tabamusi: $matches/5"

# Hinnangu määramine vastavalt tabamustele
case $matches in
    5) result_text="JACKPOT!" ;;
    4) result_text="Väga hea tulemus!" ;;
    3) result_text="Hea tulemus." ;;
    2) result_text="Kaks tabamust." ;;
    1) result_text="Üks tabamus." ;;
    0) result_text="Seekord tabamusi ei olnud." ;;
esac

echo "Tulemus: $result_text"

# TULEMUSTE SALVESTAMINE (lisamine faili results.txt)
{
    echo "Date: $(date)"
    echo "Player: $player_name"
    echo "Player numbers:"
    for num in "${player_numbers[@]}"; do
        echo "$num"
    done
    echo "Lottery numbers:"
    for num in "${lottery_numbers[@]}"; do
        echo "$num"
    done
    echo "Matches: $matches"
    echo "Result: $result_text"
    echo ""
} >> results.txt
