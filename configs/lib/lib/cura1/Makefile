#!/usr/bin/make

SHELL = /bin/sh

GROUP_ID := 1002
USER_ID := 1002

export GROUP_ID
export USER_ID

down:
	podman-compose down -t 1

start: down
	podman-compose build && podman-compose run server bash

up: down
	podman-compose build && podman-compose --in-pod false up || time sleep 10000
