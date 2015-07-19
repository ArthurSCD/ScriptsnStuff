#!/bin/bash

if [ $(id -u) -ne 0 ]
 then
    sudo $0
    exit 0
fi

cp "/home/$ruser/wordpress/wp-config-sample.php" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/database_name_here/$database/g" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/username_here/$username/g" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/password_here/$password/g" "/home/$ruser/wordpress/wp-config.php"
sed -i -e "s/localhost/$host/g" "/home/$ruser/wordpress/wp-config.php"


rsync -avpP "/home/$ruser/wordpress/" "/var/www/$sitename/public/"
chown -R $ruser:www-data "/var/www/$sitename/public/*"
mkdir -p "/var/www/$sitename/public/wp-content/uploads"
chown -R :www-data "/var/www/$sitename/public/wp-content/uploads"

# nginx server blocks, must use provided default
# wget https://raw.githubusercontent.com/LuciferIAm/ScriptsnStuff/master/autodef ~/etc/nginx/sites-available/

cp "/etc/nginx/sites-available/autodef" "/etc/nginx/sites-available/$sitename"
sed -i -e "s/example.com/$sitename/g" "/etc/nginx/sites-available/$sitename"
ln -s "/etc/nginx/sites-available/$sitename" "/etc/nginx/sites-enabled/"
service nginx restart
service php5-fpm restart

#install finished! just go to your site now!
