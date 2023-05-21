#!/bin/bash

set -e

echo "Installing LAB tools"

sudo mkdir -p $TOOLS_DIR/setup

# Install pip modules witl USER:app priviledges

## Install Arjun
pip3 install arjun

## Install mitmproxy2swagger
pip3 install mitmproxy2swagger

# Install JSON Web Token Toolkit
cd TOOLS_DIR && \
git clone https://github.com/ticarpi/jwt_tool.git && \
cd jwt_tool && \
pip3 install termcolor cprint pycryptodomex requests && \
sudo chmod +x $TOOLS_DIR/jwt_tool/jwt_tool.py && \
sudo ln -s $TOOLS_DIR/jwt_tool/jwt_tool.py /opt/app/jwt_tool.py && \
sudo chmod +x /opt/app/jwt_tool.py && \
sudo ln -s /opt/app/jwt_tool /usr/bin/jwt_tool

## Install Kiterunner
cd $TOOLS_DIR/setup && \
wget https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_amd64.tar.gz -O kiterunner.ta>
tar -xvf kiterunner.tar.gz && \
mv kr $TOOLS_DIR/ && \
sudo ln -s $TOOLS_DIR/kr /usr/local/bin/kr


# Install Postman for API Testing
# wget https://dl.pstmn.io/download/latest/linux64 -O $TOOLS_DIR/setup/postman-linux-x64.tar.gz && \
# cd $TOOLS_DIR/setup && \
# tar -xvf postman-linux-x64.tar.gz && \
# mv Postman ../ && \
# sudo ln -s $TOOLS_DIR/Postman/Postman /opt/postman && \
# sudo ln -s /opt/postman /usr/bin/postman

## Download jython JAR File for Burpsuite
# wget https://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.2/jython-installer-2.7.2.jar -O /too>


# Get Burpsuite JAR File
# wget https://portswigger.net/burp/releases/download -O $TOOLS_DIR/burpsuite.latest.jar && \
# sudo echo "java -jar $TOOLS_DIR/burpsuite.latest.jar" > /opt/app/burpsuite.sh && \
# sudo chmod +x /opt/app/burpsuite.sh && \
# sudo ln -s /opt/app/burpsuite.sh /usr/bin/burpsuite
