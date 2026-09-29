#!/bin/bash

fail_olemas() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

if fail_olemas "/etc/passwd"; then
    echo "Fail /etc/passwd on olemas."
else
    echo "Faili ei leitud."
fi
