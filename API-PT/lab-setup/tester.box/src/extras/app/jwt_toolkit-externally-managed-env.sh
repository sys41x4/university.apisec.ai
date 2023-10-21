#!/bin/bash

SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$SCRIPT_NAME"

install_tool() {
    cd $TOOLS_DIR && \
    $(which git) clone https://github.com/ticarpi/jwt_tool.git && \
    cd jwt_tool && \
    pip3 install termcolor cprint pycryptodomex requests --user --break-system-package && \
    sudo chmod +x $TOOLS_DIR/jwt_tool/jwt_tool.py && \
    sudo ln -s -f $TOOLS_DIR/jwt_tool/jwt_tool.py /opt/app/jwt_tool.py && \
    sudo chmod +x /opt/app/jwt_tool.py && \
    sudo ln -s -f /opt/app/jwt_tool.py /usr/bin/jwt_tool
}

remove_tool() {
    sudo rm -rf $TOOLS_DIR/jwt_tool /opt/app/jwt_tool /usr/bin/jwt_tool
}

if [[ $1 == "install" ]]; then
    # install JWT Toolkit
    install_tool
    echo "JWT Toolkit Installation complete"

elif [[ $1 == "update" ]]; then
    remove_tool && \
    echo "JWT Toolkit Removed Successfully" && \
    install_tool && \
    echo "JWT Toolkit Updation completed"
elif [[ $1 == "remove" ]]; then
    remove_tool
    echo "JWT Toolkit Removed Successfully"
elif [[ $1 == "help" ]]; then
    echo "Usage: $SCRIPT_NAME [install/update/remove]"
    echo "  install - Install JWT Toolkit From Source"
    echo "  update  - Update to latest JWT Toolkit"
    echo "  remove  - Remove JWT Toolkit Installation"
    echo "  help    - Display this help message and exit"
else
    echo "Invalid argument. Use 'help' for usage information."
fi
