" Navigation shortcuts
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map <leader>h :tabp<CR>
map <leader>l :tabn<CR>

" Allow to save with sudo even after having opened the file
cnoremap w!! w !sudo tee > /dev/null %

" === START - extensions shortcuts ===

" NERDTree
noremap <F3> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" Code execution
map <leader>x :!%:p<CR>
map <leader>g :silent !tig<CR> :redraw!<CR>

" Navigation
nmap <Leader>f <Plug>RgRawSearch
vmap <Leader>f <Plug>RgRawVisualSelection<CR>

" Only use GFiles if we are currently in a git repo
silent! !git rev-parse --is-inside-work-tree >/dev/null &>/dev/null
if v:shell_error == 0
  nnoremap <leader>o :GFiles --cached --others --exclude-standard<CR>
  " Automatically filter when using visual mode
	vnoremap <leader>o "ay:call agriculture#trim_and_escape_register_a()<CR>:GFiles '**<C-r>a**'<CR>
else
  nnoremap <leader>o :Files<CR>
endif

" Markdown previewer
map <leader>p :InstantMarkdownPreview<CR>

" Copy-paste to and from clipboard
map <leader>v :r !xclip -o -sel -c<CR>
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

nnoremap <CR> :noh<CR><CR>
