#!/bin/bash

install_system_deps() {
  echo "  - vim (vim-gtk3)"

  sudo apt-get update
  sudo apt-get install -y software-properties-common dconf-cli uuid-runtime

  sudo apt-get install -y rsync \
    silversearcher-ag \
    git \
    xclip \
    build-essential \
    zsh \
    vim-gtk3 \
    libevent-dev \
    ncurses-dev \
    bison \
    pkg-config \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev
}

install_tmux() {
  TMUX_VERSION="${TMUX_VERSION:-3.6a}"
  TMUX_SOURCE_FILE="tmux-${TMUX_VERSION}.tar.gz"
  TMUX_SOURCE_FOLDER="tmux-${TMUX_VERSION}"

  echo "Installing tmux ${TMUX_VERSION}"
  curl -LO "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX_SOURCE_FILE}"
  tar -xf "${TMUX_SOURCE_FILE}"
  pushd "$TMUX_SOURCE_FOLDER"
  ./configure
  make
  sudo make install
  popd
  rm -rf "$TMUX_SOURCE_FOLDER"
  rm "$TMUX_SOURCE_FILE"
}

install_gnome_terminal_colors() {
  if [[ -z "${TERMINAL}" ]]; then
    TERMINAL=gnome-terminal bash -c "$(curl -sSLo- https://raw.githubusercontent.com/Mayccoll/Gogh/master/gogh.sh)"
  else
    bash -c "$(curl -sSLo- https://raw.githubusercontent.com/Mayccoll/Gogh/master/gogh.sh)"
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

install_system_deps
install_tmux

if [ -z "${CI:-}" ]; then
  install_gnome_terminal_colors
fi

if [ "${SKIP_DOCKER:-}" != "1" ]; then
  install_docker
fi

sudo apt-get autoremove -y
