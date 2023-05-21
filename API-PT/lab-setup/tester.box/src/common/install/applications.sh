#!/bin/bash

echo "Installing system & build applications"

apt-get update && \
apt-get install -y git \
        sudo \
        golang \
        file \
        default-jdk \
        terminator \
        mousepad \
        python3 \
        python3-pip \
        python3-numpy \
        python3-venv \
        firefox-esr

apt-get clean -y
