#!/bin/bash

orange=`tput setaf 3`
reset_color=`tput sgr0`

ARCH=`uname -m`

cd "$(dirname "$0")"
BASE_DIR=`pwd`

echo "Running on ${orange}${ARCH}${reset_color}"

if [ "$ARCH" == "x86_64" ]; then
    ARGS="--ipc host --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all"
else
    echo "Arch ${ARCH} not supported"
    exit 1
fi

xhost +
    docker run -it -d --rm \
        $ARGS \
        --env="DISPLAY=$DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --privileged \
        --name ${USER}_ros_noetic \
        --net host \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v ${BASE_DIR}/../noetic/catkin_ws/:/home/docker_noetic/catkin_ws/:rw \
        ${ARCH}-ros-noetic:latest
xhost -

docker exec --user root \
    ${USER}_ros_noetic bash -c "/etc/init.d/ssh start"
