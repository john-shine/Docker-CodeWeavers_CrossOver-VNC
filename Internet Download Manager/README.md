# Internet Download Manager（IDM）的docker镜像

docker hub的repo地址：https://hub.docker.com/r/johnshine/idm-crossover-vnc/


## 快速上手

pull镜像到本地

`sudo docker pull johnshine/idm-crossover-vnc:latest`

启动镜像，就会在5901端口开启vnc远程连接端口。第一个5901是VNC连接的端口，你可以改成其它数字，如果冲突的话

`sudo docker run -d -p 5901:5901 johnshine/idm-crossover-vnc:latest`

或者，你也可以指定vnc远程连接的密码方式启动

`sudo docker run -d -p 5901:5901 -e vnc_password=your_password johnshine/idm-crossover-vnc:latest`

还可以绑定默认下载目录到host的某个目录，会自动创建一个

`sudo docker run -d -p 5901:5901 -v /path/to/download/folder:/mnt/drive_d johnshine/idm-crossover-vnc:latest`

使用VNC客户端连接5901端口即可

## VNC客户端推荐

1. [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/windows/)
2. [jump desktop](https://jumpdesktop.com/)
3. [TightVNC](https://github.com/TigerVNC/tigervnc/releases)

##    

![截图](https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/Internet%20Download%20Manager/screenshot/1.png)

## 更新历史

### 1.0
+ CrossOver官方说运行很完美，我也这么认为

## 版权声明

本项目引用的CrossOver归CodeWeavers Inc所有，IDM归Internet Download Manager, Tonec Inc所有，其它遵从GPL协议
