# 百度云客户端的docker镜像

docker hub的repo地址：https://hub.docker.com/r/johnshine/baidunetdisk-crossover-vnc/

群晖NAS的福音来了，直接在docker中启动百度云客户端，通过VNC客户端远程管理，不需要再运行臃肿的虚拟机系统了；可配合[群晖套件](https://github.com/john-shine/synology-baiduNetdisk-package)使用。

#### 请注意务必升级群晖至DSM6.2.x以上的版本，以下版本的DSM由于Linux内核为v3版本，无法运行最新版本的百度云linux客户端。目前在DSM6.2.3上测试一切正常运行。

如果遇到退出客户端后再次打开客户端，停留在加载界面的进度条中，一直无法进入主界面的情况，需要删除用户信息文件，命令如下：

`sudo docker ps`

得到容器的ID $container_id

`sudo docker exec -it $container_id /bin/bash`

`rm -f /home/baidu/baidunetdisk/baidunetdiskdata.db`


## 快速上手

pull镜像到本地

`sudo docker pull johnshine/baidunetdisk-crossover-vnc:latest`

启动镜像，就会在5901端口开启vnc远程连接端口。第一个5901是VNC连接的端口，你可以改成其它数字，如果冲突的话

`sudo docker run -d -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:latest`

或者，你也可以指定vnc远程连接的密码方式启动

`sudo docker run -d -p 5901:5901 -e vnc_password=your_password johnshine/baidunetdisk-crossover-vnc:latest`

还可以绑定默认下载目录到host的某个目录，会自动创建一个

`sudo docker run -d -p 5901:5901 -v /path/to/download/folder:/home/baidu/baidunetdiskdownload/ johnshine/baidunetdisk-crossover-vnc:latest`

<b>注意一定要绑定到/home/baidu/baidunetdiskdownload/这个目录，否则会因为权限导致出现无法下载的问题</b>

使用VNC客户端连接5901端口即可

## 更新

支持novnc访问，运行下面这一行命令启动并绑定容器6080端口到主机6080端口，直接访问http://${服务器ip地址}:6080即可

`sudo docker run -d -p 6080:6080 -v /path/to/download/folder:/home/baidu/baidunetdiskdownload/ johnshine/baidunetdisk-crossover-vnc:latest`

## VNC客户端推荐

1. [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/windows/)
2. [jump desktop](https://jumpdesktop.com/)
3. [TightVNC](https://github.com/TigerVNC/tigervnc/releases)

##    

![截图](https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/screenshot/1.png)

## 更新历史

## 4.1
+ 更新百度云客户端为v3.5.0

## 4.0
+ 自动build百度云客户端为最新版本，但是V4版本linux内核才能支持

## 3.1
+ 还原百度云客户端版本到v3.0.1.2
+ 桌面设置为灰色背景

## 3.0
+ 镜像迁移到新的环境ubuntu18.04，提高整体的兼容性

## 2.1
+ 添加中文拼音输入法
+ 在容器内中~/baidunetdiskdownload/目录下添加.reset文件夹，重置百度云客户端设置
+ 在容器内中~/baidunetdiskdownload/目录下添加.vnc/passwd.txt文件，设置vnc密码

## 2.0
+ 自动获取最新版客户端链接来build

## 1.9
+ 修复VNC密码设置无效的问题

## 1.8
+ 修复下载目录权限问题，务必绑定到container的/home/baidu/baidunetdiskdownload/目录

## 1.7
+ 增加noVnc

### 1.6
+ 避免网盘客户端崩溃后，画面变成全灰色

### 1.5
+ 升级百度网盘客户端为Linux版本2.0.2

### 1.4
+ 升级百度网盘客户端为Linux版本2.0.1

### 1.3
+ 重新编译，解决试用过期

### 1.2
+ 修复/mnt/drive_d目录权限问题

### 1.1
+ 修复第三方登录时，提示“QQ安全验证”，无法正常登录
+ 修复CrossOver软件本身乱码的问题
+ 修复下面目录权限不够，无法下面到D盘的问题。现在下载到任何盘的BaiduNetdiskDownload文件夹下，如果运行docker时绑定目录到/mnt/drive_d，就会下载到所绑定的文件夹内。^-^

### 1.0
+ 开天辟地。大问题已经没有了，可以长时间运行下载任务，跑完下载流程。

## 已知问题

+ 无法修改容器内的下载路径为其它路径
+ 如果novnc界面全屏灰色，没有出现百度网盘客户端的界面的话，说明网盘客户端启动不了，就需要查看以下内核的版本。输入`uname -r`, 必须是4.0以上的内核才支持最新版本的客户端。目前发现DS3615xs的DSM 6.2.3-25426 Update 3的内核版本为3.10.105，最新版本镜像不支持，只能使用3.x及以下版本的镜像: `docker pull johnshine/baidunetdisk-crossover-vnc:3.1; docker tag johnshine/baidunetdisk-crossover-vnc:3.1 johnshine/baidunetdisk-crossover-vnc:latest`
+ Use of uninitialized value $proto in socket at /usr/bin/vncserver line 3xx。perl库的问题，只是一个程序警告，问题不大。

## 已克服问题

+ 字体乱码
+ 用户名、密码无法输入
+ 第三方网页登录被阻止
+ 闪退

## 版权声明

本项目引用的百度云客户端归“北京百度网讯科技有限公司”所有，字体归制作方所有，其它遵从GPL协议
