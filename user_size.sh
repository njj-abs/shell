#!/bin/bash

LOG_FILE=user_size.log

check_and_remove_log_file() {
    if [ -f "$LOG_FILE" ]; then
        rm "$LOG_FILE"
    fi
}

calculate_trash_sizes() {
    for user_dir in /home/*/; do
        user_name=$(basename "$user_dir")
		echo "$user_dir, $user_name"
        trash_size=$(du "$user_dir" 2>/dev/null | cut -f1)
        echo "User Size: $trash_size, User: $user_name" >> "$LOG_FILE"
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
