FROM node:10.16.0-stretch-slim as node
FROM ruby:2.6.3-slim-stretch
RUN apt-get update -qq \
 && apt-get install -y --no-install-recommends \
    build-essential libpq-dev git \
 && rm -rf /var/lib/apt/lists

ENV YARN_VERSION 1.16.0
COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR /app
