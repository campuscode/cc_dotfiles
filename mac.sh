#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher
brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit
brew cask install atom
brew cask install google-chrome
brew cask install iterm2
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable

