#!/bin/sh

if [ ! -d "$HOME/.cc_dotfiles" ]
then
  echo "Installing Campus Code Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - rvm"
  echo "  - nodejs"

  case "$(uname -s)" in
    Linux)
      echo "  - vim (vim-gnome)"
      NODE_VERSION=12

      sudo apt-get update
      sudo apt-get install -y software-properties-common gnupg2
      sudo add-apt-repository -y ppa:pi-rho/dev
      gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
      curl -sSL https://get.rvm.io | bash -s stable --rails
      curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

      sudo apt-get install -y silversearcher-ag \
        git \
        build-essential \
        zsh \
        tmux \
        dconf-cli \
        vim-gnome \
        nodejs \
        yarn \
        ruby
      ;;
    Darwin )
      echo "  - vim (macvim)"
      echo "  - google-chrome (mac)"
      echo "  - iterm2 (mac)"
      echo "  - atom (mac)"
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
      curl -sSL https://get.rvm.io | bash -s stable --ruby
      sudo usermod -a -G rvm `whoami`
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
  git clone --depth=10 https://github.com/campuscode/cc_dotfiles.git "$HOME/.cc_dotfiles"
  cd "$HOME/.cc_dotfiles"
  rake install
else
  echo "You already have Campus Code Dotfiles installed."
fi
