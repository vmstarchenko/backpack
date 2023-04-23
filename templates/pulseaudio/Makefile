down:
	podman-compose down -t 1

start: down
	pactl load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket || true
	podman-compose build && podman-compose run server bash
