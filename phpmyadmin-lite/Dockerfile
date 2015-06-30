FROM debian:jessie

MAINTAINER Tim Robinson <tim@panubo.com>

RUN apt-get update && \
  apt-get install -y curl bzip2 php5-cli php5-intl php-apc php5-gd php5-mysqlnd php5-mcrypt php-http-request2

EXPOSE 8000

CMD ["/usr/bin/php","-S","0.0.0.0:8000","-t","/var/www/html"]

ENV UPLOAD_MAX_FILESIZE 10M
ENV POST_MAX_SIZE 10M

RUN sed -i 's/^upload_max_filesize.*/upload_max_filesize = ${UPLOAD_MAX_FILESIZE}/' /etc/php5/cli/php.ini && \
  sed -i 's/^post_max_size.*/post_max_size = ${POST_MAX_SIZE}/' /etc/php5/cli/php.ini

ENV PHPMYADMIN_VERSION 4.4.10
RUN mkdir -p /var/www/html && \
  curl -L http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.tar.bz2 | tar -C /var/www/html --strip-components 1 -jxf -

ENV SD_SERVICE_NAME "mysql*"
COPY php-extras /usr/share/php/
COPY config.inc.php /var/www/html/config.inc.php

# USER has to go at the end
USER www-data
