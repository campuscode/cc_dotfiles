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
  if [[ -z "${TERMINAL}"  ]]; then
    TERMINAL=gnome-terminal bash -c "$(wget -qO- https://git.io/vQgMr)"
  else
    bash -c "$(wget -qO- https://git.io/vQgMr)"
  fi
}

install_docker() {
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo usermod -aG docker "$(whoami)"
}

install_tmux > /dev/null 2>&1
install_gnome_terminal_colors
install_docker

sudo apt-get autoremove -y
