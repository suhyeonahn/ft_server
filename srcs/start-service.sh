#SETUP DATABASE
service mysql start
chown -R mysql:mysql /var/lib/mysql/wordpress
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'user'@'localhost' IDENTIFIED BY 'suahn';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost' IDENTIFIED BY 'suahn'" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#ACCESS PERMISSION TO SERVICE
chown -R www-data:www-data /var/www
chmod -R 755 /var/www

#START SERVICE
service php7.3-fpm restart
service nginx restart
bash
