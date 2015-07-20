#!/bin/bash

if [ $(id -u) -ne 0 ]
 then
    sudo $0
    exit 0
fi

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
	
	while [ -z "$prefix" ];
	do
		echo -n "Enter prefix: "
		read prefix
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

sudo -u bam mysql -e "$CREATE"



cp "/home/$ruser/wordpress/wp-config-sample.php" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/database_name_here/$database/g" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/username_here/$username/g" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/password_here/$password/g" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/wp_/$prefix/g" "/home/$ruser/wordpress/wp-config.php"



rsync -avpP "/home/$ruser/wordpress/" "/srv/www/$sitename/public/"
chown -R $ruser:www-data "/srv/www/$sitename/public/"
mkdir -p "/srv/www/$sitename/public/wp-content/uploads"
chown -R :www-data "/srv/www/$sitename/public/wp-content/uploads"

# nginx server blocks, must use provided default
# wget https://raw.githubusercontent.com/LuciferIAm/ScriptsnStuff/master/autodef ~/etc/nginx/sites-available/

cp "/etc/nginx/sites-available/autodef" "/etc/nginx/sites-available/$sitename"
sed -i -e "s/example.com/$sitename/g" "/etc/nginx/sites-available/$sitename"
ln -s "/etc/nginx/sites-available/$sitename" "/etc/nginx/sites-enabled/"
service nginx restart
service php5-fpm restart

#install finished! just go to your site now!
