# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:22.04

ARG UNAME=user
ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install \
      curl gcc vim make git wget cmake less \
      planner \
      -y \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && groupadd -g $GID -o $UNAME \
    && useradd --create-home --shell /bin/bash --home /home/$UNAME \
        -u $UID -g $GID $UNAME

USER $UNAME
RUN mkdir /home/$UNAME/app
WORKDIR /home/$UNAME/app

ENV TERM xterm-256color
