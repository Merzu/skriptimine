#!/bin/bash

check_matches() {
    local p_numbers=("${@:1:5}")
    local l_numbers=("${@:6:5}")
    local matches=0

    for p_num in "${p_numbers[@]}"; do
        echo "Kontrollin numbrit $p_num..."
        local is_hit=0
        for l_num in "${l_numbers[@]}"; do
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

    return $matches
}

get_result_text() {
    local matches="$1"
    case $matches in
        5) echo "JACKPOT!" ;;
        4) echo "Väga hea tulemus!" ;;
        3) echo "Hea tulemus." ;;
        2) echo "Kaks tabamust." ;;
        1) echo "Üks tabamus." ;;
        0) echo "Seekord tabamusi ei olnud." ;;
    esac
}

show_summary() {
    local player_name="$1"
    local matches="$2"
    local result_text="$3"

    echo ""
    echo "Mängija: $player_name"
    echo "Tabamusi: $matches/5"
    echo "Tulemus: $result_text"
    echo ""
}
