#!/bin/bash

# Build the docker image (warning, it has to be executed in the image directory)
docker build -t res/apache-php ../apache-php-image

# Execute the contener and map the local 9090 port on the 80 port of the contener
sudo docker rm apache_static
sudo docker run --name apache_static -p 9090:80 res/apache-php