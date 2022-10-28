FROM alpine:3.16

RUN	apk update && \
	apk add --upgrade apk-tools && \
	apk upgrade --available && \
	apk add mariadb mariadb-client mariadb-server-utils linux-pam linux-pam-dev bash openssh-server-pam

RUN 	mkdir /mysql && \
	chown -R mysql:mysql /mysql && \
	chown -R mysql:mysql /var/lib/mysql

COPY	--chown=mysql --chmod=770x tools/* /mysql 
COPY	--chown=mysql conf/my.cnf /etc/mysql/my.cnf

USER	mysql

WORKDIR		/mysql
ENTRYPOINT	/mysql/generateDbSetupCommands.sh > /var/lib/mysql/logs 2>&1 
