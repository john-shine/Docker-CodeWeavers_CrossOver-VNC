#!/bin/bash

version=$(cat $(pwd "$0")/VERSION)
sudo docker run -d -p 6080:6080 -p 5901:5901 johnshine/quark-crossover-vnc:${version}
