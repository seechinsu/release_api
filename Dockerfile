FROM elixir:1.9.4-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get --only $MIX_ENV 
RUN mix deps.compile

# build assets
# COPY assets/package.json assets/package-lock.json ./assets/
# RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
# COPY assets assets
# RUN npm run --prefix ./assets deploy
# RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix compile
RUN mix release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --no-cache bash openssl ncurses-libs postgresql-client

EXPOSE 4000

# RUN mkdir /app
WORKDIR /app

# RUN chown nobody:nobody /app

# USER nobody:nobody

COPY --from=build /app/_build/prod/rel/release_api .
COPY entrypoint.sh .
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

# CMD ["bin/release_api", "start"]

CMD ["bash", "/app/entrypoint.sh"]