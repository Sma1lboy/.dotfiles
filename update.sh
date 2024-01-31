#!/bin/bash

#this usefor collection all .dotfiles I have to current folder
#update this folder

DIR=$(realpath $(dirname $0))
cp -r ~/.config/nvim $DIR/.config/
cp -r ~/.vim $DIR
cp ~/.vimrc $DIR
cp ~/.tmux.conf $DIR 
cp ~/.tmux.conf.local $DIR
cp ~/.gitconfig $DIR
cp ~/.gitignore_global $DIR
cp ~/.zshrc $DIR
