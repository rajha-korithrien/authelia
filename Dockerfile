FROM rajhakorithrien/node:10.16.0-alpine-tls-fix

WORKDIR /usr/src

COPY package.json /usr/src/package.json

RUN apk --update add --no-cache --virtual \
      .build-deps make g++ python && \
    npm install --production && \
    apk del .build-deps

COPY dist/server /usr/src/server

EXPOSE 9091

VOLUME /etc/authelia
VOLUME /var/lib/authelia

CMD ["node", "server/src/index.js", "/etc/authelia/config.yml"]
