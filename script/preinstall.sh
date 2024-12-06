#!/bin/bash
OS="$(uname -s)"

case "$OS" in
  Darwin)
    echo "Detected macOS"
    ./script/preinstall.mac.sh
    ;;
  Linux)
    echo "Detected Linux"
    ./script/preinstall.linux.sh
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac
