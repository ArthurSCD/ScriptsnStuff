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
	
	while [ -z "$host" ];
	do
		echo -n "Enter host: "
		read host
	done	

	while [ -z "$password" ];
	do
		echo -n "Enter password: "
		read password
	done
fi

DB="CREATE DATABASE $database;"
USN="CREATE USER $username@$host IDENTIFIED BY '$password';"
PWD="GRANT ALL PRIVILEGES ON $database.* TO $username;"
FL="FLUSH PRIVILEGES;"
CREATE="${DB}${USN}${PWD}${FL};"

mysql -e "$CREATE"

cp ~/wordpress/wp-config-sample.php ~/wordpress/wp-config.php
sed -i -e "s/database_name_here/$database/g" ~/wordpress/wp-config.php
sed -i -e "s/username_here/$username/g" ~/wordpress/wp-config.php
sed -i -e "s/password_here/$password/g" ~/wordpress/wp-config.php
sed -i -e "s/localhost/$host/g" ~/wordpress/wp-config.php