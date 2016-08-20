FROM centos:6.6
MAINTAINER TenxCloud <dev@tenxcloud.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN yum -y install unzip wget && \
wget http://download.kanglesoft.com/easypanel/ep.sh -O ep.sh && \
sh ep.sh

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10G
ENV PHP_POST_MAX_SIZE 10G

# Install packages
RUN yum update && DEBIAN_FRONTEND=noninteractive yum -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh

# RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /app

# Exposed ENV
ENV MYSQL_USER admin
ENV MYSQL_PASS **Random**
ENV ROOT_PASS **Random**
ENV AUTHORIZED_KEYS **None**

# Add volumes for MySQL
VOLUME  ["/etc/mysql", "/var/lib/mysql", "/app"]

EXPOSE 80 3306 22 3311 3312 3313
