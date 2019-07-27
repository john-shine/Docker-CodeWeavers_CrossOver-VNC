#!/bin/bash

version=$(cat $(pwd "$0")/VERSION)

sudo docker run -d -p 5901:5901 johnshine/lyx-crossover-vnc:${version}
