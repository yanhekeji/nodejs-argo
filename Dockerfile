FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

# 1. 安装基础工具与 glibc 兼容层
# 2. 直接下载 Cloudflare 官方静态编译的 amd64 二进制到系统路径
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl ca-certificates bash gcompat && \
    curl -L --retry 3 https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x index.js && \
    npm install

CMD ["node", "index.js"]
