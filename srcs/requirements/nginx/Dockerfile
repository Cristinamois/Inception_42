FROM debian:buster

RUN apt-get update -yq \
	&& apt-get install nginx -yq\
	&& apt-get install openssl\
	&& rm etc/nginx/sites-enabled/default


WORKDIR /etc/nginx/
RUN openssl req -x509 -newkey rsa:2048 -nodes -keyout cmois.42.fr.key -out cmois.42.fr.crt -days 365 \
	-subj "/C=FR/ST=France/L=Paris/O=42, Inc./OU=IT/CN=cmois.42.fr"
WORKDIR /

COPY conf/default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ && rm -rf /var/www/html

VOLUME "/var/www/wordpress"
EXPOSE 443

ENTRYPOINT nginx -g 'daemon off;'

