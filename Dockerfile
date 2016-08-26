FROM index.tenxcloud.com/tenxcloud/centos:6.6
MAINTAINER TenxCloud <dev@tenxcloud.com>

# Install packages
RUN mkdir -p /data && mkdir -p /data/vhs
RUN mkdir -p /vhs && ln -s /data/vhs /vhs
RUN  yum -y install wget unzip zip bzip2 bzip2-devel tar && \
wget http://download.kanglesoft.com/easypanel/ep.sh -O ep.sh && \
sh ep.sh
ADD data.sh /data.sh
RUN chmod 755 /*.sh
# Remove pre-installed database
RUN  mv -f /etc /data/ && ln -s /data/etc /etc
RUN  mv -f /var /data/ && ln -s /data/var /var
RUN  mv -f /home /data/ && ln -s /data/home /home
RUN  zip -r data.zip data
# Exposed ENV
ENV ROOT_PASS **Random**
# Add volumes for MySQL
VOLUME  ["/data"]

EXPOSE 80 3306 21 22 25 3311 3312 3313
CMD /run.sh & /vhs/kangle/bin/kangle
