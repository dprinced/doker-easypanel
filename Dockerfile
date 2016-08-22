FROM centos:6.6
MAINTAINER TenxCloud <dev@tenxcloud.com>

# Install packages
RUN  yum -y install wget unzip zip bzip2 bzip2-devel tar && \
wget http://download.kanglesoft.com/easypanel/ep.sh -O ep.sh && \
sh ep.sh

# Exposed ENV
# Exposed ENV
ENV ENV ROOT_PASS **Random**
# Add volumes for MySQL
VOLUME  ["/var/lib/mysql", "/home"]

EXPOSE 80 3306 21 22 25 3311 3312 3313
CMD echo hello world
