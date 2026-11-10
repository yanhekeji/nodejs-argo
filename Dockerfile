FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl ca-certificates bash gcompat libc6-compat && \
    curl -L --retry 3 https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x index.js && \
    npm install

CMD ["node", "index.js"]
