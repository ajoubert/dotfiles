" Help
let g:leader_map['?'] = 'show-keybindings'
noremap <leader>? :help index<CR>

" Buffers
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
      \ 'l' :  'list-buffers'    ,
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
noremap <leader>bl :Buffers<CR>

" Git - fugitive
let g:leader_map.g = {
  \   'name': '+git/version-control',
  \   'b': 'blame',
  \   'c': 'log-for-current-buffer',
  \   'd': 'diff',
  \   'g': 'toggle-gutter',
  \   'l': 'log',
  \   't': 'tig'
  \ }

noremap <leader>gb :Git blame<CR>
noremap <leader>gc :BCommits<CR>
noremap <leader>gd :Git diff<CR>
noremap <leader>gl :Commits<CR>
noremap <leader>gg :GitGutterToggle<CR>
noremap <leader>gt :silent !tig<CR> :redraw!<CR>

" NERDTree
let g:leader_map.s = 'Toggle sidebar'
noremap <leader>s :NERDTreeToggle<CR>

" Code
let g:leader_map.c = {
  \   'name': '+code',
  \   't': 'Toggle comment',
  \   'x': 'Execute'
  \ }
noremap <leader>cx :!%:p<CR>
map <leader>ct <Plug>NERDCommenterToggle

" Navigation
let g:leader_map.n = {
  \   'name': '+navigate',
  \   'f': 'Search...',
  \   'g': 'Open versioned file...',
  \   'o': 'Open file...',
  \ }
nmap <Leader>nf <Plug>RgRawSearch
vmap <Leader>nf <Plug>RgRawVisualSelection<CR>

" Only use GFiles if we are currently in a git repo
nnoremap <leader>ng :GFiles --cached --others --exclude-standard<CR>
" Automatically filter when using visual mode
vnoremap <leader>ng "ay:call agriculture#trim_and_escape_register_a()<CR>:GFiles '**<C-r>a**'<CR>
nnoremap <leader>no :Files<CR>

" Automatically show suggestions after a delay
nnoremap <silent> <leader> :WhichKey '\'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '\'<CR>
nnoremap <silent> <Space> :WhichKey '<Space>'<CR>
vnoremap <silent> <Space> :WhichKeyVisual '<Space>'<CR>

call which_key#register('\', "g:leader_map")
call which_key#register(' ', "g:space_map")
