" Make Vim more useful
set nocompatible

filetype indent plugin on
syntax on
set number
set rnu
set wrap
set background=dark

set incsearch
set nohlsearch

set ignorecase
set smartcase

" Use the OS clipboard by default on versions compiled with +clipboard
set clipboard=unnamed

" fzf vim bindings
set rtp+=~/.fzf

" nnoremap <silent> <C-f> :Files<CR>

" Edit ~/.vimrc file
nnoremap ev :e $MYVIMRC<CR>
" Reload ~/.vimrc file
nnoremap rv :w!<Esc>:source $MYVIMRC<CR>

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

" Plugins installation list
" https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Initialize plugin system
call plug#end()

" https://pragmaticpineapple.com/improving-vim-workflow-with-fzf/
nnoremap <C-p> :GFiles<Cr>