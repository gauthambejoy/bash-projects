#!/bin/bash
dir=$(pwd)
echo "Directory:$dir"
echo "File types in the directory:"
ext_arr=()
for file in *
do
    if [ -f "$file" ]
    then
        if [[ "$file" == *.* ]]
        then
            extension="${file##*.}"
            extension="${extension,,}"
            found=false
            for i in "${ext_arr[@]}"
            do
                if [[ "$i" == "$extension" ]]
                then    
                    found=true
                    break
                fi
            done
            if [[ $found == false ]]
                then 
                    ext_arr+=("$extension")
            fi
        fi
    fi
done 
