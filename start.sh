#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/script"

# Allow override of OS detection via environment variable
if [ -z "$DOTFILES_OS" ]; then
    OS="$(uname -s)"
else
    OS="$DOTFILES_OS"
fi

echo "Running setup for OS: $OS"

echo "Executing preinstall script..."
"$SCRIPT_DIR/preinstall.sh"

echo "Checking and creating necessary directories..."
"$SCRIPT_DIR/check_dir.sh"

echo "Backing up existing configuration files and directories..."
"$SCRIPT_DIR/backup.sh"

echo "Executing nvim script..."
"$SCRIPT_DIR/nvim.sh"

echo "Executing tmux script..."
"$SCRIPT_DIR/tmux.sh"

# macOS specific configurations
if [ "$OS" = "Darwin" ]; then
    echo "Executing macOS specific configurations..."
    
    echo "Executing yabai script..."
    "$SCRIPT_DIR/yabai.sh"

    echo "Executing skhd script..."
    "$SCRIPT_DIR/skhd.sh"

    echo "Executing sketchbar script..."
    "$SCRIPT_DIR/sketchybar.sh"
fi

echo "All scripts executed."