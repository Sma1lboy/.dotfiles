#!/bin/bash


CONFIG_DIR="~/.config/"
if ! [ -d $CONFIG_DIR ]; then
  mkdir $CONFIG_DIR
fi

cp -r ~/.dotfiles/.config/nvim ~/.config/
