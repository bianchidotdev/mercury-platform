# ---- Build Stage ----
FROM elixir:1.10-slim as builder

# Configure apt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils 2>&1 \
    && apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG="en_US.UTF-8"

### Rust ###
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    git procps lsb-release \
    ca-certificates curl file \
    build-essential \
    autoconf automake autotools-dev libtool xutils-dev && \
    rm -rf /var/lib/apt/lists/*

ENV SSL_VERSION=1.1.1f

RUN curl https://www.openssl.org/source/openssl-$SSL_VERSION.tar.gz -O && \
    tar -xzf openssl-$SSL_VERSION.tar.gz && \
    cd openssl-$SSL_VERSION && ./config && make depend && make install && \
    cd .. && rm -rf openssl-$SSL_VERSION*

ENV OPENSSL_LIB_DIR=/usr/local/ssl/lib \
    OPENSSL_INCLUDE_DIR=/usr/local/ssl/include \
    OPENSSL_STATIC=1

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly -y

ENV PATH="/root/.cargo/bin:${PATH}"

### COPY FILES ###

# Create the application build directory
RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=prod
COPY lib ./lib
COPY native ./native
COPY ["mix.exs", "mix.lock", "./"]

### SETUP AND RELEASE ###

RUN mix local.rebar --force \
    && mix local.hex --force \
    && mix deps.get \
    && mix release

# ---- Application Stage ----
FROM debian:buster-slim AS app

ENV MIX_ENV=prod \
  LANG=C.UTF-8 \
  PORT=4000

# Exposes port to the host machine
EXPOSE $PORT

# Set dirs not available in stretch-slim package, needed for postgresql-client
# RUN seq 1 8 | xargs -I{} mkdir -p /usr/share/man/man{}

# Install stable dependencies that don't change often
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  bash openssl && \
  rm -rf /var/lib/apt/lists/*

# postgresql-client && \

# Copy the build artifact from the builder stage and create a non root user
RUN useradd --create-home wrangler
WORKDIR /home/wrangler
COPY --from=builder /app/_build/prod/rel/wrangler/ .
RUN chown -R wrangler: /home/wrangler/
USER wrangler

# Run the release
CMD ["/home/wrangler/bin/wrangler", "start"]
