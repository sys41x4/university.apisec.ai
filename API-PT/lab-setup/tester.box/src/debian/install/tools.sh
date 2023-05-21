#!/bin/bash

echo "Install some common tools for further installation"
apt-get update
apt-get install -y \
        wget \
        curl \
        vim \
        wget \
        net-tools \
        gnupg \
        net-tools \
        openssl \
        locales \
        bzip2 \
        procps \
        python3-numpy #used for websockify/novnc
apt-get clean -y

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8
