# This Dockerfile is used to build an headles vnc image based on Ubuntu:latest
FROM ubuntu:latest
LABEL maintainer="sys41x4@gmail.com"
MAINTAINER Arijit Bhowmick "sys41x4@gmail.com"
ENV REFRESHED_AT 2023-05-20

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT


### Envrionment config
ENV HOME=/app \
    SUPERVISOR_USER=app \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    TZ=Asia/Kolkata \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8' \
    INST_SCRIPTS=/app/install \
    UPDT_SCRIPTS=/app/updates \
    TOOLS_DIR=/app/tools \
    DATA_DIR=/app/data \
    PYTHON_VENV_DIR=/app/venv \
    NO_VNC_HOME=/app/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=password \
    VNC_VIEW_ONLY=false
WORKDIR $HOME

### Add all install scripts for further steps
ADD ./src/common/install/ $INST_SCRIPTS/
ADD ./src/debian/install/ $INST_SCRIPTS/
ADD ./src/common/update/ $UPDT_SCRIPTS/
ADD ./src/common/app_shortcut/ $HOME/shortcut/
ADD ./src/extras/ $INST_SCRIPTS/


## Create Base Directories
RUN mkdir -p $HOME $TOOLS_DIR/setup $DATA_DIR/wordlists /opt/app

### Install base tools
RUN $INST_SCRIPTS/tools.sh


### Install xvnc-server & noVNC - HTML5 based VNC viewer
RUN $INST_SCRIPTS/tigervnc.sh
RUN $INST_SCRIPTS/no_vnc.sh


### Install xfce UI
RUN $INST_SCRIPTS/xfce_ui.sh
ADD ./src/common/xfce/ $HOME/

### Add Additional repositories
RUN $UPDT_SCRIPTS/repositories.sh

## Set Keyboard type to US
RUN echo "keyboard-configuration keyboard-configuration/layout select us" | debconf-set-selections

### Install applications
RUN $INST_SCRIPTS/applications.sh

### Install security-testing applications
RUN $INST_SCRIPTS/app/security-testing-apps.sh

### configure startup
ADD ./src/common/scripts $STARTUPDIR
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

### Create USER:app
RUN $INST_SCRIPTS/setup_user.sh $SUPERVISOR_USER


# Switch to app user
WORKDIR /home/$SUPERVISOR_USER
USER $SUPERVISOR_USER

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]
