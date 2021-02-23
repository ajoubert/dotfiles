" VimWiki
let g:which_key_map.w = {
  \   'name': '+wiki',
  \   'w': 'Open default wiki',
  \   't': 'Open wiki in new tab',
  \   's': 'Select wiki to open',
  \   'i': 'Open diary'
  \ }

" Git - fugitive
let g:which_key_map.g = {
  \   'name': '+git',
  \   'b': 'Show blame',
  \   'd': 'Show diff',
  \   'g': 'Toggle gutter',
  \   'l': 'Open log',
  \   't': 'Open tig'
  \ }

noremap <leader>gb :Git blame<CR>
noremap <leader>gd :Git diff<CR>
noremap <leader>gl :Git log<CR>
noremap <leader>gg :GitGutterToggle<CR>
noremap <leader>gt :silent !tig<CR> :redraw!<CR>

" NERDTree
let g:which_key_map.s = 'Toggle sidebar'
noremap <leader>s :NERDTreeToggle<CR>

" Code
let g:which_key_map.c = {
  \   'name': '+code',
  \   't': 'Toggle comment',
  \   'x': 'Execute'
  \ }
noremap <leader>cx :!%:p<CR>
map <leader>ct <Plug>NERDCommenterToggle

" Navigation
let g:which_key_map.n = {
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

call which_key#register('\', "g:which_key_map")
