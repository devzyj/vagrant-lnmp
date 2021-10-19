#!/bin/bash

# 设置系统时区
sudo echo "Set Timezone"
sudo timedatectl set-timezone Asia/Shanghai

# 修改软件安装源
sudo echo "modify sources.list"
sudo sed -i "s/cn.archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list

# 安装 Docker
sudo echo "Install Docker"
sudo rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
sudo curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get -y install docker-ce docker-ce-cli containerd.io

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
