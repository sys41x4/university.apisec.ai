#!/bin/bash

echo "Install TigerVNC server"
apt-get install -y tigervnc-standalone-server
apt-get clean -y
printf '\n# api-pt-tester:\n$localhost = "no";\n1;\n' >>/etc/tigervnc/vncserver-config-defaults
