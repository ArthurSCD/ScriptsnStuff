#!/bin/bash


if [ $(uname) = "Linux" ] 
  then

	while [ -z "$database" ];
	do
		echo -n "Enter name of database: "
		read database
	done

	while [ -z "$username" ];
	do
		echo -n "Enter username: "
		read username
	done
	
	while [ -z "$password" ];
	do
		echo -n "Enter password: "
		read password
	done
	
	while [ -z "$sitename" ];
	do
		echo -n "Enter sitename: "
		read sitename
	done

	while [ -z "$ruser" ];
	do
		echo -n "Root user (you): "
		read ruser
	done		
fi

DB="CREATE DATABASE $database;"
USN="CREATE USER $username@localhost IDENTIFIED BY '$password';"
PWD="GRANT ALL PRIVILEGES ON $database.* TO $username@localhost;"
FL="FLUSH PRIVILEGES;"
CREATE="${DB}${USN}${PWD}${FL};"

mysql -e "$CREATE"

export database
export username
export password
export sitename
export ruser

./wpinstall.sh
