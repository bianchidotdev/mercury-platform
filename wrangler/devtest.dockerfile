FROM elixir:1.10-alpine

ENV LANG=C.UTF-8 \
  PORT=4000

RUN apk add bash curl

WORKDIR /app

COPY mix.* ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile

COPY . ./

RUN mix compile

CMD /bin/bash
