#!/bin/bash

echo -n "Sisesta vanus: "
read vanus

if [ $vanus -ge 0 -a $vanus -lt 11 ]; then
    echo "oled laps"
elif [ $vanus -ge 11 -a $vanus -lt 18 ]; then
    echo "oled nooruk"
elif [ $vanus -ge 18 -a $vanus -lt 63 ]; then
    echo "oled täiskasvanu"
elif [ $vanus -ge 63 ]; then
    echo "oled senjoor"
else
    echo "vigane sisend"
fi
