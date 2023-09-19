#!/bin/bash

username=$1

is_user_exists () {
    if ! id "$username" >/dev/null; then
        echo "User $username does not exist."
        exit 1
    fi
}

delete_user () {
    userdel -r "$username"
}

remove_home_directory () {
    rm -rf /home/"${username:?}"
}

delete_group_name () {
    groupdel "$username"
}

success_message () {
    echo "User $username has been deleted."
}

main () {
	is_user_exists
	delete_user
    remove_home_directory
    delete_group_name
    success_message
}

main "$@"
