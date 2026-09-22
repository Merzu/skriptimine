#!/bin/bash

for (( i=1000; i<=9999; i++ ))
do
    arv=$i
    
    while [ $arv -gt 9 ]
    do
        summa=0
        temp=$arv
        
        while [ $temp -gt 0 ]
        do
            viimane=$((temp % 10))
            summa=$((summa + viimane))
            temp=$((temp / 10))
        done
        
        arv=$summa
    done
    
    if [ $arv -eq 7 ]; then
        echo $i
    fi
done
