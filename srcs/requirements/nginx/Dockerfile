FROM alpine:3.16

RUN	apk update && \
	apk add --upgrade apk-tools && \
	apk upgrade --available && \
	apk add nginx openssl
	
RUN	adduser -D -g 'www' www && \
	mkdir /www

RUN	openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
	-out /var/lib/nginx/nginx.pem -keyout /var/lib/nginx/nginx.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42school/OU=student/CN=fschlute"

COPY	conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
