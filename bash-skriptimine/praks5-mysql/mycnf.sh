#!/bin/bash

# Loome .my.cnf faili paroolivabaks sisselogimiseks
cat > "$HOME/.my.cnf" << 'INNER_EOF'
[client]
host=localhost
user=root
password=qwerty
INNER_EOF

# Määrame failile turvalised õigused
chmod 600 "$HOME/.my.cnf"
echo "Fail $HOME/.my.cnf on loodud."
