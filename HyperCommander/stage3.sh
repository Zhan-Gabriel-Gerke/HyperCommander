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
fileDirOperations(){
    while true; do
        arr=(*)
        echo "The list of files and directories:"
        for item in "${arr[@]}"; do
            if [[ -f "$item" ]]; then
                echo "F $item"
            elif [[ -d "$item" ]]; then
                echo "D $item"
            fi
        done
        echo "---------------------------------------------------
| 0 Main menu | 'up' To parent | 'name' To select |
---------------------------------------------------"
    read -r -p "" comInput
    if [[ "$comInput" = 0 ]]; then
        break
    elif [[ "$comInput" = up ]]; then
        echo "Not implemented!"
        echo
    elif [[ " ${arr[@]} " =~ "$comInput " ]]; then
        echo "Not implemented!"
        echo
    else
        echo "Invalid input!"
    fi
    done
}

while true; do
    show_menu
    read -r -p "" input
    if [[ "$input" = 0 ]]; then
        echo "Farewell!"
        break
    #elif [[ "$input" = up ]]; then
    #    echo "Not implemented!"
    elif [[ "$input" = 1 ]]; then
        uname -a
    elif [[ "$input" = 2 ]]; then
        whoami
    elif [[ "$input" = 3 ]]; then
        fileDirOperations
    elif [[ "$input" = 4 ]]; then
        echo
    else
        echo "Invalid option!"
    fi
done