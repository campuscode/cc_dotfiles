#!/bin/sh

if [ ! -d "$HOME/.cc_dotfiles" ]
then
  echo "Installing Campus Code Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - mise (Ruby, Node.js)"

  case "$(uname -s)" in
    Linux)
      echo "  - vim (vim-gtk3)"
      echo "  - Docker"
      echo "  - docker-compose"

      sudo apt-get update
      sudo apt-get install -y software-properties-common dconf-cli uuid-runtime

      sudo apt-get install -y silversearcher-ag \
        git \
        xclip \
        build-essential \
        zsh \
        dconf-cli \
        vim-gtk3 \
        ruby \
        libevent-dev \
        ncurses-dev \
        bison \
        pkg-config

      curl https://mise.run | sh
      ~/.local/bin/mise install ruby node
      ;;
    Darwin )
      curl https://mise.run | sh
      ~/.local/bin/mise install ruby node
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows machine which is not recommended to use with our' \
           ' dotfiles.'
      echo 'You can clone our repository and try install it manually.'
      return
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  if [ -z "$LOCAL_INSTALL" ]
  then
    echo "FROM REMOTE SOURCE"
    git clone --depth=10 https://github.com/campuscode/cc_dotfiles.git "$HOME/.cc_dotfiles"
  else
    echo "LOCAL SOURCE"
    cp -r . "$HOME/.cc_dotfiles"
  fi
  cd "$HOME/.cc_dotfiles"
  rake install
else
  echo "You already have Campus Code Dotfiles installed."
fi
