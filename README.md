CAMPUS CODE Dotfiles
====================

## Introdução

Nosso _dotfiles_ são inspirados nos seguintes excelentes dotfiles:

[Skwp Dotfiles](http://github.com/skwp/dotfiles)

[ThoughtBot Dotfiles](http://github.com/thoughtbot/dotfiles)

Esse dotfiles são usados nos nossos treinamentos, por isso a instalação desse
dotfiles incluem alguns outros programas, os quais são parte do treinamento.

## Softwares instalados

* Zsh
* [Ag](https://github.com/ggreer/the_silver_searcher)
* [Solarized](http://ethanschoonover.com/solarized)
* Tmux

Somente no MacOs

* [ITerm 2 (Mac)](https://www.iterm2.com/index.html)
* Chrome
* Atom
* Visual Studio Code
* MVim

Somente no Ubuntu Family

* GVim

## Pre-Requirements

Ubuntu

- `sudo apt-get install -y curl`

## Install

Execute o seguinte comando após instalar o `curl`:

```
sh -c "`curl -fSs https://raw.githubusercontent.com/campuscode/cc_dotfiles/master/install.sh`"
```

Sua senha será solicitada para completar a instalação quando necessário.

## Docs

- [Vim Key Mapping](docs/Vim.md)
- [Tmux Key Mapping](docs/Tmux.md)
- [Zsh Key Mapping / Aliases](docs/Zsh.md)

#### It's easy to make your customizations

Place your customizations in the following files:

* .aliases.local
* .secrets
* .zshrc.local
* .vimrc.local
* .zshenv.local
* .plugin.vim.local
* .tmux.conf.local
* .gitconfig.local
