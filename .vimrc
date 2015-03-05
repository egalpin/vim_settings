syntax on
let g:Powerline_symbols = 'fancy'
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

colors 256-grayvim

let mapleader=";"

set backspace=2 "
set number
set numberwidth=6
set nocompatible
set title
set ruler
set visualbell
set noswapfile
set nosmartindent
set tabstop=4
set shiftwidth=4
set expandtab
set smartcase
set ignorecase
set incsearch
set hlsearch
set laststatus=2
set encoding=utf-8
set cursorline
set nowrap

" Commands
command! QuitTab call s:QuitTab()
command! WriteQuitTab call s:WriteQuitTab()

" Functions
function! s:QuitTab()
    try
        tabclose
    catch /E784/ "Cant close tab error
        qall!
    endtry
endfunction
function! s:WriteQuitTab()
    try
        write
        tabclose
    catch /E784/
        qall
    endtry
endfunction

" Mappings
nnoremap j gj
nnoremap k gk
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>q :nohlsearch<cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>j :TagbarOpen<space>j<cr>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <space> viw
nnoremap <c-space> viWy
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <c-w> :set wrap!<cr>
nnoremap <leader>r :set relativenumber!<cr>
nnoremap <leader>n :set number!<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:nohlsearch<cr>
nnoremap <leader>git :bufdo e!<cr>
nnoremap <leader>wc :w<cr>:tabclose<cr>
nnoremap <leader>qc :tabclose!<cr>
nnoremap QQ :QuitTab<cr>
nnoremap WQ :WriteQuitTab<cr>
nnoremap <leader>c :set colorcolumn=<cr>
nnoremap <C-p> :CtrlP<cr>
nnoremap gb :bn<cr>
nnoremap GB :bp<cr>
nnoremap <leader>bd :Bdelete<cr>

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap jk <esc>
inoremap <c-u> <esc>viwUwa
inoremap <c-l> <esc>viwuwa
inoremap <c-d> <esc>^Di
inoremap <c-t><c-i> <esc>bviwdi<</<esc>pa><esc>Bpa><esc>i
inoremap <c-t><c-a> <esc>bviwdi<</<esc>pa><esc>Bpa>
inoremap jl <esc>la
inoremap jh <esc>i
inoremap <c-w> <esc>:set wrap!<cr>a
inoremap <C-b> <esc>vbda
iabbrev adn and
iabbrev ehco echo

vnoremap <c-h> :s/

filetype plugin indent on
filetype on

"let g:tagbar_ctags_bin='/usr/local/bin/ctags'
"let g:tagbar_width=55
let g:tagbar_autofocus=0

let g:PreserveNoEOL = 1

let g:SuperTabDefaultCompletionType = "<C-n>"

" Enable the list of buffers
 let g:airline#extensions#tabline#enabled = 1
" Show just the filename
 let g:airline#extensions#tabline#fnamemod = ':t'
" Enable powerline fonts for better look
let g:airline_powerline_fonts = 1 

" Match lines of 80 characters in length
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufRead,VimEnter,WinEnter *.py nested match OverLength /\%80v.\+/

" Disable cursorline when entering insert mode
autocmd InsertEnter * set nocul
" Enable cursorline when leaving insert mode
autocmd InsertLeave * set cul

" Startup
execute pathogen#infect()
autocmd BufRead,VimEnter,WinEnter * :syntax on
highlight ColorColumn ctermbg=8
autocmd BufRead,VimEnter,WinEnter * nested :set colorcolumn=
autocmd BufRead,VimEnter,WinEnter *.py nested :set colorcolumn=80
autocmd FileType tagbar setlocal nocursorline
filetype plugin on
