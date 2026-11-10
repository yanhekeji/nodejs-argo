FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

# 安装必要的依赖并补齐 glibc 兼容库软链接
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat libc6-compat iproute2 coreutils bash ca-certificates && \
    chmod +x index.js && \
    npm install

CMD ["node", "index.js"]
