

FROM debian:buster

RUN apt update -yq \
	&& apt install mariadb-server-10.3 -yq

COPY conf/script_mysql_secure_installation ./script_mysql_secure_installation
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf 

RUN service mysql start\
	&&  bash script_mysql_secure_installation\
	&& mv /var/lib/mysql/aria_log_control /root/

COPY tools/entrypoint.sh /entrypoint.sh


EXPOSE 3306 
VOLUME  "/var/lib/mysql"

ENTRYPOINT  [ "sh", "entrypoint.sh"]