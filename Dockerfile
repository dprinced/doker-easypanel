FROM centos:6.6
MAINTAINER TenxCloud <dev@tenxcloud.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN yum -y install tar unzip wget && \
wget http://download.kanglesoft.com/easypanel/ep.sh -O ep.sh && \
sh ep.sh
# Add image configuration and scripts

# Install packages
# RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /home

# Exposed ENV
ENV ROOT_PASS **Random**
ENV PHP_UPLOAD_MAX_FILESIZE 10G
ENV PHP_POST_MAX_SIZE 10G
# Add volumes for MySQL
VOLUME  ["/etc/mysql", "/var/lib/mysql", "/home"]

EXPOSE 80 3306 22 21 3311 3312 3313
