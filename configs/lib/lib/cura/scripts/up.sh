set -ex

ROOT=$(dirname $(dirname $(realpath "$0")))

podman-compose -f $ROOT/docker-compose.yml down -t 1
pactl load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket || true
podman-compose -f $ROOT/docker-compose.yml build
podman-compose -f $ROOT/docker-compose.yml up
