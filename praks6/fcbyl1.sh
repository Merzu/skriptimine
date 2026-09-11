#!/bin/bash

for (( i=1; i<=10; i++ )); do
    if [ $i -eq 7 ]; then
        break
    fi
    echo "Number: $i"
done
