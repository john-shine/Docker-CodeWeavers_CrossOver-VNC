#!/bin/bash

version=$(cat $(pwd "$0")/VERSION)
sudo docker run -d --add-host update.pan.baidu.com:127.0.0.1 -p 6080:6080 -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:${version}

# The following is for test
# running=$(sudo docker ps -q --filter status=running)
# if [[ ! -z $running ]]; then
#     sudo docker stop ${running}
# fi

#mkdir -p ./BaiduNetdiskDownload/ && sudo docker run -d -v `pwd`/BaiduNetdiskDownload:/home/baidu/baidunetdiskdownload/ -p 5901:5901 johnshine/baidunetdisk-crossover-vnc:${version}
