#!/bin/bash

apt install tmux git pydf htop nmap wget curl atool bzip2

cd /etc

BASEPATH="https://raw.githubusercontent.com/andreasnuesslein/starterkit/master"
# tmux
wget $BASEPATH/etc/tmux.conf -O /etc/tmux.conf

# gitconfig
wget $BASEPATH/etc/gitconfig -O /etc/gitconfig

# bash
wget $BASEPATH/etc/bash_color.sh -O /etc/bash_color.sh
wget $BASEPATH/etc/bash_prompt.sh -O /etc/bash_prompt.sh
wget $BASEPATH/etc/DIR_COLORS -O /etc/DIR_COLORS
wget $BASEPATH/etc/bash.bashrc -O /etc/bash.bashrc
wget $BASEPATH/etc/profile -O /etc/profile

# vim
wget $BASEPATH/etc/vimrc -O /etc/vimrc