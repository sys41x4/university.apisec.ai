#!/bin/bash

SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$SCRIPT_NAME"

BURPSUITE_PATH="$TOOLS_DIR/burpsuite/burpsuite.community.latest.jar"
install_tool() {
    # Get Burpsuite JAR File
    mkdir -p $TOOLS_DIR/burpsuite
    wget https://portswigger.net/burp/releases/download -O $BURPSUITE_PATH && \
    sudo ln -s $SCRIPT_PATH /opt/app/burpsuite-community && \
    sudo chmod +x /opt/app/burpsuite-community && \
    sudo ln -s /opt/app/burpsuite-community /usr/bin/burpsuite-community
}

remove_tool() {
    sudo rm -rf $BURPSUITE_PATH /opt/app/burpsuite-community /usr/bin/burpsuite-community
    echo "Removed Burpsuite Community Installation"
}

if [[ $1 == "install" ]]; then
    # Get Burpsuite JAR File
    install_tool
    echo "Burpsuite Community Installation complete"
elif [[ $1 == "update" ]]; then
    remove_tool
    install_tool
    echo "Burpsuite Community Updation completed"
elif [[ $1 == "remove" ]]; then
    remove_tool
elif [[ $1 == "help" ]]; then
    echo "Usage: $SCRIPT_NAME [install/update/remove]"
    echo "  install - Install Burpsuite Community x64"
    echo "  update  - Update to latest Burpsuite Community x64"
    echo "  remove  - Remove Burp Suite Community x64"
    echo "  help    - Display this help message and exit"
else
   BURPSUITE_exec="$(which java) -jar $BURPSUITE_PATH"
   if [ -f "$BURPSUITE_PATH" ]; then
       $BURPSUITE_exec
   else
        echo "Invalid argument. Use 'help' for usage information."
   fi
fi
