#!/bin/bash

# Globaalsed muutujad
player_name=""
player_numbers=()
lottery_numbers=()
matches=0
result_text=""

# --- FUNKTSIOONID ---

show_header() {
    echo "=================================="
    echo "           LOTO MÄNG              "
    echo "=================================="
    echo ""
}

clear_files() {
    > player_numbers.txt
    > lottery_numbers.txt
}

read_player() {
    read -p "Sisesta oma nimi: " player_name
    if [ -z "$player_name" ]; then
        player_name="Unknown"
    fi
}

read_player_numbers() {
    echo "Sisesta 5 erinevat numbrit vahemikust 1-50:"
    while [ ${#player_numbers[@]} -lt 5 ]; do
        local current_count=$((${#player_numbers[@]} + 1))
        local input_num
        read -p "Sisesta $current_count. number: " input_num

        # Kontroll: täisarv
        if [[ -z "$input_num" || ! "$input_num" =~ ^[0-9]+$ ]]; then
            echo "Viga: Sisend peab olema täisarv!"
            continue
        fi

        # Kontroll: vahemik 1-50
        if [ "$input_num" -lt 1 ] || [ "$input_num" -gt 50 ]; then
            echo "Viga: Number peab olema vahemikus 1-50!"
            continue
        fi

        # Kontroll: duplikaadid
        local already_selected=0
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

        player_numbers+=("$input_num")
    done

    # Salvestame faili
    for num in "${player_numbers[@]}"; do
        echo "$num" >> player_numbers.txt
    done
}

show_player_numbers() {
    echo ""
    echo "Sinu valitud numbrid:"
    for num in "${player_numbers[@]}"; do
        echo "$num"
    done
    echo ""
}

generate_lottery_numbers() {
    while [ ${#lottery_numbers[@]} -lt 5 ]; do
        local rand_num=$(( RANDOM % 50 + 1 ))
        local is_duplicate=0

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

    # Salvestame faili
    for num in "${lottery_numbers[@]}"; do
        echo "$num" >> lottery_numbers.txt
    done
}

show_lottery_numbers() {
    echo "Loositud võidunumbrid:"
    for num in "${lottery_numbers[@]}"; do
        echo "$num"
    done
    echo ""
}

check_matches() {
    matches=0
    for p_num in "${player_numbers[@]}"; do
        echo "Kontrollin numbrit $p_num..."
        local is_hit=0
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
}

show_result() {
    echo "Mängija: $player_name"
    echo "Tabamusi: $matches/5"

    case $matches in
        5) result_text="JACKPOT!" ;;
        4) result_text="Väga hea tulemus!" ;;
        3) result_text="Hea tulemus." ;;
        2) result_text="Kaks tabamust." ;;
        1) result_text="Üks tabamus." ;;
        0) result_text="Seekord tabamusi ei olnud." ;;
    esac

    echo "Tulemus: $result_text"
    echo ""
}

save_result() {
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
}

# --- PROGRAMMI PÕHIOSA ---
show_header
clear_files
read_player
read_player_numbers
show_player_numbers
generate_lottery_numbers
show_lottery_numbers
check_matches
show_result
save_result
