#!/bin/bash

# call it in root dir


CONFIG_DIR="~/.config"

if [ -d $CONFIG_DIR ]; then
  mkdir CONFIG_DIR
fi


echo "starting moving config.."
#moving config
ln -s -f ~/.dotfiles/.gitconfig
ln -s -f ~/.dotfiles/.gitignore_global
ln -s -f ~/.dotfiles/.vimrc
ln -s -f ~/.dotfiles/.zshrc

cp ~/.dotfiles/Brewfile ~/.
cp -r ~/.dotfiles/.config/nvim ~/.config/
cp -r ~/.dotfiles/.vim ~/.

echo "done!"

