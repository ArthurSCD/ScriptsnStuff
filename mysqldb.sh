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

exit

sed -i -e 's/database_name_here/$database/g' ~/wordpress/wp-config.php
sed -i -e 's/username_here/$username/g' ~/wordpress/wp-config.php
sed -i -e 's/password_here/$password/g' ~/wordpress/wp-config.php
sed -i -e 's/localhost/$service/g' ~/wordpress/wp-config.php