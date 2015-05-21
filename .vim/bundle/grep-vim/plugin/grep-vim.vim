" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Mappings for word under cursor
nnoremap K :exe "grep! -nR " . shellescape(expand("<cword>"))<CR>:cw<CR>
nnoremap <leader>K :exe "grep! -nR '[function] " . shellescape(expand("<cword>")) . "'"<CR>:cw<CR>
