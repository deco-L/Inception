# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: csakamot <csakamot@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/01 14:21:20 by csakamot          #+#    #+#              #
#    Updated: 2024/12/05 23:14:57 by csakamot         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SHELL = bash

##----Directory Location----##
SRCDIR = ./srcs/

DATABASEDIR = ${SRCDIR}database/

WEBDIR = ${SRCDIR}web/
##--------------------------##

##------Makefile rules------##
all: build up

build:
	@cd ${SRCDIR}
	docker compose build

up:
	ifeq (, $(wildcard ${DATABASEDIR} ${WEBDIR}))
		@printf "ok let's go!"
	else
		${RM} -rf ${DATABASEDIR} ${WEBDIR}
	endif
	@cd ${SRCDIR}
	docker compose up

down:
	@cd ${SRCDIR}
	docker compose down

clean:
	${RM} -rf ${DATABASEDIR} ${WEBDIR}

.PHONY: build up down clean
##--------------------------##