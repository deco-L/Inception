SHELL = bash

##----Directory Location----##
SRCDIR = ./srcs/
##--------------------------##

##------Makefile rules------##
all: proxy build up

build:
	docker compose -f srcs/docker-compose.yml build

proxy:
	@sh ${SRCDIR}/proxySetting.sh

up:
	mkdir -p ${HOME}/data/web ${HOME}/data/database && \
	cd ${SRCDIR} && docker compose up -d

down:
	cd ${SRCDIR} && \
	docker compose down

clean:
	docker-compose -f srcs/docker-compose.yml down --volumes

.PHONY: build up down clean
##--------------------------##
