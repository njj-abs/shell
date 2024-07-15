#!/bin/bash

# Check if at least one user name is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 user1 [user2 ...]"
    exit 1
fi

# Loop through each user name provided as argument
for user in "$@"; do
    sudo rm -rf /home/"$user"/.local/share/Trash/files
    sudo mkdir -p /home/"$user"/.local/share/Trash/files
done
