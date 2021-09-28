# 基础镜像
FROM devzyj/redis:6.2.5-alpine

# 拷贝配置文件
COPY redis.conf /usr/local/etc/redis/redis.conf

# 服务端口
EXPOSE 6379

# 默认的启动命令
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]