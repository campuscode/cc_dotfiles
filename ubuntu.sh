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
  THEME_NAME=${THEME_NAME:-gruvbox-dark}
  TERMINAL=${TERMINAL:-gnome-terminal}
  wget https://raw.githubusercontent.com/Mayccoll/Gogh/master/themes/${THEME_NAME}.sh
  chmod +x ${THEME_NAME}.sh
  ./${THEME_NAME}.sh
  rm ${THEME_NAME}.sh
}

install_docker() {
  DOCKER_COMPOSE_VERSION="${DOCKER_COMPOSE_VERSION:-1.29.2}"
  sudo apt-get install -y docker.io
  sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

install_tmux > /dev/null 2>&1
install_gnome_terminal_colors
install_docker

sudo apt-get remove -y ruby
sudo apt-get autoremove -y
