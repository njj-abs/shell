#!/bin/bash

users=("seg" "ipr")

for user in "${users[@]}"; do
    sudo rm -rf /home/"$user"/.local/share/Trash/files
    sudo mkdir /home/"$user"/.local/share/Trash/files
    
done
