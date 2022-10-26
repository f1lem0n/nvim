"Plugins
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'dense-analysis/ale'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ervandew/supertab'
Plug 'raivivek/vim-snakemake'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()


"Basic options
filetype plugin indent on
set number
set tabstop=4
set shiftwidth=4
set expandtab ts=4 sw=4 ai
set encoding=utf-8
set scrolloff=10
set incsearch
set ignorecase
set showmatch
set hlsearch
set updatetime=100
set completeopt=noinsert,menuone,noselect
set cursorline
let g:python3_host_prog="/usr/bin/python3"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0
let g:mkdp_filetypes = ['markdown']


"Autocmds
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd InsertEnter * highlight CursorLine cterm=NONE 
autocmd InsertEnter * highlight CursorLineNr cterm=NONE
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=darkblue
autocmd InsertLeave * highlight CursorLineNr cterm=NONE ctermbg=darkblue
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
                       \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufEnter * call ncm2#enable_for_buffer()


""Tweaks
colorscheme slate
hi CursorLine cterm=NONE ctermbg=darkblue
hi CursorLineNr cterm=NONE ctermbg=darkblue
