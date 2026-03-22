# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is **Campus Code Dotfiles (cc_dotfiles)** — a shared dotfiles distribution for zsh, vim, tmux, and git, targeting macOS and Ubuntu.

## Installation

```bash
# Remote install (clones to ~/.cc_dotfiles, then runs rake install)
bash -c "$(curl -fSs https://raw.githubusercontent.com/campuscode/cc_dotfiles/main/install.sh)"

# Local install (from a cloned repo)
LOCAL_INSTALL=1 bash install.sh
```

The `install.sh` installs system dependencies, sets up mise (Ruby/Node.js), then copies the repo to `~/.cc_dotfiles` and runs `rake install`. The Rake task symlinks config files into `~/` (prefixed with `.`), installs fonts, vim-plug plugins, zsh-syntax-highlighting, tmux-battery plugin, and changes the default shell to zsh.

## Testing

Tests run in isolated VMs to avoid affecting the host machine:
- **macOS**: Vagrant + UTM plugin with Ubuntu 24.04 Desktop (`vagrant up --provider=utm`)
- **Linux**: Multipass with Ubuntu 24.04 (`./tests/test_linux.sh`)

See [tests/README.md](tests/README.md) for detailed setup instructions.

## Architecture

**install.sh** is the entry point — installs system packages, mise, Ruby, and Node.js, then copies the repo and runs `rake install`.

**Rakefile** is the installer — symlinks files, runs `mac.sh` or `ubuntu.sh` for platform-specific prerequisites, and sets up plugins.

**mac.sh / ubuntu.sh** install platform-specific dependencies (Homebrew packages on macOS, Docker/tmux/Gogh on Ubuntu).

**Customization layer**: Every config file sources a `.local` counterpart if present. Users put personal overrides in `.local` files rather than modifying the repo.

**Key conventions**:
- Vim leader key is `<Space>`
- Tmux prefix is `C-a` (not the default `C-b`)
- Zsh uses vi mode with `jj` bound to escape
- Default colorscheme is gruvbox (dark background)
- Vim plugin manager is [vim-plug](https://github.com/junegunn/vim-plug) (`~/.vim/plugins.vim`)
- Vim settings are auto-loaded from `vim/settings/*.vim`
- Zsh functions are auto-loaded from `zsh/functions/*`
- Zsh theme is `peepcode` (`zsh/themes/peepcode.theme`)
- Ruby and Node.js managed by [mise](https://mise.jdx.dev)

**Shell aliases** (`aliases`): git shortcuts (`gs`=status, `gco`=checkout, `gp`=push, `gpsh`=push current branch), docker compose aliases (`dc`, `dcr`, `dcup`), and Rails/Ruby aliases (`rc`, `rs`, `rdm`).

**Git config** (`git/gitconfig`): patience diff algorithm, vimdiff as merge tool, rerere enabled, push default is `simple`. Local overrides via `~/.gitconfig.local`.
