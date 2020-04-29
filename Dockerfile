FROM node:12.16.3-stretch-slim as node
RUN npm -v \
 && yarn -v
FROM ruby:2.6.6-slim-stretch
RUN apt-get update -qq \
 && apt-get install -y --no-install-recommends \
    build-essential libpq-dev git \
 && rm -rf /var/lib/apt/lists

ENV YARN_VERSION 1.22.4
COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR /app
