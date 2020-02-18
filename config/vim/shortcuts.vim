" Remapping alt + key to be usable as shortcuts
execute "set <M-f>=\ef"
execute "set <M-o>=\eo"
execute "set <M-h>=\eh"
execute "set <M-l>=\el"

" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
nnoremap <M-h> :tabp<CR>
nnoremap <M-l> :tabn<CR>

" Allow to save with sudo even after having opened the file
cnoremap w!! w !sudo tee > /dev/null %

" === START - extensions shortcuts ===

" NERDTree
noremap <C-N> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Navigation
nnoremap <M-f> :Ag!<CR>
map <M-o> :Files!<CR>
map <C-O> :GFiles!<CR>

" Markdown previewer
map <leader>p :InstantMarkdownPreview<CR>
