#!/bin/bash
# Eesmärk: 5x5 tärnide ruudu väljastamine sisseehitatud tsüklitega

for (( i=1; i<=5; i++ ))
do
    echo -n "$i. "
    for (( j=1; j<=5; j++ ))
    do
        echo -n "*"
    done
    echo ""
done
