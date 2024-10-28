#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher
brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit
brew install --cask atom
brew install --cask google-chrome
brew install --cask iterm2

