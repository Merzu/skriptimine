#!/bin/bash

# Laadime vajalikud moodulid
source ./files.sh
source ./input.sh
source ./lottery_functions.sh
source ./result.sh

show_header() {
    echo "=================================="
    echo "           LOTO MÄNG              "
    echo "=================================="
    echo ""
}

# --- PROGRAMMI PÕHIOSA ---
show_header
clear_files

# 1. Kasutaja andmed
player_name=$(read_player)
player_numbers=($(read_player_numbers))
save_player_numbers "${player_numbers[@]}"
show_player_numbers "${player_numbers[@]}"

# 2. Loosimine
lottery_numbers=($(generate_lottery_numbers))
save_lottery_numbers "${lottery_numbers[@]}"
show_lottery_numbers "${lottery_numbers[@]}"

# 3. Kontroll ja tulemus
check_matches "${player_numbers[@]}" "${lottery_numbers[@]}"
matches=$?
result_text=$(get_result_text "$matches")

show_summary "$player_name" "$matches" "$result_text"

# 4. Salvestamine
save_result "$player_name" "$matches" "$result_text"
