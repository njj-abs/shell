#!/bin/bash

find_directories() {
    local threshold="$1"
    
    find . -iname node_modules |
    xargs du |
    grep "/node_modules/" | # du returns all the dir when no input is provided.
    awk -v threshold="$threshold" '$1 >= threshold' |
    sed 's:/node_modules/.*:/node_modules/:' |
    awk '{print $2}' |
    uniq |
    paste -sd '\n'
}

confirm_deletion() {
    echo "$directories"
    
    printf "Are you sure you want to delete these directories? (y/n) "
    read -r answer </dev/tty
    
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        return 0
    else
        echo "Deletion canceled."
        return 1
    fi
}

delete_directories() {
    for directory in $directories; do
        rm -rf "$directory"
        if [ $? -eq 0 ]; then
            echo "Deleted: $directory"
        else
            echo "Failed to delete: $directory"
        fi
    done
}

main() {
    threshold="$1"
    directories=$(find_directories "$threshold")
    
    if [ -z "$directories" ]; then
        echo "No directories to delete."
        exit 0
    fi
    
    if confirm_deletion "$directories"; then
        delete_directories "$directories"
    fi
}

main "$@"

