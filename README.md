Campus Code Dotfiles [![Build Status][build-status-image]][build-status]
====================

![](https://i.imgur.com/XogkB7V.png)

A shared dotfiles distribution for **zsh**, **vim**, **tmux**, and **git**, targeting macOS and Ubuntu.

Inspired by [Skwp Dotfiles](https://github.com/skwp/dotfiles) and [ThoughtBot Dotfiles](https://github.com/thoughtbot/dotfiles).

## What's included

- **Zsh** with vi mode, custom theme (peepcode), syntax highlighting, and extensive aliases
- **Vim** with vim-plug, gruvbox colorscheme, ALE linting, NERDTree, CtrlP, and tmux integration
- **Tmux** with `C-a` prefix, vim-aware pane navigation, battery status, and vi copy mode
- **Git** with aliases, patience diff, vimdiff merge tool, and rerere enabled
- **mise** for Ruby and Node.js version management
- **Docker** and Docker Compose via [OrbStack](https://orbstack.dev) (macOS) or Docker CE (Linux, optional)

## Pre-requisites

- curl

On Ubuntu, if not already installed:

```bash
sudo apt-get install -y curl
```

## Install

```bash
bash -c "$(curl -fSs https://raw.githubusercontent.com/campuscode/cc_dotfiles/main/install.sh)"
```

You will be prompted for your password to change the default shell to zsh.

For local development installs (from a cloned repo):

```bash
LOCAL_INSTALL=1 bash install.sh
```

## Update

To update your dotfiles configuration (re-create symlinks, update plugins, install fonts):

```bash
cd ~/.cc_dotfiles && git pull && rake install
```

This is safe to run multiple times — your `*.local` files will be preserved.

## Customization

Do not edit the dotfiles directly, as your changes will be overwritten on the next update. Instead, use the `.local` counterparts for your personal settings:

- `~/.vimrc.local` — Vim overrides (colorscheme, extra plugins, etc.)
- `~/.tmux.conf.local` — Tmux overrides
- `~/.zshrc.local` — Zsh overrides (extra aliases, PATH, etc.)
- `~/.aliases.local` — Extra aliases
- `~/.gitconfig.local` — Git overrides (user name, email, etc.)

## Customization

Every config file sources a `.local` counterpart if present. Place your personal overrides in these files rather than modifying the repo directly:

| File | Purpose |
|---|---|
| `~/.aliases.local` | Custom shell aliases |
| `~/.zshrc.local` | Zsh configuration overrides |
| `~/.zshenv.local` | Environment variables |
| `~/.vimrc.local` | Vim settings and colorscheme |
| `~/.plugins.vim.local` | Additional vim plugins |
| `~/.tmux.conf.local` | Tmux configuration overrides |
| `~/.gitconfig.local` | Git user name, email, and overrides |
| `~/.secrets` | API keys and tokens (not tracked by git) |

## Key conventions

- **Vim leader**: `<Space>`
- **Tmux prefix**: `C-a`
- **Zsh vi mode**: `jj` to escape
- **Colorscheme**: gruvbox (dark)

## Docs

- [Vim Key Mapping](Vim.md)
- [Tmux Key Mapping](Tmux.md)
- [Mise](Mise.md)
- [Testing](tests/README.md)

## Options

- `SKIP_DOCKER=1` — skip Docker installation on Linux

[build-status-image]: https://github.com/campuscode/cc_dotfiles/actions/workflows/test.yml/badge.svg?branch=main
[build-status]: https://github.com/campuscode/cc_dotfiles/actions/workflows/test.yml?query=branch%3Amain
