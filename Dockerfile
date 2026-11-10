FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

# 1. 安装基础依赖与 curl、ca-certificates
# 2. 从 Cloudflare 官方拉取最新 linux-amd64 静态二进制并赋予执行权限
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl ca-certificates bash && \
    curl -L --retry 3 https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x index.js && \
    npm install

CMD ["node", "index.js"]
