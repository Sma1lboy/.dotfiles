#!/bin/bash

SOURCE_DIR="$(pwd)"
TARGET_DIR="$HOME"

FILES=(".tmux.conf" ".tmux.conf.local")

for FILE in "${FILES[@]}"; do
  if [ -e "$TARGET_DIR/$FILE" ]; then
    echo "Removing existing $TARGET_DIR/$FILE"
    rm -f "$TARGET_DIR/$FILE"
  fi

  echo "Copying $SOURCE_DIR/$FILE to $TARGET_DIR/$FILE"
  cp "$SOURCE_DIR/$FILE" "$TARGET_DIR/$FILE"
done

echo "All tmux configuration files copied."