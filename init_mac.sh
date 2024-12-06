#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/script"

echo "Executing preinstall script..."
"$SCRIPT_DIR/preinstall.sh"

echo "Checking and creating necessary directories..."
"$SCRIPT_DIR/check_dir.sh"

echo "Backing up existing configuration files and directories..."
"$SCRIPT_DIR/backup.sh"

echo "Executing yabai script..."
"$SCRIPT_DIR/yabai.sh"

echo "Executing skhd script..."
"$SCRIPT_DIR/skhd.sh"

echo "Executing sketchbar script..."
"$SCRIPT_DIR/sketchybar.sh"

echo "All scripts executed."