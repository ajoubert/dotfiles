" Force saving file despite missing root permission "
cnoremap w!! w !sudo tee > /dev/null %
noremap <C-N> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>
map <C-P> :Ag!<CR>
map <leader>o :Files!<CR>
map <C-O> :GFiles!<CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map <F10> :tabp<CR>
map <F11> :tabn<CR>
