#!/bin/bash

#path to the log file

log_file="/var/log/dpkg.log"

#checking if the logfile exists
if [ ! -f "$log_file" ]
then
    echo "The file doesn't exist"
    exit 1
fi

#checking if logfile is readable

if [ ! -r "$log_file" ]
then
    echo "Log file is not readable"
    exit 1
fi

#function to analyze log

echo "========== LOG ANALYZER REPORT =========="
error_count=$(grep -cEi "error" "$log_file")
install_count=$(grep -cEi "install" "$log_file")
upgrade_count=$(grep -cEi "upgrade" "$log_file")
remove_count=$(grep -cEi "remove" "$log_file")
echo "Log file name: $(basename "$log_file")"
echo "Error count: $error_count"
echo "Install count: $install_count"
echo "Upgrade count: $upgrade_count"
echo "Removal count: $remove_count"
echo "Total number of lines processed: $( wc -l < "$log_file")"
