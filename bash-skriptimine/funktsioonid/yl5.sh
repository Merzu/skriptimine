#!/bin/bash

liida() {
    if [ $# -ne 2 ]; then
        echo "Viga: sisesta kaks arvu!"
        return 1
    fi

    local a="$1"
    local b="$2"
    echo $((a + b))
}

tulemus=$(liida 10 20)
echo "Tulemus: $tulemus"
