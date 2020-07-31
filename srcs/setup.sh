cp /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm /etc/nginx/sites-enabled/default

mkdir -p /run/php && touch /run/php/php7.3-fpm.sock
echo "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

#DATA BASE
service mysql start
chown -R mysql:mysql /var/lib/mysql/wordpress
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'user'@'localhost' IDENTIFIED BY '1234';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost' IDENTIFIED BY '1234'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#SSL
mkdir -p /etc/nginx/ssl
chmod 700 /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=Suahn/CN=localhost/EA=suahn@student.42.fr"

#ACCESS PERMISSION
chown -R www-data:www-data /var/www
chmod -R 755 /var/www

#SERVICE STARTER
service php7.3-fpm restart
service nginx restart
bash
