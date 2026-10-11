call plug#begin()
Plug 'JuliaEditorSupport/julia-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'leafgarland/typescript-vim'
Plug 'marnix/metamath.vim'
Plug 'rhysd/vim-llvm'
Plug 'rhysd/vim-wasm'
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

let ayucolor="mirage"
colorscheme ayu

" Follow the terminal background (OSC 11 reply, e.g. rgb:ffff/ffff/ffff)
function! s:AyuFollowTerm() abort
    let rgb = matchlist(v:termrbgresp, 'rgb:\(\x\x\)\x*/\(\x\x\)\x*/\(\x\x\)')
    if empty(rgb) | return | endif
    let [r, g, b] = map(rgb[1:3], 'str2nr(v:val, 16)')
    let style = 2 * r + 5 * g + b > 1020 ? "light" : "mirage"
    if style != g:ayucolor
        let g:ayucolor = style
        colorscheme ayu
        " The reply is read while Vim waits for keys, so repaint now
        redraw!
    endif
endfunction

if exists('##TermResponseAll')
    au TermResponseAll background call s:AyuFollowTerm()
endif

au BufRead,BufNewFile *.phps set ft=php

let g:copilot_filetypes = {
    \ '*': v:true,
    \ }
