FROM php:5.6-apache

COPY content/ /etc/apache2/sites-available

RUN a2enmod proxy proxy_http
RUN a2ensite 000-* 001-*