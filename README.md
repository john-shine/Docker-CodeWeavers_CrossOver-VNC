# CodeWeavers.CrossOver.VNC Docker image
**A docker image** for run **CrossOver Linux** though **VNC remote manager.** 

With the docker image, U can run windows softwares under docker container, instead of much heavier virtual machines. Current installed version: **CrossOver Linux 18.1.0**

<!-- ## 最近外网一直不是很好，镜像一直push不到docker hub上面，导致docker hub上面不是最新的，所以大家就自己先build吧
-->
Pull latest image from Docker hub:

`sudo docker pull johnshine/crossover-vnc:latest`

Then run the image as pull finished:

`sudo docker run -d -p ${VNC_PORT}:5901 -e vnc_password=${YOUR_VNC_PASSWORD} johnshine/crossover-vnc:latest`

If YOUR_VNC_PASSWORD or vnc_password argument **leave empty, no password** need to connect to VNC server, which most used in one\`s own local home network.
<!-- 使用优惠码：CYBERSTEAL9 购买CrossOver Linux一次性版只需9美元

With promotion Code: CYBERSTEAL9, purchase CrossOver Linux single version only for $9

使用授权证书激活, 证书可以在codeweavers.com官网，我的帐号->我的帐号->我的订单内下载

Activate by license file, that can be downloaded at codeweavers.com -> My Account -> My Orders
-->

After buy CrossOver Linux license, you could add license file to container as following, that can be downloaded at codeweavers.com -> My Account -> My Orders:

`sudo docker run -d -p ${VNC_PORT}:5901 -v /path/to/license/license.sig:/opt/cxoffice/etc/license.sig -v /path/to/license/license.txt:/opt/cxoffice/etc/license.txt -e vnc_password=${YOUR_VNC_PASSWORD} johnshine/crossover-vnc:latest`

<!-- 如果你对这个项目感兴趣，希望表达一份感谢之情，请打开支付宝<a href="https://mobile.alipay.com/index.htm" target="_blank"><img src="https://raw.githubusercontent.com/john-shine/DIY-iMac-CN/master/images/alipay.png" width="18"></a>扫描下面的二维码，你和我都将获得一份支付宝红包 -->

<!-- ![红包二维码](https://raw.githubusercontent.com/john-shine/DIY-iMac-CN/master/images/barcode.png) -->

Another solution, [Wine VNC](https://github.com/john-shine/Docker-WineHQ-VNC): **Free**, but maybe less stable.

## Change history
1.4 (2019-04-29)
* update CrossOver Linux to v18.5.0

1.3 (2018-12-17)
* fix vnc server fail to start
* update CrossOver Linux to 18.1.0

1.2
* retry delete the install binary
* fix bug: vnc password not work!
* fix issue: license files is permission denied

1.1
* change install directory
* decrease image size
* fix issue: vncserver start at another port.


1.0
* initialized

## VNC clients recommend

1. [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/windows/)
2. [jump desktop](https://jumpdesktop.com/)
3. [TightVNC](https://github.com/TigerVNC/tigervnc/releases)

## Built-in applications

+ [BaiduNetdisk downloader](https://github.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/tree/master/BaiduNetdisk)
+ [Internet Download Manager](https://github.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/tree/master/Internet%20Download%20Manager)
+ [LuYouXia](https://github.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/tree/master/Lyx)
