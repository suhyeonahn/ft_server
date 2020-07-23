cp /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm /etc/nginx/sites-enabled/default

mkdir -p /run/php && touch /run/php/php7.3-fpm.sock
echo "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

chown -R www-data:www-data /var
chmod -R 755 /var

#SERVICE STARTER
service php7.3-fpm restart
service nginx restart
bash
