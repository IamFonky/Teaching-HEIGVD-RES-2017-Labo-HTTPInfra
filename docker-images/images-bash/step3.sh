#!/bin/bash


# Execute the contener with apache server whitout mapping
docker run -d --name apache_static res/apache-php

# Get apache_static ip
apache_static_ip=$(docker inspect apache_static | grep -i "\"ipaddress\"" | tail -n 1 | cut -d "\"" -f4)

# Execute the contener with apache server whitout mapping
docker run -d --name express res/apache-php

# Get apache_static ip
express_ip=$(docker inspect apache_static | grep -i "\"ipaddress\"" | tail -n 1 | cut -d "\"" -f4)


echo ProxyPass "/api/students/" "http://" $express_ip ":3000/" >> 001-default.conf
echo ProxyPassReverse "/api/students/" "http://" $express_ip ":3000/" >> 001-default.conf


#... run expressdocker

# Build the reverse-proxy image (warning, it has to be executed in the image directory)
docker build -t res/reverse-proxy ../apache-reverse-proxy-image

# Execute the contener with apache server whitout mapping
docker run -it -d --name apache_proxy res/reverse-proxy


docker run -it
-p 8080:80 php:5.6-apache /bin/bash
