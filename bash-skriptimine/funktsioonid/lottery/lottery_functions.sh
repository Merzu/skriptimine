#!/bin/bash

generate_lottery_numbers() {
    local numbers=()

    while [ ${#numbers[@]} -lt 5 ]; do
        local rand_num=$(( RANDOM % 50 + 1 ))
        local is_duplicate=0

        for num in "${numbers[@]}"; do
            if [ "$num" -eq "$rand_num" ]; then
                is_duplicate=1
                break
            fi
        done

        if [ "$is_duplicate" -eq 0 ]; then
            numbers+=("$rand_num")
        fi
    done

    echo "${numbers[@]}"
}

show_lottery_numbers() {
    local numbers=("$@")
    echo "Loositud võidunumbrid:"
    for num in "${numbers[@]}"; do
        echo "$num"
    done
    echo ""
}
