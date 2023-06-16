#!/bin/bash

docker exec --user "docker_noetic" -it ${USER}_ros_noetic /bin/zsh \
    -c "cd /home/docker_noetic; echo ROS-Noetic container; echo ; /bin/zsh"
