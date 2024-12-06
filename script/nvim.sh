#!/bin/bash

PROG="nvim"
SOURCE_DIR="$(pwd)/.config/$PROG"
TARGET_DIR="$HOME/.config"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Creating target directory: $TARGET_DIR"
  mkdir -p "$TARGET_DIR"
fi

if [ -L "$TARGET_DIR/$PROG" ] || [ -e "$TARGET_DIR/$PROG" ]; then
  echo "Removing existing $TARGET_DIR/$PROG"
  rm -rf "$TARGET_DIR/$PROG"
fi

ln -s "$SOURCE_DIR" "$TARGET_DIR/$PROG"

echo "Symbolic link created: $TARGET_DIR/$PROG -> $SOURCE_DIR"