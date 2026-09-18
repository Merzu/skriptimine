#!/bin/bash

read -p "Sisesta ridade arv: " rida

for (( i=1; i<=rida; i++ ))
do
    echo -n "$i. "
    for (( j=1; j<=rida-i; j++ ))
    do
        echo -n "0"
    done
    for (( j=1; j<=i; j++ ))
    do
        echo -n "*"
    done
    echo ""
done
