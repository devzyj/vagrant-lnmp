# 基础镜像
FROM mysql:5.7.35

# 拷贝配置文件
COPY mysql.cnf /etc/mysql/conf.d/mysql.cnf
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# SHELL 指令
RUN chmod 0644 /etc/mysql/conf.d/mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# 服务端口
EXPOSE 3306 33060

# 默认的启动命令
CMD ["mysqld"]