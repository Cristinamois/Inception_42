FROM debian:buster

RUN apt-get update -yq \
	&&  apt install php-fpm -yq\
	&& apt-get -y install php-cli php-mysql php-curl php-gd php-intl

WORKDIR /var/www/

RUN apt-get update -yq  && apt-get install wget -yq\
	&& wget https://wordpress.org/wordpress-5.9.3.tar.gz\
	&& tar -xzvf wordpress-5.9.3.tar.gz\
	&& rm wordpress-5.9.3.tar.gz\
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /

COPY conf/wp-config.php /var/www/wordpress/wp-config.php
COPY conf/www.conf etc/php/7.3/fpm/pool.d/wordpress.conf 
COPY tools/entrypoint.sh /
RUN rm -f etc/php/7.3/fpm/pool.d/www.conf
# COPY tools/cv /var/www/cv
RUN chown -R www-data:www-data /var/www/wordpress/*\
	&& service php7.3-fpm start && service php7.3-fpm stop 

VOLUME  "/var/www/wordpress"
EXPOSE 9000

ENTRYPOINT  [ "sh", "entrypoint.sh"]
