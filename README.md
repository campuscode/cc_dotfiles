CAMPUS CODE Dotfiles
====================

## Source of inspiration

Our dotfiles are based on following amazing dotfiles:

[Skwp Dotfiles](http://github.com/skwp/dotfiles)

[ThoughtBot Dotfiles](http://github.com/thoughtbot/dotfiles)

## Requirements

* Zsh
* Ag
* ITerm (Mac) or GVim (Linux)
* Solarized
* zsh-syntax-highlighting
* Tmux

## Install

We'll write a script to install, before that you'll be able to use if do the following
steps.

* Make sure you have all requirements installed in your machine.
* Run follow commands:

```
$ cd
$ chsh -s $(which zsh)
$ git clone git@github.com:campuscode/cc_dotfiles.git
$ mv .vimrc .vimrc.bkp
$ mv .tmux.conf .tmux.conf.bkp
$ mv .zshrc .zshrc.bkp
$ mv .zshenv .zshenv.bkp
$ mv .zsh .zsh_bkp
$ mv .vim .vim.bkp
$ mv .gitconfig .gitconfig.bkp
$ ln -s .cc_dotfiles/
$ ln -s .cc_dotfiles/vimrc .vimrc
$ ln -s .cc_dotfiles/tmux.conf .tmux.conf
$ ln -s .cc_dotfiles/zshrc .zshrc
$ ln -s .cc_dotfiles/zshenv .zshenv
$ ln -s .cc_dotfiles/vim .vim
$ ln -s .cc_dotfiles/git/gitconfig .gitconfig
$ ln -s .cc_dotfiles/git/gitignore .gitignore
$ ln -s .cc_dotfiles/aliases.zsh .aliases.zsh
$ ln -s .cc_dotfiles/gemrc .gemrc
$ ln -s .cc_dotfiles/bin .bin
$ source .zshenv
$ source .zshrc
$ tat # to open a new session of tmux
```

## It's easy to make your customizations

Place your customizations in the following files:

* .aliases.local
* .secrets
* .zshrc.local
* .vimrc.local
* .zshenv.local
* .plugin.vim.local
* .tmux.conf.local
* .gitconfig.local
