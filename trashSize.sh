#!/bin/bash

LOG_FILE=trash_size.log

check_and_remove_log_file() {
    if [ -f "$LOG_FILE" ]; then
        rm "$LOG_FILE"
    fi
}

calculate_trash_sizes() {
    for user_dir in /home/*/; do
        user_name=$(basename "$user_dir")
        trash_size=$(du -s "$user_dir/.local/share/Trash/files" 2>/dev/null | cut -f1)
        if [ -n "$trash_size" ]; then
            echo "Trash Size: $trash_size, User: $user_name" >> "$LOG_FILE"
        fi
    done
}

sort_log_file() {
    sort -t':' -k2,2hr -o "$LOG_FILE" "$LOG_FILE"
}

main() {
    check_and_remove_log_file
    
    calculate_trash_sizes
    
    sort_log_file
}

main
