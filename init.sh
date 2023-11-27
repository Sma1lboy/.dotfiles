#!/bin/bash

# init
DOWNLOAD_DIR="$HOME/download/temp_init"
CURRENT_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"
CONFIG_BACKUP_DIR="$HOME/.config.old"
NEOVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"

# make download folder
mkdir "$DOWNLOAD_DIR"

echo "Updating Apt..."
sudo apt update
echo "apt Update Successful!"

# check if neovim exist

# download neovim
# cd $DOWNLOAD_DIR && 



echo "Downloading Neovim..."
curl -o $DOWNLOAD_DIR -LO $NEOVIM_URL
chmod u+x nvim.appimage

echo "Installing Neovim..."
./nvim.appimage --appimage-extract

echo "Moving Neovim config into $HOME/.config file"
cp -r $CONFIG_DIR $CONFIG_BACKUP_DIR
rm -r $CONFIG_DIR/nvim
cp $CURRENT_DIR/nvim $CONFIG_DIR/nvim

echo "Installing tmux..."
apt install tmux
echo "Moving tmux config into $HOME"
cp $CURRENT_DIR/tmux.conf $HOME/.tmux.conf

echo "Installing zsh..."
apt install zsh

echo "Intalling oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



VIM_DIR=$(where nvim)

echo "setup vim alias to nvim in zsh"
echo "alias vim='$VIM_DIR'" >> $HOME/.zshrc && source $HOME/.zshrc
