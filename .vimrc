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
command! -nargs=* JoinLines call JoinLines( '<args>' )

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

" Join highlighted lines with a given string
func! JoinLines(joinStr)
    execute "normal! gv\:-1s/$/".a:joinStr." /\<cr>\:\%j\<cr>"
endfunc

" MAPPINGS
" Normal ------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <leader>q :nohlsearch<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
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
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>:nohlsearch<cr>
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
nnoremap <silent> <leader>cc :call ToggleQuickfixList()<CR>

" Insert ------------------------------------------------
inoremap jk <esc>
" Capitalize word
inoremap <c-u> <esc>viwUwa
" Fully un-capitalize word
inoremap <c-l> <esc>viwuwa
inoremap <c-d> <esc>^Di
" Create open / close tags with current word
inoremap <c-t><c-i> <esc>bviwdi<</<esc>pa><esc>Bpa><esc>i
" Create open / close tags with current word, inserting after tag
inoremap <c-t><c-a> <esc>bviwdi<</<esc>pa><esc>Bpa>
" Toggle line wrap. Useful for HTML/long strings
inoremap <c-w> <esc>:set wrap!<cr>a
" Delete previous/current word and continue in insert mode 
inoremap <c-b> <esc>vbda
iabbrev adn and
iabbrev ehco echo

" Visual ------------------------------------------------
" Find / replace within selected area
vnoremap <c-h> :s/
 " Join lines with character
vnoremap <c-j> <esc>:JoinLines 
"vnoremap <silent> <c-j> :-1s/$/,/<cr>:%j<cr>

filetype plugin indent on
filetype on

"let g:tagbar_ctags_bin='/usr/local/bin/ctags'
"let g:tagbar_width=55
let g:tagbar_autofocus=0

let g:PreserveNoEOL = 1

let g:SuperTabDefaultCompletionType = "<C-n>"

let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#popup_select_first = 1
let g:jedi#popup_on_dot = 0
let g:jedi#show_function_definition = 0

" Enable the list of buffers
 let g:airline#extensions#tabline#enabled = 1
" Show just the filename
 let g:airline#extensions#tabline#fnamemod = ':t'
" Enable powerline fonts for better look
let g:airline_powerline_fonts = 1 

" Disable JSHint highlighting
let g:JSHintHighlightErrorLine = 0
" Check for JS errors only on write
let g:JSHintUpdateWriteOnly = 1

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
" Create visual reminder for PEP8 standards in .py files
autocmd BufRead,VimEnter,WinEnter *.py nested :set colorcolumn=80
" Disable cursorline in tagbar tab (for improved scrolling)
autocmd FileType tagbar setlocal nocursorline
" Open quickfix when saving JS file
autocmd BufWritePre *.js :botright cwindow
filetype plugin on
