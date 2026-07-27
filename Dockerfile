FROM node:alpine3.20

WORKDIR /tmp

COPY . .

EXPOSE 3000/tcp

# 1. 安装基础依赖，并下载 Komari Agent 二进制文件
RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash &&\
    chmod +x index.js &&\
    npm install &&\
    curl -L -o /opt/komari-agent https://github.com/komari-monitor/komari-agent/releases/latest/download/komari-agent-linux-amd64 &&\
    chmod +x /opt/komari-agent

# 2. 修改启动命令：后台运行 Komari Agent，再启动 Node 主程序
CMD ["sh", "-c", "/opt/komari-agent -e https://vps.19860825.xyz -t mZRXbFRfaA6iVQFm12RWrk --disable-web-ssh & node index.js"]
