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
Plug 'lervag/vimtex'
Plug 'airblade/vim-rooter'

call plug#end()


" Basic options
syntax on
set nowrap
set number relativenumber
set encoding=utf-8
set scrolloff=10
set updatetime=100
set cursorline
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set splitbelow splitright


" Indenting
filetype indent on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab ts=4 sw=4
set smartindent
set softtabstop


" Colors
colorscheme slate
hi CursorLine cterm=NONE ctermbg=darkblue
hi CursorLineNr cterm=NONE ctermbg=darkblue
autocmd InsertEnter * highlight CursorLine cterm=NONE
autocmd InsertEnter * highlight CursorLineNr cterm=NONE
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=darkblue
autocmd InsertLeave * highlight CursorLineNr cterm=NONE ctermbg=darkblue


" Searching options
set incsearch
set ignorecase
set showmatch
set hlsearch
set smarttab
let g:rooter_manual_only = 1


" Filetype detection
filetype on
filetype plugin indent on
autocmd BufNewFile,BufRead *.tex set filetype=tex
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.py set filetype=python
autocmd BufNewFile,BufRead Snakefile set filetype=snakefile


" NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect


" Global

""Binds                      MODE             YOUR KEY          EXECUTED COMMAND

let mapleader = ";"

autocmd FileType *           inoremap         ((                () <><Esc>3hi
autocmd FileType *           inoremap         [[                [] <><Esc>3hi
autocmd FileType *           inoremap         {{                {} <><Esc>3hi
autocmd FileType *           inoremap         '                 ''<Esc>i
autocmd FileType *           inoremap         "                 ""<Esc>i
autocmd FileType *           nnoremap         <leader><CR>      /<>/n<CR>vldi
autocmd FileType *           inoremap         <leader><CR>      <Esc>/<>/n<CR>vldi
autocmd FileType *           nnoremap         <c-h>             <c-w>h
autocmd FileType *           nnoremap         <c-j>             <c-w>j
autocmd FileType *           nnoremap         <c-k>             <c-w>k
autocmd FileType *           nnoremap         <c-l>             <c-w>l
autocmd FileType *           nnoremap         <c-w>             <c-w>w
autocmd FileType *           nnoremap         <s-e>             $a
autocmd FileType *           nnoremap         <c-f>             :Ag<CR>
autocmd FileType *           nnoremap         <c-g>             :Rooter<CR>:Rg<CR>
autocmd FileType *           nnoremap         <s-f>             :Files<CR>
autocmd FileType *           xnoremap         <s-j>             }
autocmd FileType *           xnoremap         <s-k>             {
autocmd FileType *           nnoremap         <s-j>             }
autocmd FileType *           nnoremap         <s-k>             {

"" Autodelete trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e
}
"" Folding
autocmd BufWritePre * mkview
autocmd VimEnter * silent loadview

"" Autocomment
autocmd BufRead *           nnoremap          <C-_>             :Commentary<CR>j
autocmd BufRead *           nnoremap          <C-\>             :Commentary<CR>k
autocmd FileType * set formatoptions-=cro

"" Go back to cwd upon leaving Rg
autocmd VimEnter * let iwd = getcwd()
autocmd BufLeave * exe "cd" iwd


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

autocmd FileType *           inoremap         ;'                '''<CR><CR>'''<Esc>ki
autocmd FileType *           inoremap         ;"                """<CR><CR>"""<Esc>ki

"""Execute
autocmd FileType python      nnoremap         <F10>             :w<CR>:!python3 %<CR>

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
autocmd FileType tex         nnoremap         <F10>             :w<CR>:!rm -rf out/<CR>:!latexmk -pdf -time % && latexmk -c<CR>:!mkdir out && mv *.pdf *.bbl out/<CR>

"""In-text
autocmd FileType tex         inoremap         ;i                \textit{} <><Esc>T{i
autocmd FileType tex         inoremap         $                 $$ <><Esc>3hi
autocmd FileType tex         inoremap         ;b                \textbf{} <><Esc>T{i
autocmd FileType tex         inoremap         ;r                \ref{} <><Esc>T{i
autocmd FileType tex         inoremap         ;c                \cite{} <><Esc>T{i
autocmd FileType tex         inoremap         ;ni               \item
autocmd FileType tex         inoremap         ;ns               ~
autocmd FileType tex         inoremap         ;sub              \textsubscript{} <><Esc>T{i
autocmd FileType tex         inoremap         ;sup              \textsuperscript{} <><Esc>T{i

"""Envs
autocmd FileType tex         inoremap         ;sec              <Esc>$a<CR>\section{}<CR><><Esc>kf}i
autocmd FileType tex         inoremap         ;ssec             <Esc>$a<CR>\subsection{}<CR><><Esc>kf}i
autocmd FileType tex         inoremap         ;sssec            <Esc>$a<CR>\subsubsection{}<CR><><Esc>kf}i
autocmd FileType tex         inoremap         ;fig              <Esc>$a<CR>\begin{figure}[]<CR><Tab>\cCRing<CR>\includegraphics[width=\columnwidth]{<>}<CR>\caption{<>}<CR>\label{<>}<CR>\end{figure}<CR><CR><><Esc>7kf]i
autocmd FileType tex         inoremap         ;eq               <Esc>$a<CR>\begin{equation}<CR><CR>\label{<>}<CR>\end{equation}<CR><CR><><Esc>4ki<Tab>
autocmd FileType tex         inoremap         ;ls               <Esc>$a<CR>\begin{itemize}<CR><CR>\end{itemize}<CR><><Esc>2ki<Tab>
autocmd FileType tex         inoremap         ;nls              <Esc>$a<CR>\begin{enumerate}<CR><CR>\end{enumerate}<CR><><Esc>2ki<Tab>
autocmd FileType tex         inoremap         ;abs              <Esc>$a<CR>\begin{abstract}<CR><Tab><><CR>\end{abstract}<CR><><Esc>2ki<Tab>

"""Env-in-env
autocmd FileType tex         inoremap         ;spl              \begin{split}<CR><CR>\end{split}<Esc>ki<Tab><Tab>

augroup END
