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
" settings
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
set t_Co=256
set updatetime=500
set ruler
set vb t_vb=
set whichwrap=b,s,h,l,<,>,[,],~
set wildmenu

"
" mappings
"

nnoremap <Space> <Nop>
let mapleader = " "

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>h :noh<CR>

"
" plugins
"

call plug#begin('~/.vim/plugged')

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'hashivim/vim-terraform'
Plug 'elzr/vim-json'
Plug 'elkasztano/nushell-syntax-vim'

call plug#end()

" colorscheme
colorscheme catppuccin

" vim-terraform
let g:terraform_fmt_on_save = 1

" vim-lsp-settings
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server', 'eslint-language-server']

colorscheme catppuccin

" vim-terraform
let g:terraform_fmt_on_save = 1

" vim-lsp-settings
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server', 'eslint-language-server']

" vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" indentLine
let g:indentLine_setConceal = 0

" nerdtree
nnoremap <Leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" vim-json
let g:vim_json_syntax_conceal = 0

" lightline
" https://github.com/itchyny/lightline.vim/issues/293#issuecomment-373710096
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
