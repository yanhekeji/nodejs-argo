# 弃用 alpine，换用基于 Debian 的 slim 镜像，原生完美支持官方二进制文件
FROM node:20-slim

WORKDIR /tmp

COPY . .

EXPOSE 3000/tcp

# Debian 的包管理器是 apt-get，替换对应的安装命令
RUN apt-get update && \
    apt-get install -y openssl curl iproute2 coreutils bash && \
    chmod +x index.js && \
    npm install && \
    curl -L -o /opt/komari-agent https://github.com/komari-monitor/komari-agent/releases/latest/download/komari-agent-linux-amd64 && \
    chmod +x /opt/komari-agent

# 启动命令保持不变
CMD ["sh", "-c", "/opt/komari-agent -e https://vps.19860825.xyz -t mZRXbFRfaA6iVQFm12RWrk --disable-web-ssh & node index.js"]
