#!/bin/bash


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

check_and_install git git
check_and_install tmux tmux
check_and_install neofetch neofetch
check_and_install node node
check_and_install nvim neovim
check_and_install gcc gcc
check_and_install yabai koekeishiya/formulae/yabai
check_and_install skhd koekeishiya/formulae/skhd
check_and_install sketchybar sketchybar
# install coreutils later for shuff program