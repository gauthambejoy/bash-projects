#! /bin/bash

while true
do
    echo "NOTES CLI"
    echo "1. Create a new note"
    echo "2. Search for a note"
    echo "3. Edit note"
    echo "4. Delete note"
    echo "5. exit"
    echo -n "Enter your choice:"
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

    search_note() {
        echo -n "Enter the keyword to search:"
        read keyword

        grep -ni "$keyword" notes/note*.txt 2>/dev/null

        if [ $? -ne 0 ]
        then
            echo "No notes found with the keyword:$keyword"
        fi
    }

    edit_note() {
        echo -n "Enter the note number:"
        read number

        filename="notes/note${number}.txt"

        if [ -f "$filename" ]
        then
            nano "$filename"
        else
            echo "File does not exist"
        fi
    }

    delete_note() {
        echo -n "Enter the note number:"
        read number

        filename="notes/note${number}.txt"

        if [ -f "$filename" ]
        then
            rm "$filename"
        else
            echo "File does not exist"
        fi
    }


    if [ "$choice" -eq 1 ];
    then
        create_note
    elif [ "$choice" -eq 2 ];
    then    
        search_note
    elif [ "$choice" -eq 3 ];
    then
        edit_note
    elif [ "$choice" -eq 4 ];
    then
        delete_note
    elif [ "$choice" -eq 5 ];
    then
        exit 0
    else
        echo "Wrong Choice"
    fi
done