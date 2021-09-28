# 基础镜像
FROM nginx:1.21.1-alpine

# 创建 www-data 用户
RUN adduser www-data -D -H -S -u 82 -G www-data -g www-data -s /sbin/nologin

# 服务端口
EXPOSE 80

# 默认的启动命令
CMD ["nginx", "-g", "daemon off;"]