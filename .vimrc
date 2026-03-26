call plug#begin()
Plug 'ayu-theme/ayu-vim'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

set autoindent
set backspace=indent,eol,start
set expandtab
set formatoptions+=m
set incsearch
set hlsearch
set matchpairs+=<:>
set modeline
set mouse=a
set ruler
set shiftwidth=4
set softtabstop=4
set termguicolors
set guifont=DejaVu\ Sans\ Mono\ 11

let ayucolor="dark"
colorscheme ayu

au BufRead,BufNewFile *.phps set ft=php

let g:copilot_filetypes = {
    \ '*': v:true,
    \ }
