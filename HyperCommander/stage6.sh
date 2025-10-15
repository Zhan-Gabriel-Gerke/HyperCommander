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
showFileMenu(){
    echo "---------------------------------------------------------------------
| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |
---------------------------------------------------------------------"
}
fileMenuOperations(){
    local fileName=$1
    while true; do
        showFileMenu
        read -r -p "" option
        if [[ "$option" = 1 ]]; then
            rm $fileName
            echo "$fileName has been deleted."
            break
        elif [[ "$option" = 2 ]]; then
            echo "Enter the new file name:"
            read -r newFileName
            mv "$fileName" "$newFileName"
            echo "$fileName has been renamed as $newFileName"
            fileName=$newFileName
            break
        elif [[ "$option" = 3 ]]; then
            chmod a+w "$fileName"
            echo "Permissions have been updated."
            ls -l "$fileName"
            echo
            break
        elif [[ "$option" = 4 ]]; then
            chmod o-w "$fileName"
            echo "Permissions have been updated."
            ls -l "$fileName"
            echo
            break
        elif [[ "$option" = 0 ]]; then
            cd ..
            break
        fi
    done
}
fileMenu(){
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
}
fileDirOperations(){
    while true; do
        arr=(*)
        fileMenu
        read -r -p "" comInput
        if [[ "$comInput" = 0 ]]; then
            break
        elif [[ "$comInput" = up ]]; then
            cd ..
            fileMenu
        elif [[  -f "$comInput" ]]; then
            fileMenuOperations $comInput
        elif [[  -d "$comInput" ]]; then
            cd $comInput
            fileMenu
        else
            echo "Invalid input!"
        fi
    done
}

findExecutable(){
    echo "Enter an executable name:"
    read -ra executableName
    path=$(which "$executableName" 2>/dev/null)
    if [[ -n "$path" ]]; then
        echo "Located in: $path"
        echo
        echo "Enter arguments:"
        read -ra args
        "$path" "${args[@]}"
    else
        echo "The executable with that name does not exist!"
    fi
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
        findExecutable
    else
        echo "Invalid option!"
    fi
done