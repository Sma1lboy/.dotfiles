#!/bin/bash


CONFIG_DIR=$HOME/.config
NVIM_DIR=$HOME/.config/nvim
BACKUP_DIR=$CONFIG_DIR/nvim_backups
if ! [ -d $CONFIG_DIR ]; then
  mkdir $CONFIG_DIR
fi
if ! [ -d $BACKUP_DIR ]; then
  mkdir $BACKUP_DIR
fi


if [ -d $NVIM_DIR ]; then
  tar czf "$BACKUP_DIR/nvim-backup-$(date '+%Y-%m-%d-%H-%M-%S').tar.gz" $NVIM_DIR
  exit 1;
  rm -r $NVIM_DIR
fi

cp -r ~/.dotfiles/.config/nvim ~/.config/
