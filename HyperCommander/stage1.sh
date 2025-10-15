#! /usr/bin/env bash
echo "Hello $USER!"
show_menu(){
    echo "------------------------------
| Hyper Commander            |
| 0: Exit                    |
| 1: OS info                 |
| 2: User info               |
| 3: File and Dir operations |
| 4: Find Executables        |
------------------------------"
}
while true; do
    show_menu
    read -r -p "" input
    if [[ "$input" = 0 ]]; then
        echo "Farewell!"
        break
    elif [[ "$input" = [1-4] ]]; then
        echo "Not implemented!"
    else
        echo "Invalid option!"
    fi
done