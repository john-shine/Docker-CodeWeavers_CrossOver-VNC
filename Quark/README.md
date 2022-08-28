# 夸克网盘客户端docker镜像

docker hub的repo地址：https://hub.docker.com/r/johnshine/quark-crossover-vnc/


## 快速上手

pull镜像到本地

`sudo docker pull johnshine/quark-crossover-vnc:latest`

启动镜像，就会在5901端口开启vnc远程连接端口。第一个5901是VNC连接的端口，你可以改成其它数字，如果冲突的话

`sudo docker run -d -p 5901:5901 johnshine/quark-crossover-vnc:latest`

或者，你也可以指定vnc远程连接的密码方式启动

`sudo docker run -d -p 5901:5901 -e vnc_password=your_password johnshine/quark-crossover-vnc:latest`

还可以绑定默认下载目录到host的某个目录，会自动创建一个

`sudo docker run -d -p 5901:5901 -v /path/to/download/folder:/home/baidu/quarkdownload/ johnshine/quark-crossover-vnc:latest`

<b>注意一定要绑定到/home/baidu/quarkdownload/这个目录，否则会因为权限导致出现无法下载的问题</b>

使用VNC客户端连接5901端口即可

支持novnc访问，运行下面这一行命令启动并绑定容器6080端口到主机6080端口，直接访问http://${服务器ip地址}:6080即可

`sudo docker run -d -p 6080:6080 -v /path/to/download/folder:/home/baidu/quarkdownload/ johnshine/quark-crossover-vnc:latest`

## VNC客户端推荐

1. [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/windows/)
2. [jump desktop](https://jumpdesktop.com/)
3. [TightVNC](https://github.com/TigerVNC/tigervnc/releases)

