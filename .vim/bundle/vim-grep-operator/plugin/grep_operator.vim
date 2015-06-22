" File:        grep-operator.vim
" Maintainer:  Yann Thomas-Gérard <inside at gmail dot com>
" Version:     0.0.1
" License:     This file is placed in the public domain.

nnoremap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vnoremap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nnoremap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
vnoremap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt

" Mappings for the current directory grep {{{
nnoremap
      \ <script>
      \ <Plug>GrepOperatorOnCurrentDirectory
      \ <SID>GrepOperatorOnCurrentDirectory
nnoremap
      \ <silent>
      \ <SID>GrepOperatorOnCurrentDirectory
      \ :set operatorfunc=grep_operator#GrepOperatorOnCurrentDirectory<cr>g@
xnoremap
      \ <script>
      \ <Plug>GrepOperatorOnCurrentDirectory
      \ <SID>GrepOperatorOnCurrentDirectory
xnoremap
      \ <silent>
      \ <SID>GrepOperatorOnCurrentDirectory
      \ :<c-u>call grep_operator#GrepOperatorOnCurrentDirectory(visualmode())<cr>
" }}}

" Mappings with filenames prompt {{{
nnoremap
      \ <script>
      \ <Plug>GrepOperatorWithFilenamePrompt
      \ <SID>GrepOperatorWithFilenamePrompt
nnoremap
      \ <silent>
      \ <SID>GrepOperatorWithFilenamePrompt
      \ :set operatorfunc=grep_operator#GrepOperatorWithFilenamePrompt<cr>g@
xnoremap
      \ <script>
      \ <Plug>GrepOperatorWithFilenamePrompt
      \ <SID>GrepOperatorWithFilenamePrompt
xnoremap
      \ <silent>
      \ <SID>GrepOperatorWithFilenamePrompt
      \ :<c-u>call grep_operator#GrepOperatorWithFilenamePrompt(visualmode())<cr>
" }}}
