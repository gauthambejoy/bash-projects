#!/bin/bash


LOGFILE=$HOME/sysutil.log

log() {
    local name="$1"
    local message="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$name] $message" >> "$LOGFILE"
}

usage() {
    cat << EOF
Usage:
  $0 backup <src> <dest>
  $0 cleanup <dir> <days>
  $0 health

Commands:
  backup   Create a compressed backup of <src> in <dest>
  cleanup  Delete files older than <days> in <dir>
  health   Show basic system health information

Examples:
  $0 backup /home/user/data /home/user/backups
  $0 cleanup /tmp 7
  $0 health
EOF
}

backup() {
    local src="$1"
    local dest="$2"

    if [[ ! -d "$src" ]]; then
        echo "Source Directory does not exist"
        log "ERROR" "Backup failed: Source not found ($src)"
        exit 1
    fi

    if [[ ! -d "$dest" ]]; then
        echo "Destination Directory does not exist"
        log "ERROR" "Backup failed: Destination not found ($dest)"
        exit 1
    fi

    local ts
    ts=$(date '+%Y%m%d_%H%M%S')
    local archive="$dest/backup_$ts.tar.gz"

    tar -czf "$archive" "$src"
    if [[ $? -ne 0 ]]; then
        echo "Backup failed"
        log "ERROR" "Backup failed for $src"
        exit 1
    fi

    echo "Backup Created"
    log "INFO" "Backup successful: $archive"    


}

cleanup() {

    local dir="$1"
    local days="$2"

    if [[ ! -d "$dir" ]]; then
        echo "Directory does not exist"
        log "ERROR" "Cleanup failed: Directory not found($dir)"
        exit 1
    fi

    if ! [[ "$days" =~ ^[0-9]+$ ]]; then
        echo "Days must be a number"
        log "ERROR" "Cleanup failed: Invalid days ($days)"
        exit 1
    fi

    local count
    count=$(find "$dir" -type f -mtime +"$days" | wc -l)

    find "$dir" -type f -mtime +"$days" -delete
    if [[ $? -ne 0 ]]; then
        echo "Cleanup failed"
        log "ERROR" "Cleanup failed in $dir"
        exit 1
    fi

    echo "Deleted $count files older than $days days"
    log "INFO" "Cleanup: Deleted $count files from $dir"
}

health() {
    echo "System Health"
    echo "_____________"
    echo "UPTIME"
    uptime
    echo
    echo "DISK USAGE"
    df -h
    echo
    echo "MEMORY USAGE"
    free -h

    log "INFO" "Health Check executed"
}

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

command="$1"
shift

case "$command" in
    backup)
        [[ $# -eq 2 ]] || { usage; exit 1; }
        backup $1 $2
        ;;
    cleanup)
        [[ $# -eq 2 ]] || { usage; exit 1; }
        cleanup $1 $2
        ;;
    health)
        [[ $# -eq 0 ]] || { usage; exit 1; }
        health
        ;;
    *)
        usage
        exit 1
        ;;
esac
