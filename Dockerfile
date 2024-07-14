FROM node:lts-alpine AS build
USER container 
RUN apk add --no-cache --update curl ca-certificates openssl git tar yarn bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container
ENV  USER=container HOME=/home/container
WORKDIR /home/container
ENV HOST=0.0.0.0
ENV PORT=SERVER_PORT
RUN yarn create astro
COPY . .

## webserver

FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
USER container 
WORKDIR /home/container
EXPOSE $SERVER_PORT
