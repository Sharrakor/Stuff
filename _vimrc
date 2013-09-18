"""""""""""""""""""""""""""""""""""""""""""
" Vim config file
"
" Virtually all credit goes to Amir Salihefendic @ http://amix.dk/vim/vimrc.html
" as well as Daniel Cousens	
""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""
set autoread


""""""""""""""""""""""""""""""""""""""""""""
" Navigation
""""""""""""""""""""""""""""""""""""""""""""
noremap <down> <nop>
noremap <up> <nop>
noremap <left> <nop>
noremap <right> <nop>

nnoremap j gj
nnoremap k gk

""""""""""""""""""""""""""""""""""""""""""""
" Colors and fonts
""""""""""""""""""""""""""""""""""""""""""""
syntax enable


""""""""""""""""""""""""""""""""""""""""""""
" Text, tabs and indentation
""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
"set expandtab

set smarttab

" One tab equals four spaces
set shiftwidth=4
set tabstop=4

set ai " Auto-indent
set si " Smart indent
set wrap " Wrap lines


""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings
""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
