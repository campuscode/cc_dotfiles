# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is **Campus Code Dotfiles (cc_dotfiles)** — a shared dotfiles distribution for zsh, vim, tmux, and git, inspired by [skwp/dotfiles](https://github.com/skwp/dotfiles) and [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles). It targets macOS and Ubuntu.

## Installation

```bash
# Remote install (clones to ~/.cc_dotfiles, then runs rake install)
sh -c "$(curl -fSs https://raw.githubusercontent.com/campuscode/cc_dotfiles/master/install.sh)"

# Local install
LOCAL_INSTALL=1 ./install.sh
```

The `rake install` task symlinks config files into `~/` (prefixed with `.`), installs fonts, vim-plug plugins, zsh-syntax-highlighting, tmux-battery plugin, and changes the default shell to zsh.

## Architecture

**Rakefile** is the main installer — it symlinks files, installs prerequisites via `mac.sh` or `ubuntu.sh`, and sets up plugins. All dotfiles are symlinked from this repo into `$HOME` as hidden files (e.g., `aliases` → `~/.aliases`).

**Customization layer**: Every config file sources a `.local` counterpart if present. Users should put personal overrides in these files rather than modifying the repo directly:
- `~/.aliases.local`, `~/.zshrc.local`, `~/.zshenv.local`, `~/.vimrc.local`, `~/.plugins.vim.local`, `~/.tmux.conf.local`, `~/.gitconfig.local`, `~/.secrets`

**Key conventions**:
- Vim leader key is `<Space>`
- Tmux prefix is `C-a` (not the default `C-b`)
- Zsh uses vi mode with `jj` bound to escape
- Default colorscheme is gruvbox (dark background)
- Vim plugin manager is [vim-plug](https://github.com/junegunn/vim-plug) (`~/.vim/plugins.vim`)
- Vim settings are auto-loaded from individual files in `vim/settings/*.vim`
- Zsh functions are auto-loaded from `zsh/functions/*`
- Zsh theme is `peepcode` (`zsh/themes/peepcode.theme`)

**Shell aliases** (`aliases`): extensive git shortcuts (e.g., `gs`=status, `gco`=checkout, `gp`=push, `gpsh`=push current branch), docker-compose aliases (`dc`, `dcr`, `dcup`), and Rails/Ruby aliases (`rc`, `rs`, `rdm`).

**Git config** (`git/gitconfig`): uses patience diff algorithm, vimdiff as merge tool, rerere enabled, push default is `upstream`. Local overrides via `~/.gitconfig.local`.
