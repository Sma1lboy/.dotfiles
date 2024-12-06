#!/bin/bash

echo "Starting backup of all configuration files and directories..."

CONFIG_ITEMS=(
  "$HOME/.config/nvim"
  "$HOME/.config/sketchybar"
  "$HOME/.config/skhd"
  "$HOME/.config/yabai"
  "$HOME/.gitconfig"
  "$HOME/.gitignore_global"
  "$HOME/.tmux.conf"
  "$HOME/.tmux.conf.local"
  "$HOME/.vim"
  "$HOME/.vimrc"
  "$HOME/.zshrc"
)

BACKUP_DIR="$HOME/.config/backup"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Creating backup directory at $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
fi

backup_item() {
  local item=$1
  local item_name=$(basename "$item")
  local backup_path="$BACKUP_DIR/$item_name.back"

  if [ -e "$item" ]; then
    if [ -L "$item" ]; then
      echo "$item is a symbolic link, skipping..."
    else
      echo "Backing up $item to $backup_path"
      mv "$item" "$backup_path"
    fi
  else
    echo "$item does not exist, skipping..."
  fi
}

for item in "${CONFIG_ITEMS[@]}"; do
  backup_item "$item"
done

echo "Backup completed successfully."