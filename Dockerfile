FROM node:10.15.1-stretch-slim as node
FROM ruby:2.6.2-slim-stretch
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential libpq-dev git

ENV YARN_VERSION 1.13.0
COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

ARG appname=/last-time-webapp
RUN mkdir ${appname}
WORKDIR ${appname}
