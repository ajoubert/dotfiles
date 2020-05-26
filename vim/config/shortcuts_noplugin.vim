" First, let's check if we're in a git repo. This will be used later for
" some shortcuts
let isGitRepo = 0 
silent! !git rev-parse --is-inside-work-tree >/dev/null &>/dev/null
if v:shell_error == 0
  let isGitRepo = 1 
endif

" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Allow to save with sudo even after having opened the file
cnoremap w!! w !sudo tee > /dev/null %

" Copy-paste to and from clipboard
map <leader>v :r !xclip -o -sel -c<CR>
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

nnoremap <CR> :noh<CR><CR>
