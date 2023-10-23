#!/bin/bash
### every exit != 0 fails the script

create_sudo_user(){
    # RUN addgroup -S app && adduser -S app -G app
    useradd -m $1
    usermod -a -G sudo $1
    # Allow the user to use sudo without a password
    echo "$1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    chsh -s /bin/bash $1
}

set_rwx_perm_2_user(){
    chown -R $2:$2 $1 && chmod -R u+rwX,g+rX,o-rwx $1
}


create_sudo_user $1


apt-get install -y python3-venv

# Setup environment for python modules
python3 -m venv $PYTHON_VENV_DIR

# Set Access Permission to user $1
set_rwx_perm_2_user $1 $TOOLS_DIR
set_rwx_perm_2_user $1 $PYTHON_VENV_DIR
set_rwx_perm_2_user $1 $HOME
set_rwx_perm_2_user $1 $NO_VNC_HOME
set_rwx_perm_2_user $1 "/entrypoint.sh"
PATH="/venv/bin:$PATH"

export GOPATH=$HOME/go
export PATH=$HOME/.local/bin:/usr/local/go/bin:$GOPATH/bin:$PATH

cp $HOME/install/.bashrc $HOME/

touch $HOME/.bashrc
. $HOME/.bashrc
