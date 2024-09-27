
syntax on

set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4
set relativenumber
set mouse-=a
set number

:color desert


"vim plug
call plug#begin()
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'     
Plug 'vim-airline/vim-airline-themes'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

"Check syntax in Vim/Neovim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'


Plug 'sainnhe/everforest'
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
"c head and source change
Plug 'vim-scripts/a.vim'
Plug '~/.vim/plugged/vim-tabby'

call plug#end()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
        if has('termguicolors')
          set termguicolors
        endif
        set background=dark
        let g:everforest_background = 'medium'
        let g:everforest_better_performance = 1
        colorscheme everforest
 
let b:ale_fixers = {'c':['clangtidy']}
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,typescript,arduino AutoFormatBuffer clang-format
  autocmd FileType clojure AutoFormatBuffer cljstyle
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType elixir,eelixir,heex AutoFormatBuffer mixformat
  autocmd FileType fish AutoFormatBuffer fish_indent
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType haskell AutoFormatBuffer ormolu
  " Alternative for web languages: prettier
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType jsonnet AutoFormatBuffer jsonnetfmt
  autocmd FileType julia AutoFormatBuffer JuliaFormatter
  autocmd FileType kotlin AutoFormatBuffer ktfmt
  autocmd FileType lua AutoFormatBuffer luaformatterfiveone
  autocmd FileType markdown AutoFormatBuffer prettier
  autocmd FileType ocaml AutoFormatBuffer ocamlformat
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType ruby AutoFormatBuffer rubocop
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType swift AutoFormatBuffer swift-format
  autocmd FileType vue AutoFormatBuffer prettier
augroup END
nnoremap <Space>w :update<CR>
" adding this for finding compiling error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
autocmd FileType c,cpp Glaive codefmt clang_format_executable="/home/jacksonc/bin/clang-format"
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
