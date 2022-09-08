.PHONY: build
build:
	docker build -f Dockerfile-shiny --rm -t bitsi-docker-shiny .
	docker build -f Dockerfile-plumber --rm -t bitsi-docker-plumber .

.PHONY: kill
kill:
	echo "docker ps -a:"
	echo ""
	docker ps -a
	echo ""
	echo "stopping and removing above containers"
	echo ""
	docker stop $$(docker ps -a -q) ## need double $$ to escape for shell
	docker rm $$(docker ps -a -q)
	echo ""
	echo "docker ps -a:"
	echo ""
	docker ps -a

.PHONY: up
up:
	docker-compose up -d

.PHONY: in
in:
	docker exec -it -t bitsi-docker-shiny-1 bash

.PHONY: push
push:
	docker tag bitsi-docker-plumber chendaniely/bitsi-docker-plumber
	docker push chendaniely/bitsi-docker-plumber

	docker tag bitsi-docker-shiny chendaniely/bitsi-docker-shiny
	docker push chendaniely/bitsi-docker-shiny

.PHONY: pull
pull:
	docker pull chendaniely/bitsi-docker-plumber
	docker pull chendaniely/bitsi-docker-shiny

