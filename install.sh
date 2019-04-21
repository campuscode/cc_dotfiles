#!/bin/sh

if [ ! -d "$HOME/.cc_dotfiles" ]
then
  echo "Installing Allan Siqueira"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - zsh"
  echo "  - vim (vim-gnome | macvim)"

  case "$(uname -s)" in
    Linux)
      sudo apt-get install -y git curl gnupg build-essential
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
      curl -sSL https://get.rvm.io | bash -s stable --ruby
      sudo usermod -a -G rvm `whoami`
      sudo apt-get install ruby
      ;;
    Darwin )
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
      curl -sSL https://get.rvm.io | bash -s stable --ruby
      sudo usermod -a -G rvm `whoami`
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows machine which is not recommended to use with our' \
           ' dotfiles.'
      return
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  git clone --depth=10 https://github.com/AllanSiqueira/sq_dotfiles.git "$HOME/.cc_dotfiles"
  cd "$HOME/.sq_dotfiles"
  rake install
else
  echo "You already have the Dotfiles installed."
fi
