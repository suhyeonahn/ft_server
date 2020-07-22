FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
    php7.3-fpm

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/
RUN chmod -R 755 /var/

RUN mkdir /var/www/localhost
COPY srcs/nginx-host-conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
RUN rm /etc/nginx/sites-enabled/default

RUN echo "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

RUN nginx -t
CMD service nginx start
CMD service php7.3-fpm start

WORKDIR /etc/nginx
CMD ["nginx"]

EXPOSE 80
