FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
    php7.3 php-fpm \
    mariadb-server php-mysql \
    php-json php-mbstring \
    wget

WORKDIR /var/www/html/
#SETUP PHPMYADMIN
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz
RUN tar xvf phpMyAdmin-4.9.1-english.tar.gz && rm -rf phpMyAdmin-4.9.1-english.tar.gz
RUN mv phpMyAdmin-4.9.1-english phpmyadmin

#SETUP WORDPRESS
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxvf latest.tar.gz && rm -rf latest.tar.gz

#COFIG NGINX
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
COPY srcs/nginx-host-conf /etc/nginx/sites-available/localhost
RUN cp /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
RUN rm /etc/nginx/sites-enabled/default

#SSL
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.crt -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=Suahn/CN=localhost/EA=suahn@student.42.fr"

#CONFIG PHP && WORDPRESS
RUN mkdir -p /run/php && touch /run/php/php7.3-fpm.sock
COPY srcs/config.inc.php phpmyadmin
COPY srcs/wp-config.php wordpress

#CHECK PHP
RUN echo "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

#SETUP DATABASE && START SERVICES
COPY srcs/start-service.sh ./
CMD bash start-service.sh
