FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
    php-fpm
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
RUN touch /var/www/html/test.php
RUN echo "<?php phpinfo(); ?>" >> /var/www/html/test.php

COPY srcs /etc/nginx/sites-available/
RUN service nginx reload

WORKDIR /etc/nginx

CMD ["nginx"]

EXPOSE 80 443
