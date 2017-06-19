#!/bin/bash

#Step 1 and 2 have to be executed before this step!
#Clean
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

## Execute the container with express server whitout mapping
docker run -d --name express res/express

## Execute the container with apache server whitout mapping
docker run -d --name apache_static res/apache-php

# Build the reverse-proxy image (warning, it has to be executed in the image directory)
chmod 755 ../apache-reverse-proxy-image-dynamic/apache2-forground
docker build -t res/reverse-proxy-2 ../apache-reverse-proxy-image-dynamic

# Execute the reverse proxy container
docker run -p 8080:80 res/reverse-proxy-2


#docker run -it php:5.6-apache /bin/bash
