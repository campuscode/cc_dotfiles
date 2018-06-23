#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher
brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit
brew cask install atom
brew cask install google-chrome
brew cask install iterm2

