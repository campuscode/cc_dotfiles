" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

" vim-rspec mappings
nnoremap <Leader>rs :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rn :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss 
" By skwp
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" create <%= foo %> erb tags using Ctrl-k in edit mode
imap <silent> <C-K> <%=  %><Esc>2hi

" create <%= foo %> erb tags using Ctrl-j in edit mode
imap <silent> <C-J> <%  %><Esc>2hi


" Re-enable tmux_navigator.vim default bindings, minus <c-\>.
" <c-\> conflicts with NERDTree "current file".

" Don't allow any default key-mappings.
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" vim reload
nmap <silent> <Leader>vr :so ~/.vimrc<CR>

" Type <space>hl to toggle highlighting on/off, and show current value.
noremap <Leader>hl :set hlsearch! hlsearch?<CR>

" Remapping CtrlP
" let g:ctrlp_map = ' t'
nnoremap <silent> <Leader>t :CtrlP<CR>
nnoremap <silent> <Leader>p :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <Leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <Leader>= :wincmd =<cr>

"" Tabs
nnoremap <S-Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>

" Rubocop
map <Leader>ru :call VtrSendCommand('rubocop')<CR>
map <Leader>rfu :call VtrSendCommand('rubocop ' . expand("%"))<CR>

" Flog
map <Leader>fl :call VtrSendCommand('flog ' . expand("%"))<CR>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

function! CloseNerdTree()
  if g:NERDTree.IsOpen()
    NERDTreeFind
    q
  else
    NERDTreeFind
  endif
endfunction
" ==== NERD tree
" Open the project tree and expose current file in the nerdtree with Ctrl-\
command! LocalCloseNerdTree call CloseNerdTree()
nnoremap <silent> <C-\> :LocalCloseNerdTree<cr>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

"grep the current word using K (mnemonic Kurrent)
nnoremap <silent> K :Ag <cword><CR>

