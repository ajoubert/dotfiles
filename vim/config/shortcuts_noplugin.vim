" Creating empty prefix dictionary
let g:leader_map = {}
let g:space_map= {}

" === Help ===
let g:leader_map['h'] = {
      \ 'name' : '+help'          ,
      \ 'k' : 'show-keybindings'  ,
      \ 'm' : 'show-map'          ,
      \ 'R' : 'refresh-vimrc'     ,
      \ }
noremap <leader>hk :help index<CR>
noremap <leader>hm :map<CR>
noremap <leader>hR :source ~/.vim/vimrc<CR>

" === Buffers ===
let g:leader_map['b'] = {
      \ 'name' : '+buffer'       ,
      \ '1' :  'buffer-1'        ,
      \ '2' :  'buffer-2'        ,
      \ '3' :  'buffer-3'        ,
      \ '4' :  'buffer-4'        ,
      \ '5' :  'buffer-5'        ,
      \ '6' :  'buffer-6'        ,
      \ '7' :  'buffer-7'        ,
      \ '8' :  'buffer-8'        ,
      \ '9' :  'buffer-9'        ,
      \ 'd' :  'delete-buffer'   ,
      \ 'k' :  'kill-buffer'     ,
      \ }
noremap <leader>b1 :b1<CR>
noremap <leader>b2 :b2<CR>
noremap <leader>b3 :b3<CR>
noremap <leader>b4 :b4<CR>
noremap <leader>b5 :b5<CR>
noremap <leader>b6 :b6<CR>
noremap <leader>b7 :b7<CR>
noremap <leader>b8 :b8<CR>
noremap <leader>b9 :b9<CR>
noremap <leader>bd :bd<CR>
noremap <leader>bk :bw<CR>

" === Allow to save with sudo even after having opened the file ===
cnoremap w!! w !sudo tee > /dev/null %


" === Windows ===
let g:leader_map['w'] = {
      \ 'name' : '+windows'                       ,
      \ 'd' :  'delete-window'                    ,
      \ '-' :  'split-window-below'               ,
      \ '|' :  'split-window-right'               ,
      \ 'o' :  ['only', 'close-all-windows-except-current'] ,
      \ 'h' :  'window-left'                      ,
      \ 'j' :  'window-below'                     ,
      \ 'l' :  'window-right'                     ,
      \ 'k' :  'window-up'                        ,
      \ }

noremap <leader>wd :bd<CR>
noremap <leader>w- :split<CR>
noremap <leader>w\| :vsplit<CR>
noremap <leader>wo :on<CR>
noremap <leader>wh <C-W>h
noremap <leader>wj <C-W>j
noremap <leader>wk <C-W>k
noremap <leader>wl <C-W>l

" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" === Tabs ===
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
      \ 'n': 'new-tab',
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
map <leader><space>n :tabnew<CR>

" Stop highlighting search
nnoremap <CR> :noh<CR><CR>
