FROM elixir:1.11-alpine as builder

ENV LANG=C.UTF-8 \
  PORT=4000

RUN apk add --no-cache --update \
  bash \
  curl \
  openssl

WORKDIR /app

COPY mix.* ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile

COPY . ./

### SETUP AND RELEASE ###
ENV MIX_ENV=prod
RUN mix release

# ---- Application Stage ----
FROM alpine:3
RUN apk add --no-cache --update bash openssl

RUN addgroup -S wrangler && adduser -S wrangler -G wrangler
USER wrangler

WORKDIR /home/wrangler
COPY --from=builder --chown=wrangler:wrangler ["/app/_build/prod/rel/wrangler/", "/app/docker-entrypoint.sh", "."]

# Run the release
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/home/wrangler/bin/wrangler", "start"]
