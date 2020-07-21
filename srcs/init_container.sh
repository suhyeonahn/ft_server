# Config Access
chown -R www-data:www-data /var/www/*
chomod -R 755 /var/www/*

# Config Nginx
mkdir -p /var/www/localhost
mv ./tmp/nginx-host-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-enabled/default

# Config MYSQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
mysql wordptrss -u root --password= < wordpress.sql
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Config phpmyadmin

mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz /var/www/localhost/phpmyadmin
mv ./tmp/config.inc.php /var/www/localhost/phpmyadmin
