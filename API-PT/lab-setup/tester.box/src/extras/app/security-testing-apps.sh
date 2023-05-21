#!/bin/bash

SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$SCRIPT_NAME"


PACKAGES = nmap \
        amass \
        gobuster \
        dirb


create_links(){
    sudo mkdir -p /opt/scripts
    sudo ln -s $SCRIPT_PATH /opt/script/security-testing-apps && \
    sudo chmod +x /opt/scripts/security-testing-apps && \
    sudo ln -s /opt/scripts/security-testing-apps /usr/bin/security-testing-apps
}

install_tool() {
    # Install Security-testing tools
    apt-get update && \
    apt-get install -y $1
    apt-get clean -y
    create_links
}

remove_tool() {
    apt-get purge -y $1
    apt-get clean -y
    echo "Removed Security Testing Apps Installation"
}

upgrade_tool() {
    apt-get update && \
    apt-get upgrade -y $1
    apt-get clean -y
    create_links
}

if [[ $1 == "install" ]]; then
    # Install Security Testing Apps
    install_tool $PACKAGES
    echo "Security Testing Apps Installation complete"
elif [[ $1 == "update" ]]; then
    upgrade_tool $PACKAGES
    echo "Security Testing Apps Updation completed"
elif [[ $1 == "remove" ]]; then
    remove_tool $PACKAGES
elif [[ $1 == "help" ]]; then
    echo "Usage: $SCRIPT_NAME [install/update/remove]"
    echo "  install - Install Security Testing Tools"
    echo "  update  - Update to latest Security Testing Tools"
    echo "  remove  - Remove Security Testing Tools"
    echo "  help    - Display this help message and exit"
else
    echo "Invalid argument. Use 'help' for usage information."
fi
