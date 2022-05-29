" Buffers
call extend(leader_map['b'], {
  \ 'l': 'list-buffers',
  \ })
noremap <leader>bl :Buffers<CR>

let g:leader_map['e'] = 'open terminal'
nnoremap <leader>e :te<CR> 

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

" Navigation
let g:leader_map.p = {
  \   'name': '+project',
  \   'f': 'search-in-project',
  \   'F': 'nerdtree-find-buffer',
  \   'g': 'open-versioned-file',
  \   'o': 'open-file',
  \   't': 'nerdtree-toggle',
  \ }
" nmap <Leader>pf <Plug>RgRawSearch
nmap <Leader>pf :Rg 
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
nnoremap <silent> g :WhichKey 'g'<CR>
vnoremap <silent> g :WhichKeyVisual 'g'<CR>


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

" LSP navigation 
let g:g_map = {
  \   'd': 'go-to-definition',
  \   'D': 'go-to-declaration',
  \   'i': 'go-to-implementation',
  \   'r': 'go-to-references',
  \ }
noremap gd :lua vim.lsp.buf.definition()<CR>
noremap gD :lua vim.lsp.buf.declaration()<CR>
noremap gi :lua vim.lsp.buf.implementation()<CR>
noremap gr :lua vim.lsp.buf.references()<CR>

" Code
let g:leader_map.c = {
  \   'name': '+code',
  \   't': 'toggle-comment',
  \   'u': 'toggle-undo-tree',
  \   'x': 'execute',
  \   'r': 'rename',
  \   'd': {
  \     'name': '+debug',
  \     'c': 'continue/start-debugger',
  \     'x': 'stop-debugger',
  \     'X': 'reset-debugger',
  \     'r': 'restart-debugger',
  \     'i': 'step-into',
  \     'o': 'step-over',
  \     'O': 'step-out',
  \     't': 'toggle-line-breakpoint',
  \   }
  \ }
noremap <leader>cx :!%:p<CR>
map <leader>ct <Plug>NERDCommenterToggle
map <leader>cu :UndotreeToggle<CR>
map <leader>cr :lua vim.lsp.buf.rename()<CR>
map <leader>cdc :call vimspector#Continue()<CR>
map <leader>cdx :call vimspector#Stop()<CR>
map <leader>cdX :call vimspector#Reset()<CR>
map <leader>cdr :call vimspector#Restart()<CR>
map <leader>cdi :call vimspector#StepInto()<CR>
map <leader>cdo :call vimspector#StepOver()<CR>
map <leader>cdO :call vimspector#StepOut()<CR>
map <leader>cdt :call vimspector#ToggleBreakpoint()<CR>

map <F5> :call vimspector#Continue()<CR>
map <F3> :call vimspector#Reset()<CR>
map <F4> :call vimspector#Restart()<CR>
map <F6> :call vimspector#Pause()<CR>
map <F9> :call vimspector#ToggleBreakpoint()<CR>
map <F10> :call vimspector#StepOver()<CR>
map <F11> :call vimspector#StepInto()<CR>
map <F12> :call vimspector#StepOut()<CR>
" TODO: find a way to print those when needed
"let g:vimspector_enable_mappings = 'HUMAN'
" Key					Function 																												API
" F5					When debugging, continue. Otherwise start debugging. 						vimspector#Continue()
" F3 					Stop debugging. 																								vimspector#Stop()
" F4	 				Restart debugging with the same configuration. 									vimspector#Restart()
" F6 					Pause debugee. 																									vimspector#Pause()
" F9 					Toggle line breakpoint on the current line. 										vimspector#ToggleBreakpoint()
" <leader>F9 	Toggle conditional line breakpoint on the current line. 				vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )
" F8 					Add a function breakpoint for the expression under cursor 			vimspector#AddFunctionBreakpoint( '<cexpr>' )
" F10 				Step Over 																											vimspector#StepOver()
" F11 				Step Into 																											vimspector#StepInto()
" F12 				Step out of current function scope 															vimspector#StepOut()
"
"" Compe -- TODO: customize
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

call which_key#register('\', "g:leader_map")
call which_key#register(' ', "g:space_map")
call which_key#register('g', "g:g_map")
