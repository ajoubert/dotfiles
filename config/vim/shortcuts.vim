" Force saving file despite missing root permission "
cnoremap w!! w !sudo tee > /dev/null %
noremap <C-N> :NERDTreeToggle<CR>
map <C-P> :Ag<CR>
map <C-O> :Files<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
map <F10> :tabp<CR>
map <F11> :tabn<CR>
