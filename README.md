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

This is safe to run multiple times. Existing real files are backed up, while
managed symlinks are refreshed in place.

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

Personal overrides are stored under the Git-ignored `local/` directory. Running
`rake install` links each `local/<name>` to `~/.<name>`:

```text
local/aliases.local  -> ~/.aliases.local
local/vimrc.local    -> ~/.vimrc.local
local/zshrc.local    -> ~/.zshrc.local
```

On the first installation, existing files from the table above are copied into
`local/` before their originals are backed up and replaced with symlinks. If a
file already exists at both locations, the repository copy is backed up first
and the existing home configuration is imported. An existing backup is never
overwritten: the installer uses `.bkp`, `.bkp.1`, and so on. Symlinks that
already point to the corresponding `local/` file are left unchanged. Other
valid symlinks are imported and backed up; broken symlinks are reported and
left untouched because their contents cannot be copied.

All seven allowed files are guaranteed to exist under `local/` after
installation. Missing files are created empty, except `local/vimrc.local`,
which is initialized from the existing Vim template. An invalid entry already
using one of these paths, such as a directory or broken symlink, is preserved
under the next available backup name before the regular file is created.

Only the seven `*.local` files listed above are migrated automatically.
`~/.secrets` is never copied into the repository, including through a symlink
or hardlink bearing an allowed local-file name. An existing alias to
`~/.secrets` inside `local/` is removed without creating another repository
copy; the original secret file remains untouched.

The tracked `local/.keep` keeps the directory available after cloning. All
other entries under `local/` are excluded from Git, and the installer ignores
their names unless they appear in the allowlist above.

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
