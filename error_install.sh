#!/bin/bash

log_file="/var/log/dpkg.log"
ERROR="error.txt"
INSTALL="install.txt"
ensure_file() {
    touch $ERROR
    touch $INSTALL
}

error_DPKG() {

    ensure_file
    grep -i "error" "$log_file" > "$ERROR"

}

install_DPKG() {

    ensure_file
    grep -i "install" "$log_file" > "$INSTALL"

}



while true;
do
    echo "1.Create the error file for dpkg.log"
    echo "2.Create the install file for dpkg.log"
    echo "3.View error file"
    echo "4.View install file"
    echo "5.EXIT"
    read -p "Enter your choice: " choice
    
    case "$choice" in
        1)error_DPKG ;;
        2)install_DPKG ;;
        3)cat $ERROR ;;
        4)cat $INSTALL ;;
        5)exit 0 ;;
        *)echo "Enter valid choice" ;;
    esac
done

    