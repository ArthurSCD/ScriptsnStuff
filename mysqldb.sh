if [ $(uname) = "Linux" ] 
  then

	while [ -z "$database" ];
	do
		echo -n "Enter name of database: "
		read database
	done

	while [ -z "$username" ];
	do
		echo -n "Enter username (name@<localhost>): "
		read username
	done

	while [ -z "$password" ];
	do
		echo -n "Enter password: "
		read password
	done
fi

DB="CREATE DATABASE $database;"
USN="CREATE USER $username IDENTIFIED BY '$password';"
PWD="GRANT ALL PRIVILEGES ON $database.* TO $username;"
FL="FLUSH PRIVILEGES;"
CREATE="${DB}${USN}${PWD}${FL};"

mysql -e "$CREATE"