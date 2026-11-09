FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash &&\
    chmod +x index.js &&\
    npm install &&\
    mkdir -p /app/.npm && chmod -R 777 /app/.npm

CMD ["node", "index.js"]
