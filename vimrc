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
set nowrap
set number
set numberwidth=4
set signcolumn=yes
set shiftround
set wildignore=*.o
set t_ut=
set directory=~/.vim/swap//
set clipboard^=unnamedplus
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

runtime autosource.vim

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
let g:airline_theme = 'base16_darktooth'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = '?'
let g:airline#extensions#ale#enabled = 1
colorscheme base16-darktooth
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_c = ['clang_format']
let g:formatdef_clang_format = '"clang-format"'
let g:formatters_rs = ['rustfmt']
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_haskell = ['hindent']
let g:formatdef_hindent = '"hindent"'
let g:formatters_python = ['black', 'isort']
let g:formatdef_black = '"black"'
let g:formatdef_isort = '"isort -"'
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 0
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:rooter_patterns = ['.git', '.local_vimrc.vim']
let g:SuperTabDefaultCompletionType = "<c-n>"
set omnifunc=ale#completion#OmniFunc

autocmd FileType vim let b:autoformat_autoindent = 1
autocmd FileType json syntax sync minlines=100
autocmd BufWrite * :Autoformat

