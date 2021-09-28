Vagrant.configure("2") do |config|

    # LNMP 开发环境
    config.vm.define "lnmp", autostart: true do |lnmp|
        # 启动时使用的 box 名字
        lnmp.vm.box = "devzyj/lnmp"

        # 设置主机名，将会更新 /etc/hosts 文件
        lnmp.vm.hostname = "lnmp"

        # 设置静态 IP
        lnmp.vm.network "private_network", ip: "10.111.222.100"

        # 设置端口转发
        web1.vm.network "forwarded_port", guest: 80, host: 8080

        # 设置 Data 工作目录的同步和权限
        lnmp.vm.synced_folder "./lnmp/data", "/data", 
                                create: true, owner:"root", group: "root"
        
        # 设置 Docker MySQL 配置文件权限
        lnmp.vm.synced_folder "./lnmp/data/docker/volumes/mysql-server-conf", "/data/docker/volumes/mysql-server-conf", 
                                create: true, owner:"root", group: "root", mount_options: ["dmode=755", "fmode=755"]
        
        # 设置 VirtualBox 属性
        lnmp.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--name", "lnmp", "--memory", "1024"]
        end
    end
  
end