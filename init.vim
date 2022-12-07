" Plugins
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
Plug 'lervag/vimtex'

call plug#end()


" Basic options
syntax on
set number relativenumber
set encoding=utf-8
set scrolloff=10
set updatetime=100
set cursorline
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set nowrap
set splitbelow splitright


" Indenting
filetype indent on
filetype plugin indent on
set indentexpr
set tabstop=4
set shiftwidth=4
set expandtab ts=4 sw=4
set softtabstop


" Colors
colorscheme slate
hi CursorLine cterm=NONE ctermbg=darkblue
hi CursorLineNr cterm=NONE ctermbg=darkblue
autocmd InsertEnter * highlight CursorLine cterm=NONE
autocmd InsertEnter * highlight CursorLineNr cterm=NONE
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=darkblue
autocmd InsertLeave * highlight CursorLineNr cterm=NONE ctermbg=darkblue


" Searching
set incsearch
set ignorecase
set showmatch
set hlsearch
set smarttab


" Filetype detection
filetype on
filetype plugin indent on
autocmd BufNewFile,BufRead *.tex set filetype=tex
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.py set filetype=python
autocmd BufNewFile,BufRead Snakefile set filetype=snakefile


" MDPreview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_filetypes = ['markdown']


" NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect


" Global Binds               MODE             YOUR KEY          EXECUTED COMMAND

autocmd FileType *           inoremap         ((               ()<Space><><Esc>3hi
autocmd FileType *           inoremap         [[               []<Space><><Esc>3hi
autocmd FileType *           inoremap         {{               {}<Space><><Esc>3hi
autocmd FileType *           inoremap         ''               ''<Space><><Esc>3hi
autocmd FileType *           inoremap         ""               ""<Space><><Esc>3hi
autocmd FileType *           nnoremap         <Space><Space>    /<>/n<Enter>vldi
autocmd FileType *           inoremap         <Space><Space>    <Esc>/<>/n<Enter>vldi
autocmd FileType *           nnoremap         <c-h>             <c-w>h
autocmd FileType *           nnoremap         <c-j>             <c-w>j
autocmd FileType *           nnoremap         <c-k>             <c-w>k
autocmd FileType *           nnoremap         <c-l>             <c-w>l
autocmd FileType *           nnoremap         <c-w>             <c-w>w

""" Autodelete trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

""" Folding
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview

"""Autocomment
autocmd BufRead * nnoremap <C-_> :Commentary<Enter><Enter>
autocmd BufRead * nnoremap <C-\> :Commentary<Enter>k
autocmd FileType * set formatoptions-=cro

" Snakemake

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

augroup snakemake

"""Execute
autocmd FileType snakefile   nnoremap         <F10>             :!snakemake --cores 1

augroup END


" Python

""General
let g:python3_host_prog="/usr/bin/python3"
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set foldmethod=indent foldlevel=99

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

augroup python

autocmd FileType *           inoremap         ;'                '''<Enter><Enter>'''<Esc>ki
autocmd FileType *           inoremap         ;"                """<Enter><Enter>"""<Esc>ki

"""Execute
autocmd FileType python      nnoremap         <F10>             :w<Enter>:!python3<Space>%<Enter>

augroup END


" LaTeX

""Template autoload
autocmd BufNewFile *.tex silent exe '!cat ~/.config/nvim/templates/tex > %' | e

""Wrap line
autocmd FileType tex set wrap
autocmd FileType tex set linebreak

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

augroup tex

"""Compile
autocmd FileType tex         nnoremap         <F10>             :w<Enter>:!rm -rf aux/ out/ && pdflatex % && bibtex *.aux && pdflatex % && pdflatex %<Enter>:!mkdir aux out && mv *.log *.out *.aux *.bbl *.blg aux/ && mv *.pdf out/<Enter>

"""In-text
autocmd FileType tex         inoremap         ;i                \textit{}<Space><><Esc>T{i
autocmd FileType tex         inoremap         $                 $$<Space><><Esc>3hi
autocmd FileType tex         inoremap         ;b                \textbf{}<Space><><Esc>T{i
autocmd FileType tex         inoremap         ;r                \ref{}<Space><><Esc>T{i
autocmd FileType tex         inoremap         ;c                \cite{}<Space><><Esc>T{i
autocmd FileType tex         inoremap         ;ni               \item<Space>
autocmd FileType tex         inoremap         ;ns               ~
autocmd FileType tex         inoremap         ;sub              \textsubscript{}<Space><><Esc>T{i
autocmd FileType tex         inoremap         ;sup              \textsuperscript{}<Space><><Esc>T{i

"""Envs
autocmd FileType tex         inoremap         ;sec              <Esc>$a<Enter><Enter>\section{}<Enter><Enter><><Esc>2kf}i
autocmd FileType tex         inoremap         ;ssec             <Esc>$a<Enter><Enter>\subsection{}<Enter><Enter><><Esc>2kf}i
autocmd FileType tex         inoremap         ;sssec            <Esc>$a<Enter><Enter>\subsubsection{}<Enter><Enter><><Esc>2kf}i
autocmd FileType tex         inoremap         ;fig              <Esc>$a<Enter><Enter>\begin{figure}[]<Enter><Tab>\centering<Enter>\includegraphics[width=\columnwidth]{<>}<Enter>\caption{<>}<Enter>\label{<>}<Enter>\end{figure}<Enter><Enter><><Esc>7kf]i
autocmd FileType tex         inoremap         ;eq               <Esc>$a<Enter><Enter>\begin{equation}<Enter><Enter>\label{<>}<Enter>\end{equation}<Enter><Enter><><Esc>4ki<Tab>
autocmd FileType tex         inoremap         ;ls               <Esc>$a<Enter><Enter>\begin{itemize}<Enter><Enter>\end{itemize}<Enter><><Esc>2ki<Tab>
autocmd FileType tex         inoremap         ;nls              <Esc>$a<Enter><Enter>\begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><><Esc>2ki<Tab>
autocmd FileType tex         inoremap         ;abs              <Esc>$a<Enter><Enter>\begin{abstract}<Enter><Tab><><Enter>\end{abstract}<Enter><><Esc>2ki<Tab>

"""Env-in-env
autocmd FileType tex         inoremap         ;spl              \begin{split}<Enter><Enter>\end{split}<Esc>ki<Tab><Tab>

augroup END
