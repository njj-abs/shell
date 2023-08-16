#!/bin/bash

# Usage:
# sudo bash renameUser.sh old_username new_username

set -e

olduser=$1
newuser=$2

# Rename the user account
usermod -l $newuser $olduser

# Rename the home directory
usermod -d /home/$newuser -m $newuser

# Update ownership and permissions
chown -R $newuser:$newuser /home/$newuser || true

# Update occurrences in configuration files
grep -rlI "/home/$newuser/" -e "$olduser" | uniq | sudo xargs -I {} sed -i "s/$olduser/$newuser/g" '{}'

# Rename the home directory
mv /home/$olduser /home/$newuser

echo "User '$olduser' has been renamed to '$newuser' and home directory renamed."
