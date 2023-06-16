#!/bin/bash

orange=`tput setaf 3`
reset_color=`tput sgr0`

ARCH=`uname -m`

if [ $ARCH != "x86_64" ]
then
    echo "Architecture ${orange}${ARCH}${reset_color} is not supported"
    exit 1
fi

if command -v nvidia-smi &> /dev/null; then
    echo "Detected ${orange}CUDA${reset_color} hardware"
else
    echo "${orange}CPU-only${reset_color} build is not supported yet"
    exit 1
fi

echo "Building for ${orange}${ARCH}${reset_color}"

cd "$(dirname "$0")"

docker build . \
    -f Dockerfile.noetic \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    -t ${ARCH}-ros-noetic:latest
