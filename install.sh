#!/bin/bash
set -eu

if [ -d "$HOME/.cc_dotfiles" ]; then
  echo "You already have Campus Code Dotfiles installed."
  exit 0
fi

echo "Installing Campus Code Dotfiles"
echo "We'll install:"
echo "  - zsh, tmux, vim, git, silver searcher"
echo "  - mise with Ruby and Node.js"
echo "  - dotfiles configuration (symlinks, plugins, fonts)"

case "$(uname -s)" in
  Linux)
    bash "$(dirname "$0")/ubuntu.sh"
    ;;
  Darwin)
    bash "$(dirname "$0")/mac.sh"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
    ;;
  *)
    echo "Operational system not supported, aborting installation"
    exit 1
    ;;
esac

# Install mise with Ruby and Node.js — common to all platforms
curl https://mise.run | sh
eval "$(~/.local/bin/mise activate bash)"
mise settings ruby.compile=false
mise use --global ruby
mise use --global node

if [ -z "${LOCAL_INSTALL:-}" ]; then
  echo "Installing from remote source"
  git clone --depth=10 https://github.com/campuscode/cc_dotfiles.git "$HOME/.cc_dotfiles"
else
  echo "Installing from local source"
  rsync -a --no-perms --exclude='.vagrant' --exclude='.git' --exclude='tags' --exclude='vim/autoload' --exclude='vim/bundle' --exclude='vim/backups' . "$HOME/.cc_dotfiles"
  curl -fLo "$HOME/.cc_dotfiles/vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cd "$HOME/.cc_dotfiles"
rake install

