FROM elixir:1.5
MAINTAINER Dave Long <dlong@cagedata.com>

RUN mix do local.hex --force, local.rebar --force

WORKDIR /app
ADD . /app

RUN mix compile

RUN chgrp -R 0 /app \
      && chmod -R g+rwX /app

USER 1001

EXPOSE 4000

CMD ["mix run --no-halt"]
