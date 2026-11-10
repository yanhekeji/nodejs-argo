FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

# 安装 alpine 官方 cloudflared，彻底解决二进制兼容问题
RUN apk update && apk upgrade && \
    apk add --no-cache cloudflared openssl curl bash && \
    chmod +x index.js && \
    npm install

CMD ["node", "index.js"]
