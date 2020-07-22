FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
php7.3 php-fpm

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

COPY srcs/nginx-host-conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
RUN rm /etc/nginx/sites-enabled/default

RUN echo "<?php phpinfo(); ?>" >> /var/www/html/phpinfo.php

RUN mkdir -p /run/php && touch /run/php/php7.3-fpm.sock
RUN chown www-data:www-data /run/php/php7.3-fpm.sock 


RUN chown -R www-data:www-data /var/
RUN chmod -R 755 /var/

#RUN service php7.3-fpm restart

RUN nginx -t

WORKDIR /etc/nginx

EXPOSE 80

CMD service php7.3-fpm restart \
	&& service nginx restart \
	 nginx
