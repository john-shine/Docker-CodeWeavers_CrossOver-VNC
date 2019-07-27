#!/bin/bash

version=$(cat $(pwd "$0")/VERSION)
# sudo docker run -d -p 5901:5901 johnshine/idm-crossover-vnc:${version}

# The following is for test
running=$(sudo docker ps -q --filter status=running)
if [[ ! -z $running ]]; then
    sudo docker stop ${running}
fi

sudo docker run -d -p 5901:5901 johnshine/idm-crossover-vnc:${version}
