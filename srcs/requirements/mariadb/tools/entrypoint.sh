
if [ -f "var/lib/mysql/entry" ];then
	exec mysqld
	exit

else 
	chown -R mysql:mysql /var/lib/mysql
	service mysql restart
	mysql -e "CREATE DATABASE $DB_DATA_BASE_NAME"
	mysql -e "CREATE USER '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD'; GRANT ALL PRIVILEGES ON $DB_DATA_BASE_NAME.* TO '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD' WITH GRANT OPTION; flush privileges;"
	mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; GRANT SELECT ON $DB_DATA_BASE_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; flush privileges;"
	mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('abc') ; flush privileges ;"

	touch var/lib/mysql/entry
	chmod 777 var/lib/mysql/*
	exec mysqld_safe
fi