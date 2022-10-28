FROM alpine:3.16

RUN	apk update && \
	apk add --upgrade apk-tools && \
	apk upgrade --available && \
	apk add mariadb-client curl bash mysql-client php8 \
	php8-dom php8-ftp php8-gd php8-openssl \
	php8-phar php8-iconv php8-mbstring \
	php8-mongodb php8-mysqli php8-zlib php8-fpm

RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	mv ./wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

COPY	--chmod=x tools/setup.sh /usr/local/

WORKDIR /www

ENTRYPOINT /usr/local/setup.sh
#ENTRYPOINT bash

