cp /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm /etc/nginx/sites-enabled/default

mkdir -p /run/php && touch /run/php/php7.3-fpm.sock
echo "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

service mysql start
chown -R mysql:mysql /var/lib/mysql/wordpress
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#PHPADMIN INSTALL
#wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
#mkdir /var/www/html/phpmyadmin
#tar xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin
#cp /root/config.inc.php /var/www/localhost/phpmyadmin/

#SSL
mkdir -p /etc/nginx/ssl
#chmod 700 /etc/nginx/ssl
#openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key
#ACCESS PERMISSION
chown -R www-data:www-data /var/www
chmod -R 755 /var/www

#SERVICE STARTER
service php7.3-fpm restart
service nginx restart
bash
