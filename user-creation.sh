#/bin/bash

##This script checks if you are root, Then automates user creatation.

if [[ $(id -g) -ne 0 ]]
then
	echo "you are not root, try as root or use sudo"
	exit 1
else
	echo "When promted please enter username (login), the name for person who will be using the account, and the initial password for the account"
	echo "Press (Enter after each filed)"
fi

#username (login)

	read -p "username: " LOGIN

#name for person

	read -p "full name: " COMMENT

#initial password

	read -p "initial password: " PASSWORD

#Creating the new user
sudo useradd -c "$COMMENT" $LOGIN

#Check for error

if [[ $? -ne 0 ]]
then
	echo "error with account creation" 
	exit 1
else
	echo "account created: user: $LOGIN, fullname: $COMMENT "
fi

echo "setting initial password"
echo "$LOGIN:$PASSWORD" | sudo chpasswd

# Check for error in forcing password change
if [[ $? -ne 0 ]]; then
    echo "Error expiring the password"
    exit 1
else
    echo "User $LOGIN is required to change the password on first login"
fi
