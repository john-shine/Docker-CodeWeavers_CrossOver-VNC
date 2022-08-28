#!/bin/sh

version=$(cat $(pwd "$0")/VERSION)

while getopts 'v:' flag; do
  case "${flag}" in
	  v) version=${OPTARG} ;;
  esac
done

if [ -z ${version} ] ; then
   echo 'not specify version number'
   exit
fi

echo 'starting to build image'
sudo docker build --rm -t johnshine/quark-crossover-vnc:${version} .
