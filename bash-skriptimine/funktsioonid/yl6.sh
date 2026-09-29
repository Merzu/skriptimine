#!/bin/bash

naita() {
    echo "Funktsioonile anti $# argumenti:"
    for argument in "$@"
    do
        echo "- $argument"
    done
}

naita "üks" "kaks" "kolm"
