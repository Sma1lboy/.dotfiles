#!/bin/bash

#this usefor collection all .dotfiles I have to current folder
#update this folder

DIR=$(realpath $(dirname $0))
CONFIG=$DIR/.config
if ! [ -d $CONFIG ]; then
  mkdir $CONFIG
fi
cp -r ~/.config/nvim $DIR/.config/
cp -r ~/.vim $DIR
