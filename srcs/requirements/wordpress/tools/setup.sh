#!/bin/bash

#exit on errors
set -e

#use the same port which is used in nginx->/etc/nginx/nginx.conf at section fastcgi
echo "listen = 9000" >> /etc/php8/php-fpm.d/www.conf

while ! mariadb -h $DB_CONTAINER_NAME -u $DB_USER_NAME -p$DB_USER_PWD -P $DB_SERVER_PORT -e 'quit';
do
	echo "WAITING FOR DATABASE SERVER"
	sleep 1
done
echo "CONNECTION TO DATABASE SERVER ESTABLISHED"
if [ ! -f "index.php" ]
then
	echo "DOWNLOADING WORDPRESS"
	wp core download --path="/www"
	echo "CONFIGURING WORDPRESS"
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USER_NAME" --dbpass="$DB_USER_PWD" --dbhost="$DB_CONTAINER_NAME"
	if [ ! -f wp-config.php ]
	then
		echo "ERROR DURING CONFIGURATION"
		return 1
	fi
	echo "PROCEEDING TO INSTALL"
	wp core install --url="fschlute.42.fr" --title="$COMPOSE_PROJECT_NAME" --admin_name="$WP_ROOT_NAME" --admin_password="$WP_ROOT_PWD" --admin_email="fschlute@student.42.fr" --skip-email
	echo "ADDING 0815"
	wp user create "$WP_USER_NAME" wfschlute@students.42.fr --user_pass="$WP_USER_PWD" 
	wp search-replace 'http://fschlute.42.fr' 'https://fschlute.42.fr' > /dev/null
fi
exec php-fpm8 -FR 
