#!/usr/bin/env bash

sudo chmod a+w /run
sudo chmod a+w /run/user
mkdir /run/user/1000
sudo chown threv: /run/user/1000
sudo chmod 0700 /run/user/1000
ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/
sudo chmod 0755 /run
sudo chmod 0755 /run/user

