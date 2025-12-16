#!/bin/bash

#part 1 identifying file tyes
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
for extension in "${ext_arr[@]}"
do
    echo "$extension"
done

#part 2 creating the filetype directory

echo "Enter the file type to be sorted:"
read filetype
filetype="${filetype,,}"   
found=false
for i in "${ext_arr[@]}"
do
    if [[ "$filetype" == "$i" ]]
    then
        found=true
        break
    fi
done
if [[ $found == true ]]
then
    mkdir -p "$filetype"
else
    echo "Incorrect file type"
fi

#part 3 moving the files to the new 

for file in *."$filetype"
do
    if [[ -f "$file" ]]
    then
        mv "$file" "$filetype"/
    fi
done