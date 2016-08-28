#!/bin/bash

if [ ! -e /data/home ]; then
    mv -f /mydata/* /data/
fi

/vhs/kangle/bin/kangle
exec mysqld_safe
if [ "${MYSQL_PASS}" != "**None**" ]; then
    mysqladmin -u root password '${MYSQL_PASS}'
    echo "mysql -uroot -p${MYSQL_PASS} -h<host> -P<port>"
fi
