down:
	podman-compose down -t 1

start: down
	podman-compose build && podman-compose run server bash

up: down
	podman-compose build && podman-compose up

clear:
	python -Bc "import pathlib; [p.unlink() for p in pathlib.Path('.').rglob('*.py[co]')]"
	python -Bc "import pathlib; [p.rmdir() for p in pathlib.Path('.').rglob('__pycache__')]"
