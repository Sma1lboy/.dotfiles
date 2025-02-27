#!/bin/bash

SOURCE_DIR="$(pwd)"
TARGET_DIR="$HOME"

FILES=(".tmux.conf" ".tmux.conf.local")

for FILE in "${FILES[@]}"; do
  if [ -L "$TARGET_DIR/$FILE" ] || [ -e "$TARGET_DIR/$FILE" ]; then
    echo "Removing existing $TARGET_DIR/$FILE"
    rm -f "$TARGET_DIR/$FILE"
  fi

  echo "Creating symbolic link: $TARGET_DIR/$FILE -> $SOURCE_DIR/$FILE"
  ln -s "$SOURCE_DIR/$FILE" "$TARGET_DIR/$FILE"
done

echo "All tmux configuration files linked."