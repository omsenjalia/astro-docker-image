FROM node:lts-alpine AS build
FROM alpine

USER container 
RUN apk add --no-cache --update curl ca-certificates openssl git tar yarn bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container
ENV  USER=container HOME=/home/container
WORKDIR /home/container
ENV HOST=0.0.0.0
ENV PORT=SERVER_PORT
RUN yarn create astro
COPY . .
EXPOSE $SERVER_PORT
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
