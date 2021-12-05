"
" basic
"

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
syntax enable

"
" set
"

set ambiwidth=double
set autoindent
set backspace=indent,eol,start
set background=dark
set cursorline
set conceallevel=0
set display=lastline
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set hidden
set list
set number
set noswapfile
set sh=zsh
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set tags=.tags
set t_Co=256
set updatetime=500
set ruler
set vb t_vb=
set whichwrap=b,s,h,l,<,>,[,],~
set wildmenu

"
" plugins
"

call plug#begin('~/.vim/plugged')

Plug 'tomasr/molokai'
Plug 'bronson/vim-trailing-whitespace'
Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim'
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'hashivim/vim-terraform'

call plug#end()

" colorscheme
colorscheme molokai

" lexima
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()

" vim-terraform
let g:terraform_fmt_on_save = 1

" vim-lsp-settings
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server', 'eslint-language-server']
