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
set rtp+=/usr/local/opt/fzf

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

" Initialize plugin system
call plug#end()

" https://pragmaticpineapple.com/improving-vim-workflow-with-fzf/
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-g> :Rg<Cr>
