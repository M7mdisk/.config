let mapleader = ' '
let maplocalleader = ' '

set number
set autoindent
set nocompatible
syntax enable
filetype plugin indent on

set mouse=a
set showmatch

set rtp+=/usr/bin/fzf

" Plugins
call plug#begin()

Plug 'navarasu/onedark.nvim' " Color Theme
Plug 'dhruvasagar/vim-zoom' " C-w to zoom into split
Plug 'junegunn/fzf' " Fuzzy finding
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround' " add surround functionality
Plug 'tyru/caw.vim' " Commenting

call plug#end()

" Colorscheme
colorscheme onedark

" Custom commands
command Vimrc  tabe ~/.config/nvim/init.vim
command TmuxConf  tabe ~/.tmux.conf
command Reload so ~/.config/nvim/init.vim

set ignorecase
set smartcase
set path+=**

" Remaps

nnoremap <Leader>f :Files <CR>
nnoremap <Leader>F :Files ~<CR>
nnoremap <Leader>R :Reload <CR>
nnoremap <Leader>w :w <CR>
nnoremap <Leader>q :q <CR>
nnoremap <Leader>t :belowright split term://zsh <CR>

autocmd TermOpen * startinsert
autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <leader>h :split 
nnoremap <leader>v :vsplit 


set tabstop=4
set shiftwidth=4
set expandtab
set noswapfile
set relativenumber
set termguicolors
