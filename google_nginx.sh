#!/bin/bash

echo "==============================安装更新软件======================================"
apt-get update
apt-get install  gcc g++ make git libxml2-dev libxslt1-dev libgeoip-dev libgd-dev google-perftools libgoogle-perftools-dev libperl-dev -y
wget http://nginx.org/download/nginx-1.19.0.tar.gz
wget http://zlib.net/zlib-1.2.11.tar.gz
wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
git clone -b dev https://github.com/cuber/ngx_http_google_filter_module
git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module

tar -zxvf nginx-1.19.0.tar.gz 
tar -zxvf openssl-1.1.1g.tar.gz 
tar -zxvf pcre-8.44.tar.gz
tar -zxvf zlib-1.2.11.tar.gz

cd openssl-1.1.1g/
./config && make && make install
cd ..

cd nginx-1.19.0/
./configure \
  --prefix=/usr/local/nginx \
  --with-pcre=../pcre-8.44 \
  --with-openssl=../openssl-1.1.1g \
  --with-zlib=../zlib-1.2.11 \
  --add-module=../ngx_http_google_filter_module \
  --add-module=../ngx_http_substitutions_filter_module \
  --with-file-aio --with-ipv6 --with-http_auth_request_module --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug

make && make install
cd ..

cat ngx_profile  >> /etc/profile 

echo "==============================================================================="