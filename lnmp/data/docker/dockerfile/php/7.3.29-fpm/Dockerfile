# 基础镜像
FROM php:7.3.29-fpm

# 拷贝 php.ini 文件
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    # 使用国内镜像 \
    && sed -i "s@http://deb.debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list && apt-get -y update \
    \
    # 安装 PHP Core 扩展依赖 \
    && apt-get install -y libbz2-dev libpng-dev libjpeg62-turbo-dev libicu-dev libzip-dev \
    \
    # 安装 PHP Core 扩展 \
    && docker-php-ext-install -j$(nproc) bcmath bz2 gd intl opcache mysqli pdo_mysql sockets zip \
    \
    # 安装 PECL 扩展依赖 \
    && apt-get install -y libmemcached-dev \
    \
    # 安装 PECL 扩展 \
    && pecl install redis mongodb memcache-4.0.5.2 memcached \
    && docker-php-ext-enable redis mongodb memcache memcached \
    \
    # 安装 phpcomposer \
    && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    \
    # 清除安装缓存 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
    
# 服务端口
EXPOSE 9000

# 默认的启动命令
CMD ["php-fpm"]