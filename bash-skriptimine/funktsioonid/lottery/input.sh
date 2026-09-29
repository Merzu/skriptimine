#!/bin/bash

read_player() {
    local name
    read -p "Sisesta oma nimi: " name
    if [ -z "$name" ]; then
        name="Unknown"
    fi
    echo "$name"
}

is_valid_number() {
    local input="$1"
    shift
    local existing=("$@")

    # Kontroll: kas on täisarv
    if [[ -z "$input" || ! "$input" =~ ^[0-9]+$ ]]; then
        echo "Viga: Sisend peab olema täisarv!" >&2
        return 1
    fi

    # Kontroll: vahemik 1-50
    if [ "$input" -lt 1 ] || [ "$input" -gt 50 ]; then
        echo "Viga: Number peab olema vahemikus 1-50!" >&2
        return 1
    fi

    # Kontroll: duplikaadid
    for num in "${existing[@]}"; do
        if [ "$num" -eq "$input" ]; then
            echo "Viga: Oled selle numbri juba sisestanud!" >&2
            return 1
        fi
    done

    return 0
}

read_player_numbers() {
    local numbers=()
    echo "Sisesta 5 erinevat numbrit vahemikust 1-50:" >&2

    while [ ${#numbers[@]} -lt 5 ]; do
        local current_count=$((${#numbers[@]} + 1))
        local input_num
        read -p "Sisesta $current_count. number: " input_num

        if is_valid_number "$input_num" "${numbers[@]}"; then
            numbers+=("$input_num")
        fi
    done

    echo "${numbers[@]}"
}

show_player_numbers() {
    local numbers=("$@")
    echo ""
    echo "Sinu valitud numbrid:"
    for num in "${numbers[@]}"; do
        echo "$num"
    done
    echo ""
}
