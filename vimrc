" Basic configuration.
if &compatible
    set nocompatible
endif

syntax on
filetype plugin indent on
set laststatus=2
set termguicolors
set incsearch
set nohlsearch
set autowrite
set number
set numberwidth=4
set signcolumn=yes
set shiftround
set wildignore=*.o
set t_ut=
set directory=~/.vim/swap//
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

" Autocommands that don't need plugins.
autocmd BufRead,BufNewFile .clang-format set ft=yaml
autocmd BufRead,BufNewFile .clang-tidy set ft=yaml
autocmd BufRead,BufNewFile .clangd set ft=yaml

" Plugin setup.
function! PackInit() abort
    packadd minpac

    runtime plugins.vim
endfunction

" Convenient plugin management commands.
command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" Configuration that needs plugins.
let g:airline_theme = 'dracula'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = '?'
colorscheme dracula
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_c = ['clang_format']
let g:formatdef_clang_format = '"clang-format"'

autocmd FileType vim let b:autoformat_autoindent = 1
autocmd BufWrite * :Autoformat

