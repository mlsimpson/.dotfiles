#!/usr/bin/zsh

for i in `ls -a | grep -e "^\.[a-zA-Z1-9]"`
  cp -r ../$i .
