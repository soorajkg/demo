#Author: Sooraj Gairola
#Purpose: To demonstrate creation a docker image based on Ubuntu with Nginx and demo webapp 

#Pulls the base Ubuntu Image from Docker Hub
From ubuntu:18.04

LABEL MAINTAINER="Sooraj Gairola"

# install system update and install  NGINX
RUN apt-get -y update 
RUN apt-get install -y nginx=1.14.*

#remove existing config
RUN rm -f /etc/nginx/nginx.config

#create directory
RUN mkdir -p /var/www/demo
#Lets copy the local index.html to /tmp
COPY /src/index.html /var/www/demo/index.html

COPY /config/nginx.conf /etc/nginx/nginx.conf
COPY /config/default /etc/nginx/sites-available/default

#expose port 80
EXPOSE 80/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
