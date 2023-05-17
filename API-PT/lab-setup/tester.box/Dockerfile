FROM ubuntu
LABEL maintainer="sys41x4@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Asia/Kolkata DEBIAN_FRONTEND=noninteractive


RUN mkdir -p /app /tools/setup /scripts /data/wordlists /opt/app

# Initial Package Installations
RUN apt update && apt install wget sudo curl gnupg tzdata -y

## Set Keyboard type to US
RUN echo "keyboard-configuration keyboard-configuration/layout select us" | debconf-set-selections


# Add Required Repositories
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | tee /etc/apt/sources.list
# Add Required Keys
RUN curl -sSL https://archive.kali.org/archive-key.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg > /dev/null
# RUN wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add -

# Update Package List
RUN apt update

# Install required packages
RUN apt install git golang python3 python3-pip python3-venv default-jdk wget snapd openssl -y
RUN apt install firefox-esr zaproxy -y
RUN apt install mitmproxy -y


# Setup environment for python modules
RUN python3 -m venv /venv
RUN chown -R app:app /venv && chmod -R u+rwX,g+rX,o-rwx /venv
RUN chown -R app:app /app && chmod -R u+rwX,g+rX,o-rwx /app
RUN chown -R app:app /tools && chmod -R u+rwX,g+rX,o-rwx /tools
RUN chown -R app:app /data && chmod -R u+rwX,g+rX,o-rwx /data
RUN chown -R app:app /home/app && chmod -R u+rwX,g+rX,o-rwx /home/app

ENV PATH="/venv/bin:$PATH"
ENV DISPLAY=:0
## Expose VNC port
EXPOSE 5901

# Install Desktop Environment as well as VNC Server
## Install XFCE Desktop Environment
# RUN apt install xfce4 xfce4-goodies -y # For Full fledge xfce4 session installation [WIll Create Heavy Image"
## Light Weight XFCE4 Installation
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-terminal \
    terminator \
    pcmanfm \
    mousepad \
    gvfs-backends \
    xorg \
    dbus-x11 \
    tigervnc-standalone-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Expose VNC port
EXPOSE 5901


# RUN addgroup -S app && adduser -S app -G app
RUN useradd -m app
RUN usermod -a -G sudo app
# Allow the user to use sudo without a password
RUN echo 'app ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install applications using snapd
## Install postman
#RUN service snapd start
#RUN snap refresh
#RUN snap install postman
RUN wget https://dl.pstmn.io/download/latest/linux64 -O /tools/setup/postman-linux-x64.tar.gz && \
    cd /tools/setup && \
    tar -xvf postman-linux-x64.tar.gz && \
    mv Postman ../ && \
    ln -s /tools/Postman/Postman /opt/postman && \
    ln -s /opt/postman /usr/bin/postman


## Download jython JAR File for Burpsuite
RUN wget https://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.2/jython-installer-2.7.2.jar -O /tools/jython-installer-2.7.2.jar


# Get Burpsuite JAR File
# RUN wget https://portswigger-cdn.net/burp/releases/download\?product\=community\&type\=Linux -O /tools/setup/burpsuite.latest.sh
RUN wget https://portswigger.net/burp/releases/download -O /tools/burpsuite.latest.jar && \
    echo "java -jar /tools/burpsuite.latest.jar" > /opt/app/burpsuite.sh && \
    chmod +x /opt/app/burpsuite.sh && \
    sudo ln -s /opt/app/burpsuite.sh /usr/bin/burpsuite


## Install Kiterunner
RUN cd /tools/setup && \
    wget https://github.com/assetnote/kiterunner/releases/download/v1.0.2/kiterunner_1.0.2_linux_amd64.tar.gz -O kiterunner.tar.gz && \
    tar -xvf kiterunner.tar.gz && \
    mv kr /tools/ && \
    ln -s /tools/kr /usr/local/bin/kr

## Generate Certificate and keys for burpsuite
#RUN mkdir -p /data/certs/burp && \
#    cd /data/certs/burp && \
#    openssl genrsa -out burp.key 2048 && \
#    openssl req -new -key burp.key -out burp.csr && \
#    openssl x509 -req -days 3650 -in burp.csr -signkey burp.key -out burp.crt && \
#    openssl x509 -in burp.crt -out burp.der -outform DER && \
#    openssl x509 -in burp.crt -out burp.pem -outform PEM

## Generate Certificates and keys for MiTM Proxy
#RUN mkdir -p /data/certs/mitmproxy && \
#    cd /data/certs/mitmproxy && \
#    openssl genrsa -out mitmproxy.key 2048 && \
#    openssl req -new -key mitmproxy.key -out mitmproxy.csr && \
#    openssl x509 -req -days 3650 -in mitmproxy.csr -signkey mitmproxy.key -out mitmproxy.crt && \
#    openssl x509 -in mitmproxy.crt -out mitmproxy.der -outform DER && \
#    openssl x509 -in mitmproxy.crt -out mitmproxy.pem -outform PEM
# You can get the wordlists and copy/link it to associated /data directory
# which in default would be /data/wordlists --> ./data/wordlists

# Switch to app user
USER app
WORKDIR /home/app
# Setup user:app paths
RUN export GOPATH=$HOME/go
RUN export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
RUN . ~/.bashrc


# Install pip modules witl USER:app priviledges

## Install Arjun
RUN pip3 install arjun
## Install mitmproxy2swagger
RUN pip3 install mitmproxy2swagger
# Install JSON Web Token Toolkit
RUN cd /tools && \
    git clone https://github.com/ticarpi/jwt_tool.git && \
    cd jwt_tool && \
    pip3 install termcolor cprint pycryptodomex requests && \
    sudo chmod +x /tools/jwt_tool/jwt_tool.py && \
    sudo ln -s /tools/jwt_tool/jwt_tool.py /opt/app/jwt_tool.py && \
    sudo chmod +x /opt/app/jwt_tool.py && \
    sudo ln -s /opt/app/jwt_tool /usr/bin/jwt_tool


## Setup VNC for USER:app
# Set up VNC password
RUN mkdir ~/.vnc
RUN echo "password" | vncpasswd -f > ~/.vnc/passwd
RUN chmod 600 ~/.vnc/passwd

# Set up VNC startup script
RUN echo "#!/bin/bash" > ~/.vnc/xstartup
RUN echo "xrdb /home/app/.Xresources" >> ~/.vnc/xstartup
RUN echo "startxfce4 &" >> ~/.vnc/xstartup
RUN chmod +x ~/.vnc/xstartup


# Clean the apt caches
RUN sudo apt autoremove && sudo apt clean

RUN sudo rm -r /tools/setup

WORKDIR /app

# Start the VNC server
CMD ["vncserver", "-fg", ":1"]
