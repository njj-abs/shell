#!/bin/bash

# Usage:
# sudo bash renameUser.sh old_username new_username

set -e

olduser=$1
newuser=$2

backup_olduser() {
    cp -r /home/$olduser /backup/$olduser
}

rename_user_account() {
    usermod -l $newuser $olduser
}

rename_home_directory() {
    usermod -d /home/$newuser -m $newuser
}

rename_group_name() {
    groupmod -n $newuser $olduser
}

update_ownership() {
    chown -R $newuser:$newuser /home/$newuser || true
}

update_oldname_to_newname() {
    grep -rlI "/home/$newuser/" -e "$olduser" | uniq | xargs -I {} sed -i "s/$olduser/$newuser/g" '{}'
}

main() {
    backup_olduser
    rename_user_account
    rename_home_directory
    rename_group_name
    update_ownership
    update_oldname_to_newname

    echo "User '$olduser' has been renamed to '$newuser' and home directory renamed."
}

main "$@"
