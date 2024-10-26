# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:22.04
# FROM docker.io/nvidia/cuda:12.5.1-cudnn-runtime-ubuntu22.04

ARG UNAME=user
ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install \
      curl gcc vim make git wget cmake less \
      cura \
      -y \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && apt-get update \
    && apt-get install \
      mesa-utils \
      tk libglib2.0-0 \
      libgl1-mesa-glx libgl1 libglib2.0-0 git-lfs libcairo2-dev pkg-config freecad \
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
