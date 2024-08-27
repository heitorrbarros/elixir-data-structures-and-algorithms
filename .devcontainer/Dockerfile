FROM elixir:1.17-alpine

ARG USER=vscode

RUN apk update && apk add git -q

ARG HOME=/home/${USER}

ENV MIX_ENV=dev
WORKDIR /home/${USER}

COPY . ./app 

RUN cd ./app && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get


WORKDIR /home/${USER}/app

