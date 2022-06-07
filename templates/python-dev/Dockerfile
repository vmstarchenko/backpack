# syntax=docker/dockerfile:1
FROM python:3.10-slim-bullseye

ENV PYTHONUNBUFFERED=1

RUN set -ex \
    && apt-get update \
    && apt-get install \
      curl gcc vim make git wget cmake \
      -y \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash --home /home/user user
USER user
WORKDIR /home/user

ENV VIRTUAL_ENV /home/user/venv
ENV PATH /home/user/venv/bin:$PATH
ENV TERM xterm-256color
