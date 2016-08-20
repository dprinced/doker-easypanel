FROM centos:6.6
MAINTAINER TenxCloud <dev@tenxcloud.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN yum -y install tar unzip wget && \
wget http://download.kanglesoft.com/easypanel/ep.sh -O ep.sh && \
sh ep.sh && \
1 && \
Q12405763351 && \

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Install packages
RUN yum update && DEBIAN_FRONTEND=noninteractive yum -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh

# RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /app

# Exposed ENV
ENV ROOT_PASS **Random**
ENV AUTHORIZED_KEYS **None**
ENV PHP_UPLOAD_MAX_FILESIZE 10G
ENV PHP_POST_MAX_SIZE 10G
# Add volumes for MySQL
VOLUME  ["/etc/mysql", "/var/lib/mysql", "/app"]

EXPOSE 80 3306 22 3311 3312 3313
