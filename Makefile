.PHONY: build scan

IMAGE=django-auth0-demo
VERSION=latest

all: build

build:
	@echo building container
	export DOCKER_CONTENT_TRUST=1
	docker-compose build --progress=plain

build-nc:
	@echo building container
	export DOCKER_CONTENT_TRUST=1
	docker-compose pull
	docker-compose build --no-cache --progress=plain

clean:
	@echo stop all running containers
	docker-compose stop
	@echo cleaning old containers
	docker-compose rm -f

run: build
	@echo launching app
	docker-compose up -d