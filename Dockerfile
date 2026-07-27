FROM node:alpine3.20

WORKDIR /tmp

COPY . .

EXPOSE 3000/tcp

# 1. 安装基础依赖 + Alpine 的 glibc 兼容库 (gcompat, libc6-compat)
RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat libc6-compat iproute2 coreutils bash &&\
    chmod +x index.js &&\
    npm install &&\
    curl -L -o /opt/komari-agent https://github.com/komari-monitor/komari-agent/releases/latest/download/komari-agent-linux-amd64 &&\
    chmod +x /opt/komari-agent

# 2. 启动脚本：后台运行 Agent，主进程运行 node
CMD ["sh", "-c", "/opt/komari-agent -e https://vps.19860825.xyz -t mZRXbFRfaA6iVQFm12RWrk --disable-web-ssh & node index.js"]
