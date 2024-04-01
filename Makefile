# Variables
COMPOSE_FILE = srcs/docker-compose.yml

## TODO: Pass the full path of the VM here
ENV_FILE = srcs/.env

# Default action
all: build up

bonus: all

# Build Docker images using docker-compose
build:
	@printf "\e[38;5;27m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;27m ║          Building Docker images        ║ \e[0m\n"
	@printf "\e[38;5;27m ╚════════════════════════════════════════╝ \e[0m\n"
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) build

# Create and start containers
up:
	@printf "\e[38;5;46m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;46m ║    Creating and starting containers    ║ \e[0m\n"
	@printf "\e[38;5;46m ╚════════════════════════════════════════╝ \e[0m\n"
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d

# Stop and remove containers, networks, images, and volumes
down:
	@printf "\e[38;5;196m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;196m ║ Stopping/removing containers & volumes ║ \e[0m\n"
	@printf "\e[38;5;196m ╚════════════════════════════════════════╝ \e[0m\n"
	docker-compose -f $(COMPOSE_FILE) down

# Rebuild the project from scratch
re: down all

# Remove all containers, images, and volumes
clean: down
	@printf "\e[38;5;196m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;196m ║    Cleaning all containers & volumes   ║ \e[0m\n"
	@printf "\e[38;5;196m ╚════════════════════════════════════════╝ \e[0m\n"
	sudo docker system prune -a
	
fclean:
	@printf "\e[38;5;196m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;196m ║    Cleaning all containers & volumes   ║ \e[0m\n"
	@printf "\e[38;5;196m ╚════════════════════════════════════════╝ \e[0m\n"
	sudo docker stop $$(sudo docker ps -qa)
	sudo docker system prune --all --force --volumes
	sudo docker network prune --force
	sudo docker volume prune --force

# Display status of containers
ps:
	@printf "\e[38;5;226m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;226m ║    Displaying status of containers     ║ \e[0m\n"
	@printf "\e[38;5;226m ╚════════════════════════════════════════╝ \e[0m\n"
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) ps

# View output from containers
logs:
	@printf "\e[38;5;93m ╔════════════════════════════════════════╗ \e[0m\n"
	@printf "\e[38;5;93m ║         Viewing logs from containers   ║ \e[0m\n"
	@printf "\e[38;5;93m ╚════════════════════════════════════════╝ \e[0m\n"
	docker-compose -f $(COMPOSE_FILE) logs

remove:
	sudo rm -rf ~/data/wordpress/
	sudo rm -rf ~/data/mariadb/
	sudo mkdir -p ~/data/mariadb/ ~/data/wordpress/
	docker stop $$(docker ps -qa); docker rm $$(docker ps -qa);
	docker volume rm srcs_wordpress_vol; 
	docker volume rm srcs_mariadb_vol; 
	docker rmi -f $$(docker images -qa);
	docker network rm $$(docker network ls -q) 2>/dev/null

.PHONY: all build up down clean fclean re ps logs
