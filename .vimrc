syntax on

set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4

set number

:color desert


"vim plug
call plug#begin()

"vim lsp
Plug 'prabirshrestha/vim-lsp'
"vim lsp seetings make easily setup lsp
Plug 'mattn/vim-lsp-settings'
"cmp
Plug 'prabirshrestha/asyncomplete.vim'
"cmp-lsp
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"auto pair
Plug 'jiangmiao/auto-pairs'
call plug#end()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

