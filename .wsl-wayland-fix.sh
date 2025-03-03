#!/usr/bin/env bash

sudo chmod a+w /run
sudo chmod a+w /run/user
mkdir /run/user/1000
ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/
pass -c live.com/threv

