#!/bin/sh
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
sudo apt-get update
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install silversearcher-ag
sudo apt-get install zsh
sudo apt-get install tmux
sudo apt-get install dconf-cli
sudo apt-get install vim-gnome
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
~/.cc_dotfiles/gnome-terminal-colors-solarized/install.sh 
