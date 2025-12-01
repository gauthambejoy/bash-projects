#! /bin/bash

echo "NOTES CLI"
echo "1. Create a new note"
echo "2. Search for a note"
echo -n "Enter your choice:(1/2):"
read choice

create_note() {
    notes_dir="notes"

    if [ ! -d "$notes_dir" ]
    then
        mkdir "$notes_dir"
    fi

    last_file=$(ls "$notes_dir"/note*.txt 2>/dev/null | sort -V | tail -n 1)
    

    if [ -z "$last_file" ]
    then
        next_num=1
    else
        base_name=${last_file##*/}
        base_name=${base_name%.*}
        num=${base_name#note}
        next_num=$(( num + 1 ))
    fi

    new_file="$notes_dir/note${next_num}.txt"
    nano "$new_file"
}

if [ "$choice" -eq 1 ];
then
    create_note
fi