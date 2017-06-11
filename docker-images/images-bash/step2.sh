#!/bin/bash

# Build the docker image (warning, it has to be executed in the image directory)
docker build -t res/express ../express-image

# Execute the contener and map the local 9090 port on the 80 port of the contener
sudo docker run -p 9090:6666 res/express