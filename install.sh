#!/bin/bash
set -eu

if [ -d "$HOME/.cc_dotfiles" ]; then
  echo "You already have Campus Code Dotfiles installed."
  exit 0
fi

echo "Installing Campus Code Dotfiles"
echo "We'll install:"
echo "  - tmux"
echo "  - silver searcher"
echo "  - zsh"
echo "  - mise (Ruby, Node.js)"

case "$(uname -s)" in
  Linux)
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

    curl https://mise.run | sh
    eval "$(~/.local/bin/mise activate bash)"
    mise settings ruby.compile=false
    mise use --global ruby node
    ;;
  Darwin)
    curl https://mise.run | sh
    eval "$(~/.local/bin/mise activate bash)"
    mise settings ruby.compile=false
    mise use --global ruby node
    ;;
  *)
    echo "Operational system not supported, aborting installation"
    exit 1
    ;;
esac

if [ -z "${LOCAL_INSTALL:-}" ]; then
  echo "Installing from remote source"
  git clone --depth=10 https://github.com/campuscode/cc_dotfiles.git "$HOME/.cc_dotfiles"
else
  echo "Installing from local source"
  rsync -a --no-perms --exclude='.vagrant' --exclude='.git' --exclude='tags' --exclude='vim/autoload' --exclude='vim/bundle' --exclude='vim/backups' . "$HOME/.cc_dotfiles"
  curl -fLo "$HOME/.cc_dotfiles/vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cd "$HOME/.cc_dotfiles"
rake install

