#!/bin/bash

clear_files() {
    > player_numbers.txt
    > lottery_numbers.txt
}

save_player_numbers() {
    local numbers=("$@")
    for num in "${numbers[@]}"; do
        echo "$num" >> player_numbers.txt
    done
}

save_lottery_numbers() {
    local numbers=("$@")
    for num in "${numbers[@]}"; do
        echo "$num" >> lottery_numbers.txt
    done
}

save_result() {
    local player_name="$1"
    local matches="$2"
    local result_text="$3"

    {
        echo "Date: $(date)"
        echo "Player: $player_name"
        echo "Player numbers:"
        cat player_numbers.txt
        echo "Lottery numbers:"
        cat lottery_numbers.txt
        echo "Matches: $matches"
        echo "Result: $result_text"
        echo ""
    } >> results.txt
}
