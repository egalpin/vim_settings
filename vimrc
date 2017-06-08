set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set nobackup
set undofile
set backspace=2 "
set number
set numberwidth=6
set nocompatible
set title
set ruler
set visualbell
set noswapfile
set nosmartindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set noexpandtab
set smartcase
set ignorecase
set incsearch
set hlsearch
set laststatus=2
set encoding=utf-8
set cursorline
set nowrap
set nocul
set pastetoggle=<F2>
set sessionoptions-=options  " Don't save options
set viewoptions=cursor,folds,slash,unix
set ff=unix
set ffs=unix
set autoread
set splitright
set splitbelow
set mousehide
set showcmd

" Fix neovim ctrl+h <BS> mapping
if has('nvim')
    nnoremap <BS> <C-w>h
endif

let g:Powerline_symbols = 'fancy'
let mapleader=";"
let $PATH = '/usr/local/bin:'.$PATH

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

fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! _RestoreSess()
    if filereadable(getcwd() . '/.session.vim')
        execute 'so ' . getcwd() . '/.session.vim'
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'sbuffer ' . l
                endif
            endfor
        endif
    endif
endfunction

function! RestoreSess()
    if argc() == 0
        call _RestoreSess()
    end
endfunction

function! LazyP()
  let g:ctrlp_default_input = expand('<cword>')
  CtrlP
  let g:ctrlp_default_input = ''
endfunction
command! LazyP call LazyP()

" MAPPINGS
" Normal ------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <silent> <leader>e :NERDTree<cr>
nnoremap <leader>n :nohlsearch<cr>
nnoremap <leader>5 :Neomake<CR>:lwindow<CR>:echom 'Neomake lint complete.'<CR>
nnoremap <silent> <leader>t :TagbarToggle<cr>
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
nnoremap <silent> <leader>v :source $MYVIMRC<cr>:nohlsearch<cr>
nnoremap <leader>r :bufdo e!<cr>
nnoremap QQ :QuitTab<cr>
nnoremap WQ :WriteQuitTab<cr>
nnoremap gb :bn<cr>
nnoremap GB :bp<cr>
nnoremap <leader>d :Bdelete<cr>
nnoremap K mJ:TernDef<CR>
nnoremap <leader># :b#<CR>
nnoremap <bs> :b#<CR>
nnoremap <leader>ff :setlocal filetype=
"nnoremap <C-s> :noautocmd write<CR>
" Remove unwanted/trailing whitespace
"nnoremap <silent><F3> :%s/\s\+$//e<CR>
nnoremap <Tab> >>
nnoremap <S-Tab> <<

" Gundo
nnoremap <leader>g :GundoToggle<CR>
let g:gundo_width=35

" ToggleQuickfixList
nnoremap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
nnoremap <script> <silent> <leader>l :call ToggleLocationList()<CR>

" CtrlP search for filename under cursor
"nnoremap <C-S-w> :LazyP<CR>

" Cscope Mappings
" a: Interactive matching
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
"nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
let g:cscope_silent = 1


let g:toggle_list_copen_command="botright cwindow"

" EasyMotion mappings
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
nmap <leader>s <Plug>(easymotion-s2)
nmap <leader>w <Plug>(easymotion-w)
nmap <leader>b <Plug>(easymotion-b)
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First Keyword
hi link EasyMotionTarget2Second Keyword

" Insert ------------------------------------------------
inoremap jk <esc>
inoremap jj <esc>
" Capitalize word
inoremap <c-u> <esc>viwUea
" Fully un-capitalize word
inoremap <c-l> <esc>viwuea
inoremap <c-d> <esc>^Di
" Toggle line wrap. Useful for HTML/long strings
inoremap <c-w> <esc>:set wrap!<cr>a

inoreabbrev adn and
inoreabbrev ehco echo

" Abbreviate SP doctrine calls
"inoreabbrev usp \Database::updateStoredProcedure('');
"inoreabbrev dsp $this->throwIrreversibleMigrationException('Cannot reverse Stored Procedure updates.');

" Visual ------------------------------------------------
" Find / replace within selected area
vnoremap <c-h> :s/
 " Join lines with character
vnoremap <c-j> <esc>:JoinLines
"vnoremap <leader>g :<c-u>!grep -rl '<,'> ./*<cr>
"vnoremap <silent> <c-j> :-1s/$/,/<cr>:%j<cr>
vnoremap <C-S-c> "+y

filetype plugin indent on
filetype on

"let g:tagbar_ctags_bin='/usr/local/bin/ctags'
"let g:tagbar_width=55
let g:tagbar_autofocus=0
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/local/bin/jsctags'
\}

let g:PreserveNoEOL = 1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<C-x><C-o>"

" Jedi
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#popup_select_first = 1
let g:jedi#popup_on_dot = 1
let g:jedi#show_call_signatures = 1
let g:jedi#usages_command = "<leader>u"

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Enable powerline fonts for better look
let g:airline_powerline_fonts = 1

" Disable JSHint highlighting
"let g:JSHintHighlightErrorLine = 0
" Check for JS errors only on write
"let g:JSHintUpdateWriteOnly = 1

" Git Gutter
" Enable git-gutter to always be present, even with no changes
"let g:gitgutter_sign_column_always = 1
let g:gitgutter_eager = 0
let g:gitgutter_realtime= 0

" Match lines of 80 characters in length
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
autocmd BufRead,VimEnter,WinEnter *.py nested match OverLength /\%80v.\+/

" Disable cursorline when entering insert mode
"autocmd InsertEnter * set nocul
" Enable cursorline when leaving insert mode
"autocmd InsertLeave * set cul

" Vdebug
let g:vdebug_keymap = {
            \    "run" : "<F5>",
            \    "run_to_cursor" : "<Down>",
            \    "step_over" : "<Right>",
            \    "step_into" : "<Left>",
            \    "step_out" : "<Up>",
            \    "close" : "<F6>",
            \    "detach" : "<F7>",
            \    "set_breakpoint" : "<Leader>p",
            \    "get_context" : "<F10>",
            \    "eval_under_cursor" : "<F12>",
            \    "eval_visual" : "<Leader>e",
            \}

let g:vdebug_options = {
            \    'ide_key' : 'PHPSTORM',
            \    'break_on_open' : 1,
            \    'watch_window_style': 'compact',
            \    'port' : 9000,
            \}
            " Add the below path_maps variable (with paths) to vdebug options
            " as needed
            "\    'path_maps': {'': ''},

" phpctags
let g:tagbar_phpctags_bin="/usr/local/bin/phpctags/bin/phpctags"

" CtrlP
let g:ctrlp_working_path_mode=''
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=100
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_reuse_window = 1
" Open multiple files as new buffers
let g:ctrlp_open_multiple_files = 'i'
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore .DS_Store
          \ --ignore "**/*.pyc"
          \ --ignore composer
          \ --ignore node_modules
          \ --ignore "*.un~"
          \ -g ""'

    " ag is fast enough that CtrlP doesn't need to cache (but why not)
    let g:ctrlp_use_caching = 1
endif

" Syntastic
"let g:syntastic_mode_map = { 'mode': 'passive' }
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_javascript_checkers = ['eslint']
"nnoremap <script> <silent> <leader>R :SyntasticReset<CR>
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" NERDTree
let NERDTreeShowHidden=1

" PHP Completion
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
set completeopt=menuone

" omnifuncs
"augroup omnifuncs
  "autocmd!
  "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1

  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" UltiSnips
" Make it so that <ENTER> will expand a snippet if in YouCompleteMe context.
" See @kbenzie's comment -  https://github.com/Valloric/YouCompleteMe/issues/420
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
" Insert snippets via supertab
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" Startup
execute pathogen#infect()
call pathogen#helptags()
highlight ColorColumn ctermbg=8
highlight SignColumn ctermbg=DarkGrey
autocmd BufRead,VimEnter,WinEnter * nested :set colorcolumn=
" Create visual reminder for PEP8 standards in .py files
autocmd BufRead,VimEnter,WinEnter *.py nested :set colorcolumn=80
" Disable cursorline in tagbar tab (for improved scrolling)
autocmd FileType tagbar setlocal nocursorline
" Save and restore sessions automatically
autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()
autocmd BufNewFile,BufRead *.hbs set filetype=javascript
if has('nvim')
    autocmd BufWritePre *.js Neomake
    " Open quickfix when saving file
    autocmd BufWritePost :lwindow
endif

filetype plugin on
syntax on
set guifont=Inconsolata-g\ for\ Powerline:h12
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

if has('gui_running')
    set background=light
    colorscheme solarized
else
    set background=light
    " solarized options
    colorscheme solarized
    "set background=dark
    "colorscheme solarized
    "set t_Co=256
    "set term=xterm-256color
    "set termencoding=utf-8
    "colorscheme hybrid
endif

" Deoplete
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1

" Minimap
let g:minimap_toggle='<leader>mm'

" Mucomplete
let g:mucomplete#enable_auto_at_startup = 1

" React/JSX
let g:jsx_ext_required = 0

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" JSHint.vim
let JSHintUpdateWriteOnly=1

" clang_complete
let g:clang_library_path='/usr/local/Cellar/llvm/3.9.0/lib/'

" vim-autoformat
noremap <F3> :Autoformat<CR>
let g:formatdef_custom_js_formatter = '"js-beautify --good-stuff -j"'
let g:formatters_js = ['custom_js_formatter']

" Completor
let g:completor_python_binary = '/usr/local/bin/python3'
let g:completor_node_binary = '/usr/local/bin/node'

" Ale lint engine
let g:ale_linters = {
\   'javascript': ['jshint'],
\}
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_args = '-m flake8'

" PyMode
let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_lint_message = 0
let g:pymode_rope = 0
