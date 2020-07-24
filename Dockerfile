FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
    php7.3 php-fpm \
    mariadb-server php-mysql \
    php-json php-mbstring \
    wget

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
COPY srcs/nginx-host-conf /etc/nginx/sites-available/localhost

# INSTALL PHPMYADMIN
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz
RUN tar xvf phpMyAdmin-4.9.1-english.tar.gz && rm -rf phpMyAdmin-4.9.1-english.tar.gz
RUN mv phpMyAdmin-4.9.1-english phpmyadmin
COPY srcs/config.inc.php phpmyadmin

#INSTALL WORDPRESS
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxvf latest.tar.gz && rm -rf latest.tar.gz
COPY srcs/wp-config.php wordpress

COPY srcs/setup.sh ./
CMD bash setup.sh
