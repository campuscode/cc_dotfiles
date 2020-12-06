if &compatible
  set nocompatible
end

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'christoomey/vim-tmux-navigator'
Plug 'lifepillar/vim-solarized8'
Plug 'gruvbox-community/gruvbox' " default colorscheme
Plug 'scrooloose/nerdtree' " file explorer
Plug 'ctrlpvim/ctrlp.vim' " fuzzy finder
Plug 'pbrisbin/vim-mkdir' " create folder if it doesn't exist
Plug 'scrooloose/syntastic' " syntax checking
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rails'
Plug 'keith/rspec.vim'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/tComment'
Plug 'chrisbra/color_highlight'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-airline/vim-airline' " Pretty status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-runner'
Plug 'rking/ag.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'

if filereadable(expand("~/.plugins.vim.local"))
  source ~/.plugins.vim.local
endif

call plug#end()
