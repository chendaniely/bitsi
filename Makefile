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
