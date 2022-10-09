sed -ie 's/$USER/'$DB_ADMIN'/' var/www/wordpress/wp-config.php
sed -ie 's/$DB_NAME/'$DB_DATA_BASE_NAME'/' var/www/wordpress/wp-config.php
sed -ie 's/$PWD/'$DB_ADMIN_PASSWORD'/' var/www/wordpress/wp-config.php

if [ -f "var/www/wordpress/conf" ];then
    echo ""
else
    cp -rf /var/www/adminer /var/www/wordpress
    cd /var/www/wordpress
    wp core --allow-root install --url="https://cmois.42.fr/" --title="Inception cmois" --admin_name=cmois --admin_email=moiscristina@gmail.com --admin_password=Inception123;
    wp --allow-root user create other other@gmail.com --user_pass=pass
    # wp --allow-root plugin install redis-cache --activate
    touch conf
fi

exec /usr/sbin/php-fpm7.3 -F -R
