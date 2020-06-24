CAMPUS CODE Dotfiles
====================

![](https://i.imgur.com/XogkB7V.png)

## Source of inspiration

Our dotfiles are based on following amazing dotfiles:

[Skwp Dotfiles](http://github.com/skwp/dotfiles)

[ThoughtBot Dotfiles](http://github.com/thoughtbot/dotfiles)

## Requirements

* Zsh
* [Ag](https://github.com/ggreer/the_silver_searcher)
* [ITerm 2 (Mac)](https://www.iterm2.com/index.html)
* MVim (Mac) or GVim (Linux)
* [Solarized](http://ethanschoonover.com/solarized)
* Tmux

## Pre-Requirements

- curl

Ubuntu

- `sudo apt-get install -y curl`

## Install

Run follow command:

```
sh -c "`curl -fSs https://raw.githubusercontent.com/campuscode/cc_dotfiles/master/install.sh`"
```

Type your password to change your default shell to `zsh`

## Docs

[Vim Key Mapping](Vim.md)

[Tmux Key Mapping](Tmux.md)

#### It's easy to make your customization

Place your customization in the following files:

* .aliases.local
* .secrets
* .zshrc.local
* .vimrc.local
* .zshenv.local
* .plugin.vim.local
* .tmux.conf.local
* .gitconfig.local
