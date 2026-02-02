#!/bin/bash
THRESHOLD="80"
LOG_FILE="diskusage.log"
DISK="/"


USAGE=$(df -h "$DISK" | awk 'NR==2 { gsub("%",""); print $5 }')

if [[ -z "$USAGE" ]]; then
    echo "$(date): ERROR - Unable to read disk usage" >> "$LOG_FILE"
    echo "-----------------------------------------------------------" >> "$LOG_FILE"
    exit 2
fi

if [[ "$USAGE" -gt "$THRESHOLD" ]]; then
    echo "$(date): ALERT - Disk usage is $USAGE exceeding 80 on $DISK" >> "$LOG_FILE"
    echo "-----------------------------------------------------------" >> "$LOG_FILE"
    exit 1
else
     echo "$(date): OK - Disk usage is $USAGE on $DISK" >> "$LOG_FILE"
     echo "-----------------------------------------------------------" >> "$LOG_FILE"
     exit 0
fi

