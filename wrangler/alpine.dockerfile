# TODO: FIX - Getting errors compiling Rust packages for Alpine

FROM elixir:alpine

### RUST ###
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUSTUP_TOOLCHAIN=nightly-x86_64-unknown-linux-musl

RUN set -eux; \
    apk add --no-cache \
    ca-certificates \
    gcc; \
    \
    url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-musl/rustup-init"; \
    wget "$url"; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --default-toolchain nightly; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

### COPY OVER FILES
WORKDIR /app

COPY lib ./lib
COPY native ./native
COPY ["mix.exs", "mix.lock", "./"]

### SETUP AND RELEASE ###
ENV MIX_ENV=prod
RUN mix local.rebar --force \
    && mix local.hex --force \
    && mix deps.get \
    && mix release

# ---- Application Stage ----
# FROM alpine:3
# RUN apk add --no-cache --update bash openssl
# WORKDIR /app
# COPY --from=builder _build/prod/rel/wrangler/ .
# CMD ["/app/bin/wrangler", "start"]