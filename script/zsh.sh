#!/bin/bash

SOURCE_FILE="$(pwd)/.zshrc"
TARGET_FILE="$HOME/.zshrc"
BACKUP_DIR="$HOME/.config/backup"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Creating backup directory: $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
fi

if [ -e "$TARGET_FILE" ]; then
  echo "Moving existing $TARGET_FILE to $BACKUP_DIR"
  mv "$TARGET_FILE" "$BACKUP_DIR/.zshrc.back"
fi

echo "Copying $SOURCE_FILE to $TARGET_FILE"
cp "$SOURCE_FILE" "$TARGET_FILE"

echo ".zshrc file setup completed."