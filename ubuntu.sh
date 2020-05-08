#!/bin/sh

TMUX_VERSION="3.1b"
TMUX_SOURCE_FILE="tmux-${TMUX_VERSION}.tar.gz"

install_tmux() {
  wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX_SOURCE_FILE}
  tar -xf ${TMUX_SOURCE_FILE}
  cd tmux-${TMUX_VERSION}
  ./configure && make
  sudo make install
}

install_tmux

git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
~/.cc_dotfiles/gnome-terminal-colors-solarized/install.sh

sudo apt-get remove -y ruby
