#!/bin/bash

set -euo pipefail
NOTES_DIR="notes"
EDITOR="${EDITOR:-nano}"

#creates or checks whether the directory already exists or not
ensure_dir() {
    mkdir -p "$NOTES_DIR"
}

next_note_number() {
    local lastnumber
    lastnumber=$(
        find "$NOTES_DIR" -maxdepth 1 -name 'note*.txt' \
        | sed -E 's/.*note([0-9]+)\.txt/\1/' \
        | sort -n \
        | tail -n 1
    )

    if [[ -z "${lastnumber:-}" ]]; then
        echo 1
    else
        echo $((lastnumber+1))
    fi
}

#creating note
create_note() {
    ensure_dir

    local number
    number=$(next_note_number)

    local file="$NOTES_DIR/note${number}.txt"
    "$EDITOR" "$file"
}

search_note() {
    ensure_dir
    read -rp "ENTER THE KEYWORD TO SEARCH : " keyword

    if ! grep -ni -- "$keyword" "$NOTES_DIR"/note*.txt 2>/dev/null; then
        echo "NO NOTES FOUND WITH THE KEYWORD : $keyword"
    fi

}

edit_note() {
    ensure_dir

    read -rp "ENTER THE NOTE NUMBER TO BE EDITED :" number

    local file="$NOTES_DIR/note${number}.txt"
    if [[ -f $file ]]; then
        "$EDITOR" "$file"
    else
        echo "NOTE DOES NOT EXIST!!!"
    fi
}

delete_note() {
    ensure_dir

    read -rp "ENTER THE NOTE NUMBER TO BE DELETED :" number
    local file="$NOTES_DIR/note${number}.txt"
    if [[ -f $file ]]; then
        rm -- $file
        echo "NOTE $number SUCCESSFULLY DELETED"
    else
        echo "NOTE DOES NOT EXIST!!!"
    fi
}

while true; do
    echo
    echo "****NOTES CLI****"
    echo "1. CREATE NEW NOTE"
    echo "2. SEARCH NOTE"
    echo "3. EDIT NOTE"
    echo "4. DELETE NOTE"
    echo "5. LIST NOTES"
    echo "6. EXIT"

    read -rp "ENTER YOUR CHOICES:" choice

    case "$choice" in
        1) create_note ;;
        2) search_note ;;
        3) edit_note ;;
        4) delete_note ;;
        5) ls "$NOTES_DIR" ;;
        6) exit 0 ;;
        *) echo "Invalid Choice" ;;
    esac
done
