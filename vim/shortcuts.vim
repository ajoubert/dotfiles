" Remapping alt + key to be usable as shortcuts
" Leaving as an exemple, but not doing anymore as it was causing issues with
" escape
" execute "set <M-f>=\ef"

" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map <leader>h :tabp<CR>
map <leader>l :tabn<CR>

" Allow to save with sudo even after having opened the file
cnoremap w!! w !sudo tee > /dev/null %

" === START - extensions shortcuts ===

" NERDTree
noremap <C-N> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Code execution
map <leader>x :!%:p<CR>
map <leader>g :silent !tig<CR> :redraw!<CR>

" Navigation
map <leader>f :Ag!<CR>
map <leader>o :Files!<CR>
map <C-O> :GFiles!<CR>

" Markdown previewer
map <leader>p :InstantMarkdownPreview<CR>
