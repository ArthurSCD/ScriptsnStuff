#!/bin/bash

if [ $(id -u) -ne 0 ]
 then
    sudo $0
fi

if [ $(uname) = "Linux" ] 
  then

	while [ -z "$sitename" ];
	do
		echo -n "Enter name of site: "
		read site
	done
fi

mkdir -p "/srv/www/$sitename"
mkdir -p "/srv/www/$sitename/public"
mdkir -p "/srv/www/$sitename/logs"
