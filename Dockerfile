FROM elixir:1.17-alpine

RUN adduser -u 1001 dev -s /bin/sh --system -h /home && \ 
    apk update && apk add git -q

ENV MIX_ENV=dev

USER 1001:1001

COPY --chown=1001 . /home/app 

RUN cd /home/app && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

WORKDIR /home/app