" NERDTree
noremap <F3> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Code execution
map <leader>x :!%:p<CR>
if isGitRepo
  map <leader>g :silent !tig<CR> :redraw!<CR>
endif

" Navigation
nmap <Leader>f <Plug>RgRawSearch
vmap <Leader>f <Plug>RgRawVisualSelection<CR>

" Only use GFiles if we are currently in a git repo
if isGitRepo
  nnoremap <leader>o :GFiles --cached --others --exclude-standard<CR>
  " Automatically filter when using visual mode
	vnoremap <leader>o "ay:call agriculture#trim_and_escape_register_a()<CR>:GFiles '**<C-r>a**'<CR>
else
  nnoremap <leader>o :Files<CR>
endif
