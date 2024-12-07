#!/bin/bash

# Color definitions
RED='\033[0;31m'
NC='\033[0m' # No Color

print_error() {
    echo -e "${RED}$1${NC}"
}

# Check if running as root
is_root() {
    [ "$EUID" -eq 0 ]
}

# Conditionally prepend sudo
maybe_sudo() {
    if is_root; then
        echo ""
    else
        echo "sudo "
    fi
}

if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    $(maybe_sudo)apt-get update && $(maybe_sudo)apt-get install -y curl
    if [ $? -ne 0 ]; then
        print_error "Failed to install curl automatically."
        print_error "Please install curl manually using:"
        print_error "    sudo apt-get update && sudo apt-get install -y curl"
        print_error "Then run this script again."
        exit 1
    fi
fi

install_program() {
    local program=$1
    local install_command=$2

    if ! command -v $program &> /dev/null; then
        echo "Installing $program..."
        eval $install_command
        if [ $? -eq 0 ]; then
            echo "$program installed successfully."
        else
            print_error "Failed to install $program. Please install manually."
        fi
    else
        echo "$program already installed."
    fi
}

DOWNLOADER="curl -fsSL"

# System dependencies
$(maybe_sudo)apt-get update && $(maybe_sudo)apt-get install -y build-essential
$(maybe_sudo)apt-get install -y libssl-dev pkg-config

# Install ncurses first
install_program ncurses "$DOWNLOADER https://invisible-mirror.net/archives/ncurses/ncurses-6.4.tar.gz | tar xzv && cd ncurses-6.4 && ./configure --prefix=/usr && make && $(maybe_sudo)make install && $(maybe_sudo)ldconfig && cd .. && rm -rf ncurses-6.4"

# Update PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig

# Install libevent
install_program libevent "$DOWNLOADER https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz | tar xzv && cd libevent-2.1.12-stable && ./configure && make && $(maybe_sudo)make install && $(maybe_sudo)ldconfig && cd .. && rm -rf libevent-2.1.12-stable"

install_program git "$(maybe_sudo)apt-get install -y git"
install_program neofetch "$DOWNLOADER https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | $(maybe_sudo)tee /usr/local/bin/neofetch > /dev/null && $(maybe_sudo)chmod +x /usr/local/bin/neofetch"
install_program node "$DOWNLOADER https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && source ~/.nvm/nvm.sh && nvm install node"

install_program snapd "$(maybe_sudo)apt-get update && $(maybe_sudo)apt-get install -y snapd"
$(maybe_sudo)systemctl start snapd.socket snapd
install_program nvim "$(maybe_sudo)snap install --classic nvim"