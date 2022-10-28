#!/bin/bash

#exit on errors
set -e

# expand all variables into tmp file
cat ./dbCreationQuery.sql | envsubst > "./expandedDbCreationQuery.sql"

if [ -d "/var/lib/mysql/mysql" ]; then
	echo "Found existing data base"
else
	echo "INSTALLING DATABASE";
	mysql_install_db;
	echo "CONFIGURING DATABASE";	
	echo "INITIALIZING DATABASE";
	# load sql init query into special client:
	# documentation very scarce https://mariadb.com/kb/en/mariadb-galera-bootstrap/
	mysqld --bootstrap < "./expandedDbCreationQuery.sql";
	rm "./expandedDbCreationQuery.sql"
	echo "DONE INITIALIZING DATABASE";
fi
exec mysqld 
