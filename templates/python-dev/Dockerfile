# syntax=docker/dockerfile:1
FROM docker.io/library/python:3.10-slim-bullseye

ARG UNAME=user
ARG UID=1000
ARG GID=1000

ENV PYTHONUNBUFFERED=1

RUN set -ex \
    && apt-get update \
    && apt-get install \
      curl gcc vim make git wget cmake \
      -y \
    && rm -rf /var/lib/apt/lists/*

RUN set -ex \
    && groupadd -g $GID -o $UNAME \
    && useradd --create-home --shell /bin/bash --home /home/$UNAME \
        -u $UID -g $GID $UNAME

USER $UNAME
RUN mkdir /home/$UNAME/app
WORKDIR /home/$UNAME/app

ENV VIRTUAL_ENV /home/$UNAME/app/venv
ENV PATH /home/$UNAME/app/venv/bin:$PATH
ENV TERM xterm-256color
