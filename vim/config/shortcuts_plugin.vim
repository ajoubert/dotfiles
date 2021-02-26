" Buffers
call extend(leader_map['b'], {
  \ 'l': 'list-buffers',
  \ })
noremap <leader>bl :Buffers<CR>

" Windows and wiki
call extend(leader_map['w'], {
      \ 'name': '+window/wiki'                    ,
      \ '?' :  'fzf-window'                       ,
      \ 'w' :  'open-wiki'                        ,
      \ 't' :  'open-wiki-in-tab'                 ,
      \ 'i' :  'open-diary'                       ,
      \ 's' :  'select-wiki-by-number'            ,
      \ })

noremap <leader>w? :Windows<CR>

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

" Code
let g:leader_map.c = {
  \   'name': '+code',
  \   't': 'Toggle comment',
  \   'x': 'Execute'
  \ }
noremap <leader>cx :!%:p<CR>
map <leader>ct <Plug>NERDCommenterToggle

" Navigation
let g:leader_map.p = {
  \   'name': '+project',
  \   'f': 'search-in-project',
  \   'F': 'nerdtree-find-buffer',
  \   'g': 'open-versioned-file',
  \   'o': 'open-file',
  \   't': 'nerdtree-toggle',
  \ }
nmap <Leader>pf <Plug>RgRawSearch
nmap <Leader>pF :NERDTreeFind<CR>
noremap <leader>pt :NERDTreeToggle<CR>
vmap <Leader>pf <Plug>RgRawVisualSelection<CR>
nnoremap <leader>pg :GFiles --cached --others --exclude-standard<CR>
vnoremap <leader>pg "ay:call agriculture#trim_and_escape_register_a()<CR>:GFiles '**<C-r>a**'<CR>
nnoremap <leader>po :Files<CR>

" Automatically show suggestions after a delay
nnoremap <silent> <leader> :WhichKey '\'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '\'<CR>
nnoremap <silent> <Space> :WhichKey '<Space>'<CR>
vnoremap <silent> <Space> :WhichKeyVisual '<Space>'<CR>

call which_key#register('\', "g:leader_map")
call which_key#register(' ', "g:space_map")
