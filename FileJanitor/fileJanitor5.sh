#!/usr/bin/env bash

# stript

echo "File Janitor, 2025"
echo "Powered by Bash"
echo 
if [[ $1 == help ]]; then
        cat file-janitor-help.txt
elif [[ $1 == list ]]; then
        if [[ $# -eq 1 ]]; then
                echo "Listing files in the current directory"
                ls -A -1 | sort -V
        else
                if [ -f "$2" ]; then
                        echo "$2 is not a directory"
                else
                        if [ -d "$2" ]; then
                                echo "Listing files in $2"
                                ls $2 -A -1 | sort -V
                        else
                                echo "$2 is not found"
                        fi
                fi
        fi
elif [[ $1 == clean ]]; then
        count=0
        path="."
        if [[ $# -eq 2 ]]; then
                path=$2
                if [ -f "$path" ]; then
                        echo "$path is not a directory"
                        exit 1
                else
                        if [ ! -d "$path" ]; then
                                echo "$path is not found"
                                exit 1
                        fi
                fi
        fi
        logCount=0
        tmpCount=0
        pyCount=0
        shopt -s dotglob
        for file in "$path"/*
        do
                if [[ ! -f "$file" ]]; then
                        continue
                fi
                
                if [[ "$file" == *.py ]]; then
                        ((pyCount++))
                        mkdir -p "$path/python_scripts"
                        mv "$file" "$path/python_scripts"
                elif [[ "$file" == *.log ]]; then
                        mod_time=$(stat -c %Y "$file" 2>/dev/null)
                        if [[ -n "$mod_time" ]]; then
                                day_ago=$(( ( $(date +%s) - mod_time ) / 86400 ))
                                if (( day_ago > 3 )); then
                                        ((logCount++))
                                        rm "$file"
                                fi
                        fi
                elif [[ "$file" == *.tmp || "$file" == *.temp || "$file" == *.bak || "$file" == *~ || "$file" == */~* || "$file" == *.$$$ || "$file" == *.old ]]; then
                        ((tmpCount++))
                        rm "$file"
                fi
        done
        if [[ $path == "." ]]; then
            echo "Cleaning the current directory..."
        else
            echo "Cleaning" $path
        fi
        echo "Deleting old log files...  done! $logCount files have been deleted"
        echo "Deleting temporary files...  done! $tmpCount files have been deleted"
        echo "Moving python files...  done! $pyCount files have been moved"
        if [[ $path == "." ]];then
            echo "Clean up of the current directory is complete!"
        else
            echo "Clean up of" $path "is complete!"
        fi
elif [[ $1 == report ]]; then
        count=0
        #path="/home/adm-account/Desktop";
        path="."
        if [[ $# -eq 2 ]]; then
                #path="${path}/$2"
                path=$2
                if [ -f "$path" ]; then
                        echo "$path is not a directory"
                        exit 1
                else
                        if [ ! -d "$path" ]; then
                                echo "$path is not found"
                                exit 1
                        fi
                fi
        fi
        pyFiles=0
        logFiles=0
        tmpFiles=0
        pySize=0
        logSize=0
        tmpSize=0

        countFun(){
            shopt -s dotglob    

            for file in "$path"/*
            do
                if [[ ! -f "$file" ]]; then
                        continue
                fi

                if [[ "$file" == *.py ]]; then
                        ((pyFiles++))
                        ((pySize += $(stat -c %s "$file")))
                elif [[ "$file" == *.log ]]; then
                        ((logFiles++))
                        ((logSize += $(stat -c %s "$file")))
                elif [[ "$file" == *.tmp || "$file" == *.temp || "$file" == *.bak || "$file" == *~ || "$file" == */~* || "$file" == *.$$$ || "$file" == *.old ]]; then
                        ((tmpFiles++))
                        ((tmpSize += $(stat -c %s "$file")))
                fi
            done
        }
        countFun
        if [[ $path == "." ]]; then
            echo "The current directory contains:"
        else
            echo $path "contains:"
        fi
        echo "$tmpFiles tmp file(s), with total size of $tmpSize bytes"
        echo "$logFiles log file(s), with total size of $logSize bytes"
        echo "$pyFiles py file(s), with total size of $pySize bytes"
else
        echo "Type $0 help to see available options"
fi