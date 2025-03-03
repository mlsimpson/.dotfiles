#!/usr/bin/env bash

if [ ! -d /run/user/1000 ]; then
    sudo chmod a+w /run
    sudo chmod a+w /run/user
    mkdir /run/user/1000
    ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/
fi
