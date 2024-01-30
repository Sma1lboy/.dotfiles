#!/bin/bash

#if need call it separately
#do it in your root dir
CURR_DIR=$(dirname $0)

echo $CURR_DIR
ln -s -f ~/.dotfiles/.tmux.conf ~/
cp ~/.dotfiles/.tmux.conf.local ~/
tmux source-file ~/.tmux.conf

