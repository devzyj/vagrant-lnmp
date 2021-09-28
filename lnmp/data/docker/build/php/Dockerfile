# 基础镜像
FROM devzyj/php:7.3.29-fpm-alpine

# 拷贝入口文件
COPY docker-php-entrypoint /usr/local/bin

# Shell 脚本
RUN mkdir -p /var/log/php-fpm && mkdir -p /data/web

# 工作目录
WORKDIR /data/web

# 服务端口
EXPOSE 9000

# 默认的启动命令
CMD ["php-fpm"]