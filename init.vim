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
syntax on
set number
set tabstop=4
set shiftwidth=4
set expandtab ts=4 sw=4 ai
set encoding=utf-8
set scrolloff=10
set updatetime=100
set cursorline
set nowrap
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"


"Colors
colorscheme slate
hi CursorLine cterm=NONE ctermbg=darkblue
hi CursorLineNr cterm=NONE ctermbg=darkblue
autocmd InsertEnter * highlight CursorLine cterm=NONE 
autocmd InsertEnter * highlight CursorLineNr cterm=NONE
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=darkblue
autocmd InsertLeave * highlight CursorLineNr cterm=NONE ctermbg=darkblue


"Searching
set incsearch
set ignorecase
set showmatch
set hlsearch
set smarttab


"Filetype detection
filetype on
filetype plugin indent on
au BufNewFile,BufRead *.tex set filetype=tex
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.py set filetype=python
au BufNewFile,BufRead Snakefile set filetype=snakefile


"MDPreview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_filetypes = ['markdown']


"NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


"SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect


"Snakemake

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

"""Execute
autocmd FileType snakefile   nnoremap         <Enter>           :!snakemake --cores 1


"Python

""General
let g:python3_host_prog="/usr/bin/python3"
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python set foldmethod=indent foldlevel=99

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

"""Execute
autocmd FileType python      nnoremap         <Enter>           :w<Enter>:!python3<Space>%<Enter>


"LaTeX

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

"""Jump to <>
autocmd FileType tex         inoremap         <Tab><Tab>        <Esc>/<>/n<Enter>vldi<Esc>a
autocmd FileType tex         nnoremap         <Tab><Tab>        /<>/n<Enter>vldi<Esc>a

"""In-text
autocmd FileType tex         inoremap         ;i                \textit{}<Space><Space><><Esc>T{i<Esc>a
autocmd FileType tex         inoremap         ;b                \textbf{}<Space><Space><><Esc>T{i<Esc>a
autocmd FileType tex         inoremap         ;r                \ref{}<Space><Space><><Esc>T{i<Esc>a
autocmd FileType tex         inoremap         ;c                \cite{}<Space><Space><><Esc>T{i<Esc>a
autocmd FileType tex         inoremap         ;ni               \item<Space><Esc>a
autocmd FileType tex         inoremap         ;<Space>          ~<Esc>a

"""Envs
autocmd FileType tex         inoremap         ;sec              <Enter><Enter>\section{}<Enter><Enter><><Esc>2kf}i<Esc>a
autocmd FileType tex         inoremap         ;ssec             <Enter><Enter>\subsection{}<Enter><Enter><><Esc>2kf}i<Esc>a
autocmd FileType tex         inoremap         ;sssec            <Enter><Enter>\subsubsection{}<Enter><Enter><><Esc>2kf}i<Esc>a
autocmd FileType tex         inoremap         ;fig              <Enter><Enter>\begin{figure}[]<Enter><Tab>\centering<Enter>\includegraphics[width=\columnwidth]{<>}<Enter>\caption{<>}<Enter>\label{<>}<Enter>\end{figure}<Enter><Enter><><Esc>7kf]i<Esc>a
autocmd FileType tex         inoremap         ;eq               <Enter><Enter>\begin{equation}<Enter><Enter>\label{<>}<Enter>\end{equation}<Enter><Enter><><Esc>4ki<Tab><Esc>a
autocmd FileType tex         inoremap         ;ls               <Enter><Enter>\begin{itemize}<Enter><Enter>\end{itemize}<Enter><><Esc>2ki<Tab><Esc>a
autocmd FileType tex         inoremap         ;nls              <Enter><Enter>\begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><><Esc>2ki<Tab><Esc>a

"""Env-in-env
autocmd FileType tex         inoremap         ;spl              \begin{split}<Enter><Enter>\end{split}<Esc>ki<Tab><Tab><Esc>a
