" Force saving file despite missing root permission "
cnoremap w!! w !sudo tee > /dev/null %
map <C-n> :NERDTreeToggle<CR>
map <F10> :tabp<CR>
map <F11> :tabn<CR>
