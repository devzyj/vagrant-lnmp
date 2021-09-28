# 基础镜像
FROM devzyj/redis:6.2.5-alpine

# 拷贝入口文件
COPY docker-entrypoint.sh /usr/local/bin

# Shell 脚本
RUN mkdir -p /var/log/redis

# 服务端口
EXPOSE 6379

# 默认的启动命令
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]