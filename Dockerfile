FROM debian:buster
MAINTAINER suahn <suahn@student.42.fr>

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
    php-fpm \
	php-mysql
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
RUN touch /var/www/html/info.php
RUN echo "<?php phpinfo(); ?>" >> /var/www/html/info.php

COPY srcs /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
RUN unlink /etc/nginx/sites-enabled/default

RUN	nginx -t
RUN service nginx reload

WORKDIR /etc/nginx

CMD ["nginx"]

EXPOSE 80 443
