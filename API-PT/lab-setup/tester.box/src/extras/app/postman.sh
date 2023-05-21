#!/bin/bash

SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$SCRIPT_NAME"

install_tool() {
    # Setup Postman
    mkdir -p $TOOLS_DIR/setup && \
    wget https://dl.pstmn.io/download/latest/linux64 -O $TOOLS_DIR/setup/postman-linux-x64.tar.gz && \
    cd $TOOLS_DIR/setup && \
    tar -xvf postman-linux-x64.tar.gz && \
    mv Postman ../ && \
    rm -rf $TOOLS_DIR/setup/postman-linux-x64.tar.gz && \
    sudo ln -s $TOOLS_DIR/Postman/Postman /opt/app/postman && \
    sudo ln -s /opt/app/postman /usr/bin/postman

}

remove_tool() {
    sudo rm -rf $TOOLS_DIR/postman /opt/app/postman /usr/bin/postman
    echo "Removed Postman Installation"
}

if [[ $1 == "install" ]]; then
    # Get Burpsuite JAR File
    install_tool
    echo "Postman Installation complete"
elif [[ $1 == "update" ]]; then
    remove_tool
    install_tool
    echo "Postman Updation completed"
elif [[ $1 == "remove" ]]; then
    remove_tool
elif [[ $1 == "help" ]]; then
    echo "Usage: $SCRIPT_NAME [install/update/remove]"
    echo "  install - Install Postman from Source"
    echo "  update  - Update to latest Postman"
    echo "  remove  - Remove Postman"
    echo "  help    - Display this help message and exit"
else
   echo "Invalid argument. Use 'help' for usage information."
fi
