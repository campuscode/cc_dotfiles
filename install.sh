#!/bin/sh

if [ ! -d "$HOME/.cc_dotfiles" ]
then
  echo "Installing Campus Code Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - vim (vim-gnome | macvim)"
  echo "  - google-chrome (mac)"
  echo "  - iterm2 (mac)"
  echo "  - atom (mac)"

  case "$(uname -s)" in
    Linux)
      sudo apt-get install -y git curl gnupg build-essential
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
      curl -sSL https://get.rvm.io | bash -s stable --ruby
      sudo usermod -a -G rvm `whoami`
      ;;
    Darwin )
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
      curl -sSL https://get.rvm.io | bash -s stable --ruby
      sudo usermod -a -G rvm `whoami`
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows which is not recommended to use with out dotfiles.'
      echo 'Abort installation'
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
