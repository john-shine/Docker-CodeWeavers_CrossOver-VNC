# 迅雷下载客户端的docker镜像

目前使用的是迅雷极速板(ThunderSpeed) v1.0.35.366，这个版本运行相对要容易一些

## 快速上手

pull镜像到本地

`sudo docker pull johnshine/thunder-crossover-vnc:latest`

启动镜像，就会在5901端口开启vnc远程连接端口。第一个5901是VNC连接的端口，你可以改成其它数字，例如冲突情况下。另外，为了拷贝方便，建议绑定默认下载目录到host的某个目录, 例如下面的/path/to/download/folder。

`sudo docker run -d -p 5901:5901 -v /path/to/download/folder:/mnt/drive_d johnshine/thunder-crossover-vnc:latest`

或者，你也可以指定vnc远程连接的密码: 

`sudo docker run -d -p 5901:5901 -v /path/to/download/folder:/mnt/drive_d -e vnc_password=your_password johnshine/thunder-crossover-vnc:latest`


使用VNC客户端连接5901端口即可

## VNC客户端推荐

1. [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/windows/)
2. [jump desktop](https://jumpdesktop.com/)
3. [TightVNC](https://github.com/TigerVNC/tigervnc/releases)

## 更新历史

### 1.0
+ 测试可以正常下载
+ 已知问题：界面外框有黑边，暂时没有找到解决办法


## 版权声明

本项目引用的迅雷客户端归“XUNLEI.COM”所有，CrossOver归CodeWeavers Inc所有，字体归制作方所有，其它遵从GPL协议
