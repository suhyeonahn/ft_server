FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
    php7.3 php-fpm \
    mariadb-server php-mysql

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
COPY srcs/nginx-host-conf /etc/nginx/sites-available/localhost
COPY srcs/setup.sh ./
CMD bash setup.sh
