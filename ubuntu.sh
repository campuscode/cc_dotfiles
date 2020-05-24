#!/bin/bash

install_tmux() {
  TMUX_VERSION="3.1b"
  TMUX_SOURCE_FILE="tmux-${TMUX_VERSION}.tar.gz"
  TMUX_SOURCE_FOLDER="tmux-${TMUX_VERSION}"

  echo "Installing tmux ${TMUX_VERSION}"
  wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX_SOURCE_FILE}
  tar -xf ${TMUX_SOURCE_FILE}
  pushd $TMUX_SOURCE_FOLDER
  ./configure
  make
  sudo make install
  popd
  rm -rf $TMUX_SOURCE_FOLDER
  rm $TMUX_SOURCE_FILE
}

install_gnome_terminal_colors() {
  GIT_REPO="https://github.com/Anthony25/gnome-terminal-colors-solarized.git"
  COLORS_PATH="$HOME/.gnome-terminal-colors-solarized"

  [ -d $COLORS_PATH ] && return

  git clone $GIT_REPO $COLORS_PATH
  $COLORS_PATH/install.sh
}

install_tmux > /dev/null 2>&1
install_gnome_terminal_colors

sudo apt-get remove -y ruby
sudo apt-get autoremove -y
