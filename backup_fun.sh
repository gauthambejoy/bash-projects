#!/bin/bash

LOG_FILE="backup.log"

backup() {
    source="$1"
    destination="$2"

    #1. Validate arguments
    if [[ -z "$source" || -z "$destination" ]]; then
        echo "$(date): ERROR - Missing Arguments" >> "$LOG_FILE"
        return 1
    fi

    #2. Check source exists
    if [[ ! -e "$source" ]]; then
        echo "$(date): ERROR - Source does not exist" >> "$LOG_FILE"
        return 2
    fi

    #3. Create destination if missing
    mkdir -p "$destination"

    #4. Copy source to destination
    rsync -a "$source" "$destination" 2>/dev/null
    status=$?

    if [[ $status -eq 0 ]]; then
        echo "$(date): SUCCESS - Successfully Backed up $source to $destination" >> "$LOG_FILE"
        return 0
    elif [[ $status -eq 23 ]]; then
        echo "$(date): WARNING - Backup completed with permission issues for $source" >> "$LOG_FILE"
        return 0
    else
        echo "$(date): ERROR - Backup failed for $source" >> "$LOG_FILE"
        return 2
    fi
}

backup $1 $2
exit $?