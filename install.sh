#!/bin/bash

# # 软件更新
apt-get update;

# #安装
apt-get install -y vim build-essential git gcc g++ make systemtap-sdt-dev libxml2-dev zlib1g-dev libbz2-dev libcurl4-gnutls-dev libwebp-dev libjpeg-dev libpng-dev libxpm-dev libfreetype6-dev libvpx-dev libldap2-dev libsasl2-dev unixodbc-dev libedit-dev libreadline-dev libxslt1-dev


#下载php
wget http://jp2.php.net/distributions/php-7.1.13.tar.gz

tar -zxvf php-7.1.13.tar.gz

wget https://www.openssl.org/source/openssl-1.0.1j.tar.gz

tar -zxvf openssl-1.0.1j.tar.gz

cd openssl-1.0.1j

./config && make && make install

cd ..



cd php-7.1.13

ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/

ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/

./configure --prefix=/usr/local/php --enable-bcmath --enable-calendar --enable-dba --enable-exif --enable-ftp --enable-gd-native-ttf --enable-mbregex --enable-mbstring --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --enable-zip --with-freetype-dir --with-gd --with-iconv-dir --with-icu-dir --with-jpeg-dir --with-mhash --with-png-dir --with-xmlrpc --with-zlib --with-readline --without-snmp --with-libxml-dir --with-unixODBC=/usr --with-bz2 --enable-debug --with-openssl --enable-fpm --with-fpm-user=_www --with-fpm-group=_www --with-curl --with-xsl --with-ldap --with-ldap-sasl --with-mysql-sock --with-mysqli --with-pdo-mysql=mysqlnd --disable-opcache --enable-pcntl --without-pear --enable-dtrace --disable-phpdbg --enable-zend-signals 



make && make install

cd ..

cp php.ini-development /usr/local/php/php.ini

cp php-fpm.conf.default /usr/local/php/etc/php-fpm.conf

cp sapi/fpm/php-fpm /usr/local/bin

cp /usr/local/php/etc/php-fpm.d/www.conf.default  /usr/local/php/etc/php-fpm.d/www.conf


cat >> /etc/profile << EOF
export PATH=/usr/local/nginx/sbin:$PATH
export PATH=/usr/local/php/bin:$PATH
EOF

