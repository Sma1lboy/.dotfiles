#!/bin/bash

# Link .zshrc config file
SOURCE_DIR="$(pwd)"
TARGET_DIR="$HOME"

# Create symbolic link for .zshrc file
if [ -L "$TARGET_DIR/.zshrc" ] || [ -e "$TARGET_DIR/.zshrc" ]; then
  echo "Removing existing $TARGET_DIR/.zshrc"
  rm -f "$TARGET_DIR/.zshrc"
fi

echo "Creating symbolic link: $TARGET_DIR/.zshrc -> $SOURCE_DIR/.zshrc"
ln -s "$SOURCE_DIR/.zshrc" "$TARGET_DIR/.zshrc"

# ZSH plugins installation script
OH_MY_ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$OH_MY_ZSH_CUSTOM/plugins"

# Create plugins directory if it doesn't exist
if [ ! -d "$PLUGINS_DIR" ]; then
  echo "Creating plugins directory: $PLUGINS_DIR"
  mkdir -p "$PLUGINS_DIR"
fi

# Install zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed."
fi

# Install zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed."
fi

# Install fast-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/fast-syntax-highlighting" ]; then
  echo "Installing fast-syntax-highlighting..."
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$PLUGINS_DIR/fast-syntax-highlighting"
else
  echo "fast-syntax-highlighting already installed."
fi

echo "ZSH plugins installation completed."