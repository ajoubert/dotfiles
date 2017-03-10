execute pathogen#infect()
syntax on
set tabstop=4 number softtabstop=0 expandtab shiftwidth=4 smarttab
" Force saving file despite missing root permission "
cnoremap w!! w !sudo tee > /dev/null %
filetype plugin indent on
map <C-n> :NERDTreeToggle<CR>
map <F10> :tabp<CR>
map <F11> :tabn<CR>
