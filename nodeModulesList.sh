#!/bin/bash

find_directories() {
    local directory="$1"
    local threshold="$2"

    find "$directory" -type d -name "node_modules" -print0 |
    xargs -0 du -s |
   grep "/node_modules/" | # du returns all the dir when no input is provided.
    awk -v threshold="$threshold" '$1 >= threshold' |
    sed 's:/node_modules/.*:/node_modules/:' |
    awk '{print $2}' |
    uniq |
    paste -sd '\n'
}

# Path to the log file
LOG_FILE="users_node_modules.log"

THRESHOLD="1000"

# Iterate over all user directories in /home
for user_dir in /home/*; do
    if [ -d "$user_dir/dev" ]; then
        find_directories "$user_dir/dev" "$THRESHOLD" >> "$LOG_FILE"
        echo "" >> "$LOG_FILE"
    fi
done
