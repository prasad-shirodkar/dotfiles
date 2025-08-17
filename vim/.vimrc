" Make Vim more useful
set nocompatible

filetype indent plugin on
syntax on
set number
set rnu
set wrap
set background=dark

set incsearch
set hlsearch

set ignorecase
set smartcase

" Use the OS clipboard by default on versions compiled with +clipboard
set clipboard=unnamed

" Copy and Paste to/from Vim from/to Other Programs! https://www.youtube.com/watch?v=E_rbfQqrm7g
"vnoremap <C-y> "+y
vnoremap <C-y> "*y :let @+=@*<CR>
" map <C-v> "+p
map <C-v> "+P

" fzf vim bindings
set rtp+=/usr/local/opt/fzf

" nnoremap <silent> <C-f> :Files<CR>

" Edit ~/.vimrc file
nnoremap ev :e $MYVIMRC<CR>
" Reload ~/.vimrc file
nnoremap rv :w!<Esc>:source $MYVIMRC<CR>

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins installation list
" https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'maralla/completor.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Enable lsp for go by using gopls
let g:completor_filetype_map = {}
let g:completor_filetype_map.go = {'ft': 'lsp', 'cmd': 'gopls -remote=auto'}"

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ["folding"]
let g:pandoc#spell#enabled = 0

" Initialize plugin system
call plug#end()

" https://pragmaticpineapple.com/improving-vim-workflow-with-fzf/
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-g> :Rg<Cr>
