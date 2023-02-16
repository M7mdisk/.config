let mapleader = ','
let maplocalleader = ','

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

Plug 'navarasu/onedark.nvim'
Plug 'dhruvasagar/vim-zoom'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'

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
nnoremap <Leader>R :Reload <CR>
nnoremap <space>w :w <CR>


set tabstop=4
set shiftwidth=4
set expandtab

set noswapfile
