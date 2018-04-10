#!/bin/bash

# # 软件更新
apt-get update;

# #安装
apt-get install -y vim build-essential git gcc g++ make systemtap-sdt-dev libxml2-dev zlib1g-dev libbz2-dev libcurl4-gnutls-dev libwebp-dev libjpeg-dev libpng-dev libxpm-dev libfreetype6-dev libvpx-dev libldap2-dev libsasl2-dev unixodbc-dev libedit-dev libreadline-dev libxslt1-dev libpq-dev pgadmin3 postgresql postgresql-client

echo "-----------------安装php--------------------------"

#下载php
wget http://jp2.php.net/distributions/php-7.2.4.tar.gz

tar -zxvf php-7.2.4.tar.gz

wget https://www.openssl.org/source/openssl-1.0.1j.tar.gz

tar -zxvf openssl-1.0.1j.tar.gz

cd openssl-1.0.1j

./config && make && make install

cd ..



cd php-7.2.4

ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/

ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/

./configure --prefix=/usr/local/php --enable-bcmath --enable-calendar --enable-dba --enable-exif --enable-ftp --enable-gd-native-ttf --enable-mbregex --enable-mbstring --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --enable-zip --with-freetype-dir --with-gd --with-iconv-dir --with-icu-dir --with-jpeg-dir --with-mhash --with-png-dir --with-xmlrpc --with-zlib --with-readline --without-snmp --with-libxml-dir --with-unixODBC=/usr --with-bz2 --enable-debug --with-openssl --enable-fpm --with-fpm-user=_www --with-fpm-group=_www --with-curl --with-xsl --with-ldap --with-ldap-sasl --with-mysql-sock --with-mysqli --with-pdo-mysql=mysqlnd --disable-opcache --enable-pcntl --without-pear --enable-dtrace --disable-phpdbg --enable-zend-signals --with-pdo_pgsql --enable-opcache


make && make install

cd ..

cp php.ini-development /usr/local/php/php.ini

cp php-fpm.conf.default /usr/local/php/etc/php-fpm.conf

cp php-7.2.4/sapi/fpm/php-fpm /usr/local/bin

cp /usr/local/php/etc/php-fpm.d/www.conf.default  /usr/local/php/etc/php-fpm.d/www.conf


echo "安装nginx"

wget http://nginx.org/download/nginx-1.13.11.tar.gz

wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz


#安装zlib
wget http://zlib.net/zlib-1.2.11.tar.gz

# 安装ngx_http_google_filter_module扩展

git clone https://github.com/cuber/ngx_http_google_filter_module

# 安装substitutions 扩展

git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module

tar xzvf nginx-1.13.11.tar.gz
tar xzvf pcre-8.38.tar.gz
tar xzvf zlib-1.2.11.tar.gz

cd nginx-1.13.11

./configure \
  --prefix=/usr/local/nginx \
  --with-pcre=../pcre-8.38 \
  --with-openssl=../openssl-1.0.1j \
  --with-zlib=../zlib-1.2.11 \
  --with-http_ssl_module \
  --add-module=../ngx_http_google_filter_module \
  --add-module=../ngx_http_substitutions_filter_module

make && make install

cd ..

cp -f  nginx.conf /usr/local/nginx/conf/nginx.conf

cp index.php /usr/local/nginx/html/index.php

cat profile  >> /etc/profile 

source /etc/profile

apt-get update