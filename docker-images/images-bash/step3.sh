#!/bin/bash

#Step 1 and 2 have to be executed before this step!

# go to reverse proxy image dir
cd ../apache-reverse-proxy-image/content

# Clean the conf file
rm -f 001-default.conf
cat 001-default.conf.head >> 001-default.conf

# Execute the container with express server whitout mapping
docker run -d --name express res/express

# Get express ip
express_ip=$(docker inspect express | grep -i "\"ipaddress\"" | tail -n 1 | cut -d "\"" -f4)

# Write conf file for routing the express server
echo ProxyPass "/api/students/" "http://" $express_ip ":3000/" >> 001-default.conf
echo ProxyPassReverse "/api/students/" "http://" $express_ip ":3000/" >> 001-default.conf

# Execute the container with apache server whitout mapping
docker run -d --name apache_static res/apache-php

# Get apache_static ip
apache_static_ip=$(docker inspect apache_static | grep -i "\"ipaddress\"" | tail -n 1 | cut -d "\"" -f4)

# Write conf file for routing the express server
echo ProxyPass "/" "http://" $apache_static_ip ":80/" >> 001-default.conf
echo ProxyPassReverse "/" "http://" $apache_static_ip ":80/" >> 001-default.conf

# Close the conf file
cat 001-default.conf.head >> 001-default.conf

# Build the reverse-proxy image (warning, it has to be executed in the image directory)
docker build -t res/reverse-proxy ../apache-reverse-proxy-image

# Execute the contener with apache server whitout mapping
docker run -it -d --name apache_proxy res/reverse-proxy


docker run -it
-p 8080:80 php:5.6-apache /bin/bash
