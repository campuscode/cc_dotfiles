#!/bin/sh

if [ ! -d "$HOME/.cc_dotfiles" ]
then
  echo "Installing Campus Code Dotfiles"
  echo "Make sure you have installed: "
  echo "tmux - brew install tmux"
  echo "zsh - brew install zsh"
  echo "ag (silver searcher) brew install the_silver_searcher"
  git clone --depth=10 https://github.com/campuscode/cc_dotfiles.git "$HOME/.cc_dotfiles"
  cd "$HOME/.cc_dotfiles"
  rake install
else
  echo "You already have Campus Code Dotfiles installed."
fi
