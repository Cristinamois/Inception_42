NAME = Inception
SUDO_PWD = cmois
PATH_TO_DB_VOLUME = /home/cmois/data/mariadb
PATH_TO_WP_VOLUME = /home/cmois/data/wordpress

all: $(NAME)

$(NAME):
	@echo $(SUDO_PWD) | sudo -Sk systemctl start docker
ifeq "$(shell cat /etc/hosts | grep 127.0.0.1 | grep cmois.42.fr)" ""
	@echo "Adding host cmois.42.fr.."
	@echo $(SUDO_PWD) | sudo -Sk sed -ie 's/127.0.0.1[[:blank:]]localhost/127.0.0.1 localhost cmois.42.fr/' /etc/hosts
endif
ifeq ("$(wildcard $(PATH_TO_DB_VOLUME))","")
	@echo "Creating directory for mariadb volume..."
	@echo $(SUDO_PWD) | sudo -Sk mkdir -p $(PATH_TO_DB_VOLUME)
endif
ifeq ("$(wildcard $(PATH_TO_WP_VOLUME))","")
	@echo "Creating directory for wordpress volume..."
	@echo $(SUDO_PWD) | sudo -Sk mkdir -p $(PATH_TO_WP_VOLUME)
endif
	@docker-compose -f ./srcs/docker-compose.yml -p $(NAME) up 

nginx:
	@docker-compose -f ./srcs/docker-compose.yml -p $(NAME) build nginx

mariadb:
	@docker-compose -f ./srcs/docker-compose.yml -p $(NAME) build mariadb

wordpress:
	@docker-compose -f ./srcs/docker-compose.yml -p $(NAME) build wordpress

clean:
	@docker-compose -f ./srcs/docker-compose.yml -p $(NAME) down

fclean: clean
	
	@-docker stop $$(docker ps -a -q)
	@-docker rm $$(docker ps -a -q)
	@-docker container rm $$(docker ps -aq) -f
	@docker container ls -aq | xargs --no-run-if-empty docker container rm -f
	@docker system prune -a

re: fclean all
