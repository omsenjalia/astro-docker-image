FROM node:lts-alpine AS build
USER container 
RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container
ENV  USER=container HOME=/home/container
WORKDIR /home/container
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
USER container 
WORKDIR /home/container
EXPOSE $SERVER_PORT
