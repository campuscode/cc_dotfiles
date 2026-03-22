#!/bin/bash
set -eu

if ! command -v brew > /dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

brew install openssl@3 libyaml readline zsh ctags git gh tmux the_silver_searcher macvim
brew install --cask visual-studio-code google-chrome iterm2 orbstack
