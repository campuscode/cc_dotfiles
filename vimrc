" Leader
let mapleader = " "

" syntax highlighting
syntax on

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=1000  " a lot of history
set ruler         " show the cursor position all the time
set hlsearch
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set ignorecase    " Ignore case when searching...
set smartcase     " ...unless we type a capital
set showmode      " Show current mode down the bottom
set visualbell    " No noise
set noerrorbells  " No noise
set t_vb=         " No noise
set nowrap        " Don't wrap lines
set modeline      " Turn modeline on (Vi magic comment)
set modelines=5
set nomodelineexpr
set tabstop=2 " Softtabs, 2 spaces
set shiftwidth=2
set shiftround
set expandtab
set textwidth=80 " Make it obvious where 80 characters is
set colorcolumn=+1
set number " Numbers
set numberwidth=5
set relativenumber " Make easy to navigate
set wildmode=list:longest,list:full " enable list of completion
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.cache " skip tmp files
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set spellfile=$HOME/.vim-spell.utf-8.add " Set spellfile to location that is guaranteed to exist
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set diffopt+=vertical " Always use vertical diffs
set splitbelow " Open new split panes to right and bottom,
set splitright " which feels more natural
set spelllang=en_us,pt_br " we're trying to be bilingual

" Load plugins
so ~/.vim/plugins.vim

" Load custom settings
so ~/.vim/settings.vim

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_user_command =
      \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" Default to filename searches
let g:ctrlp_by_filename = 1

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

set background=dark " cause I'm not a psychopath

" set your colorscheme on ~/.vimrc.local
if !exists('g:colors_name') || g:colors_name == 'default'
  try
    colorscheme gruvbox
  catch
  endtry
endif
