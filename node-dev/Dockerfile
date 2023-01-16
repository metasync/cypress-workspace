ARG NODE_IMAGE_TAG=18.13.0-alpine.3.17
FROM node:${NODE_IMAGE_TAG}

ENV APPS_HOME=/home/apps
ENV NPM_CACHE=${APPS_HOME}/.npm-cache
ENV HISTFILE=${APPS_HOME}/.bash_history

RUN apk -U upgrade \
    && apk add --no-cache git git-flow curl jq bash \
    \
    && mkdir ${APPS_HOME} \
    && chown -R 1001:0 ${APPS_HOME} \
    && chmod -R g=u ${APPS_HOME} \
    \
    && mkdir ${NPM_CACHE} \
    && chown -R 1001:0 ${NPM_CACHE} \
    && chmod -R g=u ${NPM_CACHE} \
    && npm config set cache ${NPM_CACHE} --global

USER 1001

WORKDIR ${APPS_HOME}

EXPOSE 5173
