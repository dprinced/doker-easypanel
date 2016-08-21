FROM centos:6.6
MAINTAINER TenxCloud <dev@tenxcloud.com>

# Install packages
RUN  yum update && \
yum -y install tar unzip wget && \
wget http://download.kanglesoft.com/easypanel/ep.sh -O ep.sh && \
sh ep.sh

# Exposed ENV
# Add volumes for MySQL
VOLUME  ["/var/lib/mysql", "/home"]

EXPOSE 80 3306 22 21 3311 3312 3313
