#!/bin/bash

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p &> /dev/null; then
  echo "Xcode Command Line Tools not installed. Installing..."
  xcode-select --install
  echo "Please wait for Xcode Command Line Tools installation to complete..."
  echo "After installation completes, run this script again."
  exit 0
else
  echo "Xcode Command Line Tools are already installed."
fi

check_and_install() {
  local program=$1
  local brew_name=$2

  if ! command -v $program &> /dev/null; then
    echo "$program is not installed. Installing..."
    if brew install $brew_name; then
      echo "$program installed successfully."
    else
      echo "Failed to install $program using Homebrew. Please install it manually."
    fi
  else
    echo "$program is already installed."
  fi
}

if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

brew update

# Install essential utilities
check_and_install git git
check_and_install tmux tmux
check_and_install neofetch neofetch
check_and_install node node
check_and_install nvim neovim
check_and_install gcc gcc

# Install coreutils for additional GNU utilities (includes shuf program)
check_and_install gshuf coreutils

# Install window management tools
# check_and_install yabai koekeishiya/formulae/yabai
# check_and_install skhd koekeishiya/formulae/skhd
# check_and_install sketchybar sketchybar

# Install Aerospace window manager
if ! command -v aerospace &> /dev/null; then
  echo "Aerospace is not installed. Installing..."
  brew install --cask nikitabobko/tap/aerospace
  echo "Aerospace installed successfully."
else
  echo "Aerospace is already installed."
fi

# Install additional tools
check_and_install lazygit lazygit
check_and_install fastfetch fastfetch

# Install JankyBorders for window borders if needed
if ! command -v borders &> /dev/null; then
  echo "JankyBorders is not installed. Installing..."
  brew install FelixKratz/formulae/borders
else
  echo "JankyBorders is already installed."
fi