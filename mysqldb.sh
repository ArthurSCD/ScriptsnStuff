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
USN="CREATE USER $username@$host IDENTIFIED BY '$password';"
PWD="GRANT ALL PRIVILEGES ON $database.* TO $username;"
FL="FLUSH PRIVILEGES;"
CREATE="${DB}${USN}${PWD}${FL};"

mysql -e "$CREATE"

cp /home/"$ruser"/wordpress/wp-config-sample.php /home/"$ruser"/wordpress/wp-config.php
sed -i -e "s/database_name_here/$database/g" /home/"$ruser"/wordpress/wp-config.php
sed -i -e "s/username_here/$username/g" /home/"$ruser"/wordpress/wp-config.php
sed -i -e "s/password_here/$password/g" /home/"$ruser"/wordpress/wp-config.php
sed -i -e "s/localhost/$host/g" /home/"$ruser"/wordpress/wp-config.php


rsync -avpP /home/"$ruser"/wordpress/ /home/"$ruser"/var/www/"$sitename"/public/
chown -R "$ruser":www-data /home/"$ruser"/var/www/"$sitename"/public/*
mkdir /home/"$ruser"/var/www/"$sitename"/public/wp-content/uploads
chown -R :www-data /home/"$ruser"/var/www/"$sitename"/public/wp-content/uploads

# nginx server blocks, must use provided default
# wget https://raw.githubusercontent.com/LuciferIAm/ScriptsnStuff/master/autodef ~/etc/nginx/sites-available/
cp /home/"$ruser"/etc/nginx/sites-available/autodef /home/"$ruser"/etc/nginx/sites-available/"$sitename"
sed -i -e "s/example.com/$sitename/g" /home/"$ruser"/etc/nginx/sites-available/"$sitename"
ln -s /home/"$ruser"/etc/nginx/sites-available/"$sitename" /home/"$ruser"/etc/nginx/sites-enabled/
service nginx restart
service php5-fpm restart

#install finished! just go to your site now!
