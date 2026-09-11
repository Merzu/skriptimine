#!/bin/bash

for (( i=1; i<=3; i++ )); do
    for (( j=1; j<=10; j++ )); do
        echo "Väline: $i, Sisemine: $j"
        if [ $j -eq 5 ]; then
            echo "Katkestan mõlemad tsüklid (break 2)"
            break 2
        fi
    done
done
