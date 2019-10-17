#!/bin/bash

# # 软件更新
apt-get update;

# #安装
apt-get install -y vim build-essential git gcc g++ make systemtap-sdt-dev libxml2-dev zlib1g-dev libbz2-dev libcurl4-gnutls-dev libwebp-dev libjpeg-dev libpng-dev libxpm-dev libfreetype6-dev libvpx-dev libldap2-dev libsasl2-dev unixodbc-dev libedit-dev libreadline-dev libxslt1-dev libpq-dev libgd2-xpm libgd2-xpm-dev libpcre3-dev libssl-dev libgd-dev google-perftools libgoogle-perftools-dev libperl-dev

echo "安装nginx"

wget https://nginx.org/download/nginx-1.16.1.tar.gz

wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz


#安装zlib
wget http://zlib.net/zlib-1.2.11.tar.gz

wget https://www.openssl.org/source/openssl-1.0.1j.tar.gz

tar -zxvf openssl-1.0.1j.tar.gz

tar xzvf nginx-1.16.1.tar.gz
tar xzvf pcre-8.43.tar.gz
tar xzvf zlib-1.2.11.tar.gz


tar -zxvf openssl-1.0.1j.tar.gz

cd openssl-1.0.1j

./config && make && make install

cd ..

cd nginx-1.16.1

./configure \
  --prefix=/usr/local/nginx \
  --with-pcre=../pcre-8.43 \
  --with-openssl=../openssl-1.0.1j \
  --with-zlib=../zlib-1.2.11 \
  --with-file-aio --with-ipv6 --with-http_auth_request_module --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug

make && make install

cd ..

cp -f  nginx.conf /usr/local/nginx/conf/nginx.conf

cp index.php /usr/local/nginx/html/index.php

cat profile  >> /etc/profile 

source /etc/profile

apt-get update
