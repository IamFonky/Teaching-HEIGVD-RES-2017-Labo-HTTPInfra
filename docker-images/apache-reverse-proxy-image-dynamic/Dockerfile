FROM php:5.6-apache

RUN apt-get update && \
	apt-get install -y vim

RUN ls -la /usr/local/bin/
#COPY apache2-foreground /usr/local/bin/
#RUN chmod 755 /usr/local/bin/apache2-foreground
COPY apache2-foreground /usr/local/bin/
#RUN chmod 755 /usr/local/bin/apache2-foreground
RUN ls -la /usr/local/bin/
RUN cd /usr/local/bin; ./apache2-foreground

COPY templates /var/apache2/templates
COPY content/ /etc/apache2/sites-available

RUN a2enmod proxy proxy_http
RUN a2ensite 000-* 001-*
