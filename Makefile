# Variables
COMPOSE_FILE = srcs/docker-compose.yml
ENV_FILE = .env

# Default action
all: build up

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
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down

# Rebuild the project from scratch
re: down all

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
	docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) logs

.PHONY: all build up down re ps logs
