#!/bin/bash

# 修改软件安装源
sudo echo "modify sources.list"
sudo sed -i "s/cn.archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list

# 设置系统时区
sudo echo "Set Timezone"
sudo timedatectl set-timezone Asia/Shanghai

# 安装 Docker
sudo echo "Install Docker"
#sudo apt update && sudo apt -y install apt-transport-https ca-certificates curl gnupg lsb-release
sudo rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
sudo curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt -y install docker-ce docker-ce-cli containerd.io

# 安装 Docker Compose
sudo echo "Install Docker Compose"
sudo curl -L https://download.fastgit.org/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 启动 Docker
sudo systemctl enable docker
sudo systemctl start docker

# 建立 docker 用户组
sudo groupadd docker
sudo usermod -aG docker $USER

# 开启 Docker 用户隔离功能
sudo echo -e "{\n\
    \"userns-remap\": \"default\"\n\
}" > /etc/docker/daemon.json
sudo systemctl restart docker

# 创建 /data 工作目录
sudo echo "Create Work Data"
sudo mkdir /data

sudo mkdir /data/web
sudo chown -R 231154:231154 /data/web
sudo echo -e "<?php\n\
phpinfo();" > /data/web/index.php

sudo mkdir /data/docker
sudo cp -R /vagrant/lnmp/data/docker/docker-compose.yml /data/docker
sudo cp -R /vagrant/lnmp/data/docker/build /data/docker
sudo cp -R /vagrant/lnmp/data/docker/volumes /data/docker

sudo rm -rf /data/docker/volumes/nginx-server-conf/conf.d
sudo mkdir /data/docker/volumes/nginx-server-conf/conf.d
sudo echo -e "server {\n\
    listen 80;\n\
    root /data/web;\n\
    index index.php;\n\
    access_log /var/log/nginx/default.access.log;\n\
    error_log /var/log/nginx/default.error.log;\n\
    location ~* \.php$ {\n\
        fastcgi_index index.php;\n\
        fastcgi_pass php-fpm-server:9000;\n\
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;\n\
        include fastcgi_params;\n\
    }\n\
}" > /data/docker/volumes/nginx-server-conf/conf.d/default.conf

# 设置 Vagrant SSH 公钥
sudo echo "Set Vagrant SSH"
sudo rm -rf /home/vagrant/.ssh/authorized_keys
sudo mkdir -p /home/vagrant/.ssh
###sudo wget --no-check-certificate https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
sudo echo "ssh-rsa \
AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8\
+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8\
HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0j\
MZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehU\
c9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
sudo chmod 700 /home/vagrant/.ssh
sudo chmod 600 /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh

# 磁盘整理
sudo echo "dd if=/dev/zero of=/EMPTY bs=1M"
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY

# 清除安装缓存
sudo echo "apt-get clean"
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /tmp/*