#!/bin/sh

if [ ! -d "$HOME/.cc_dotfiles" ]
then
  echo "Installing Campus Code Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - vim (vim-gnome | macvim)"
  echo "  - google-chrome"

  case "$(uname -s)" in
    Linux)
      echo "  - git(linux)"
      echo "  - spotify(linux)"
      echo "  - rambox(linux)"
      sudo apt-get install git
      sudo apt-get install ruby
      ;;
    Darwin )
      echo "  - iterm2 (mac)"
      echo "  - atom (mac)"
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows machine which is not recommended to use with our' \
           ' dotfiles.'
      echo 'You can clone our repository and install it manually.'
      return
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  git clone --depth=10 https://github.com/HenriqueMorato/cc_dotfiles.git "$HOME/.cc_dotfiles"
  cd "$HOME/.cc_dotfiles"
  rake install
else
  echo "You already have Campus Code Dotfiles installed."
fi
