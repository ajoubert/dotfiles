" Creating empty prefix dictionary
let g:leader_map = {}
let g:space_map= {}

" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Allow to save with sudo even after having opened the file
cnoremap w!! w !sudo tee > /dev/null %

" Copy-paste to and from clipboard
let g:leader_map.t = {
  \   'name': '+text',
  \   'v': 'Paste from clipboard',
  \ }

let g:leader_map['w'] = {
      \ 'name' : '+windows/wiki'                  ,
      \ 'd' :  'delete-window'                    ,
      \ '-' :  'split-window-below'               ,
      \ '|' :  'split-window-right'               ,
      \ 'o' :  ['only', 'close-all-windows-except-current'] ,
      \ 'h' :  'window-left'                      ,
      \ 'j' :  'window-below'                     ,
      \ 'l' :  'window-right'                     ,
      \ 'k' :  'window-up'                        ,
      \ '?' :  'fzf-window'                       ,
      \ 'w' :  'open-wiki'                        ,
      \ 't' :  'open-wiki-in-tab'                 ,
      \ 'i' :  'open-diary'                       ,
      \ 's' :  'select-wiki-by-number'            ,
      \ }

noremap <leader>wd :bd<CR>
noremap <leader>w- :split<CR>
noremap <leader>w\| :vsplit<CR>
noremap <leader>wo :on<CR>
noremap <leader>w? :Windows<CR>
noremap <leader>wh <C-W>h
noremap <leader>wj <C-W>j
noremap <leader>wk <C-W>k
noremap <leader>wl <C-W>l

let g:leader_map[' '] = {
      \ 'name': '+tab'  ,
      \ '1': 'tab-1'    ,
      \ '2': 'tab-2'    ,
      \ '3': 'tab-3'    ,
      \ '4': 'tab-4'    ,
      \ '5': 'tab-5'    ,
      \ '6': 'tab-6'    ,
      \ '7': 'tab-7'    ,
      \ '8': 'tab-8'    ,
      \ '9': 'tab-9'    ,
      \ 'c': 'close-current-tab',
      \ }
map <leader><space>1 :tabn 1<CR>
map <leader><space>2 :tabn 2<CR>
map <leader><space>3 :tabn 3<CR>
map <leader><space>4 :tabn 4<CR>
map <leader><space>5 :tabn 5<CR>
map <leader><space>6 :tabn 6<CR>
map <leader><space>7 :tabn 7<CR>
map <leader><space>8 :tabn 8<CR>
map <leader><space>9 :tabn 9<CR>
map <leader><space>c :tabclose<CR>


map <leader>tv :r !xclip -o -sel -c<CR>
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

nnoremap <CR> :noh<CR><CR>
