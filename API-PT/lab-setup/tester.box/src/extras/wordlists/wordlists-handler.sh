#!/bin/bash

SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$SCRIPT_NAME"


PACKAGES=("wordlists" "seclists")

create_links(){
    sudo mkdir -p /opt/wordlists && \
    sudo ln -s -f $SCRIPT_PATH /opt/wordlists/wordlist-handler && \
    sudo chmod +x /opt/wordlists/wordlist-handler && \
    sudo ln -s -f /opt/wordlists/wordlist-handler /usr/bin/wordlist-handler
}

install_tool() {
    # Install Wordlists
    sudo apt-get update && \
#    sudo apt-get install -y $1
    for package in "${PACKAGES[@]}"; do
      sudo apt install -y "$package"
    done
    sudo apt-get clean -y
    create_links
}

remove_tool() {
    # sudo apt-get purge -y $1
    for package in "${PACKAGES[@]}"; do
      sudo apt purge -y "$package"
    done
    sudo apt-get clean -y
    echo "Removed Wordlists Installation"
}

upgrade_tool() {
    sudo apt-get update && \
    # sudo apt-get upgrade -y $1
    install_tool $PACKAGES
    sudo apt-get clean -y
    create_links
}

if [[ $1 == "install" ]]; then
    # Install Wordlists
    install_tool $PACKAGES
    echo "Wordlists Installation complete"
elif [[ $1 == "update" ]]; then
    upgrade_tool $PACKAGES
    echo "Wordlists Updation completed"
elif [[ $1 == "remove" ]]; then
    remove_tool $PACKAGES
elif [[ $1 == "help" ]]; then
    echo "Usage: $SCRIPT_NAME [install/update/remove]"
    echo "  install - Install Wordlists"
    echo "  update  - Update to latest Wordlists"
    echo "  remove  - Remove Wordlists"
    echo "  help    - Display this help message and exit"
else
    echo "Invalid argument. Use 'help' for usage information."
fi
