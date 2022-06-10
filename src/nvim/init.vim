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
set tags=.tags
set t_Co=256
set updatetime=500
set ruler
set vb t_vb=
set whichwrap=b,s,h,l,<,>,[,],~
set wildmenu

"
" mappings
"

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"
" plugins
"

call plug#begin('~/.vim/plugged')

" カラースキーム
Plug 'tomasr/molokai'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" 補完系
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" 便利系
Plug 'bronson/vim-trailing-whitespace' " 末尾空白可視化
Plug 'jiangmiao/auto-pairs' " 括弧補完
Plug 'mattn/emmet-vim' " emmet
Plug 'AndrewRadev/switch.vim' " true <-> false のトグル
Plug 'tpope/vim-commentary' " コメント
Plug 'tpope/vim-endwise' " end 補完
Plug 'tpope/vim-fugitive' " git コマンド
Plug 'ctrlpvim/ctrlp.vim' " fzf
Plug 'preservim/nerdtree' " ファイルツリー
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'typescriptreact'] }

" 見た目系
Plug 'itchyny/lightline.vim' " ステータスライン
Plug 'Yggdroot/indentLine' " インデント

" 言語系
Plug 'jjo/vim-cue'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'hashivim/vim-terraform'
Plug 'pantharshit00/vim-prisma'
Plug 'elzr/vim-json'

call plug#end()

" colorscheme
colorscheme molokai

" vim-terraform
let g:terraform_fmt_on_save = 1

" vim-lsp-settings
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server', 'eslint-language-server']

" vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " 隠しファイル表示

" ctrlp.vim
let g:ctrlp_custom_ignore = 'node_modules'

" vim-json
let g:vim_json_syntax_conceal = 0
