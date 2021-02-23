" Creating empty prefix dictionary
let g:which_key_map = {}

" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Allow to save with sudo even after having opened the file
cnoremap w!! w !sudo tee > /dev/null %

" Copy-paste to and from clipboard
let g:which_key_map.t = {
  \   'name': '+text',
  \   'v': 'Paste from clipboard',
  \ }

map <leader>tv :r !xclip -o -sel -c<CR>
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

nnoremap <CR> :noh<CR><CR>
