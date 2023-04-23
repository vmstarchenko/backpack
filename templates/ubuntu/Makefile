down:
	podman-compose down -t 1

start: down
	podman-compose build && podman-compose run server bash
