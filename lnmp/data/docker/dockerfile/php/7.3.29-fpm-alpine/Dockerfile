# 基础镜像
FROM php:7.3.29-fpm-alpine

# 拷贝 php.ini 文件
RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    # 使用国内镜像 \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    \
    # 提取 PHP 源码 \
    && docker-php-source extract \
    \
    # 安装 PHP Core 扩展依赖 \
    && apk add --no-cache bzip2-dev libpng-dev libjpeg-turbo-dev icu-dev libzip-dev \
    \
    # 安装 PHP Core 扩展 \
    && docker-php-ext-install -j$(nproc) bcmath bz2 gd intl opcache mysqli pdo_mysql sockets zip \
    \
    # 安装 PECL 扩展依赖 \
    && apk add --no-cache $PHPIZE_DEPS libzip-dev libmemcached-dev \
    \
    # 安装 PECL 扩展 \
    && pecl install redis mongodb memcache-4.0.5.2 memcached \
    && docker-php-ext-enable redis mongodb memcache memcached \
    && apk del $PHPIZE_DEPS \
    \
    # 删除提取的 PHP 源码 \
    && docker-php-source delete\
    \
    # 安装 phpcomposer \
    && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    \
    # 清除安装缓存 \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /var/lib/apt/lists/*
    
# 服务端口
EXPOSE 9000

# 默认的启动命令
CMD ["php-fpm"]