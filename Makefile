# Define the Docker Compose project name
PROJECT_NAME = althaia

# Define the Docker Compose file
DOCKER_COMPOSE_FILE = docker-compose.yml

# Define the Docker Compose command
DOCKER_COMPOSE = docker compose

# Define the Django container name
DJANGO_CONTAINER = web


# Build the Docker containers
build:
	$(DOCKER_COMPOSE) build

# Start the Docker containers
up:
	$(DOCKER_COMPOSE) up -d

# Stop the Docker containers
down:
	$(DOCKER_COMPOSE) down

# Restart the Django container
restart:
	$(DOCKER_COMPOSE) restart django

# Run the Django development server
runserver:
	$(DOCKER_COMPOSE) exec $(DJANGO_CONTAINER) python manage.py runserver 0.0.0.0:8000

# Generate the requirements.txt file from the requirements.in file
generate-requirements:
	$(DOCKER_COMPOSE) run --rm $(PIPTOOLS_CONTAINER) pip-compile requirements.in

# Install the project dependencies
install:
	$(DOCKER_COMPOSE) run --rm $(PIPTOOLS_CONTAINER) pip-sync requirements.txt
