#!/bin/bash
set -eu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install zsh ctags git gh tmux the_silver_searcher macvim
brew install --cask visual-studio-code google-chrome iterm2
