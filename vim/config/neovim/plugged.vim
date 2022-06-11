source $VIM_CONFIG/autoload/plug.vim

" Some plugins are neovim-only
call plug#begin("$VIM_CONFIG/.plugged/neovim")

" Theme / colors
Plug 'arcticicestudio/nord-vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'dracula/vim', { 'as': 'dracula' }

" Fuzzy search 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'

" Symlinks
Plug 'aymericbeaumet/vim-symlink'

" fzf config
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -L --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_preview_window = 'right:60%'

" Undo tree
Plug 'mbbill/undotree'

" NerdTree and extensions 
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings=0
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTreeIgnore=['^node_modules$']

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Markdown and note taking
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/.vimwiki/wiki/', 'path_html': '~/.vimwiki/html/', 'syntax': 'markdown', 'ext': '.md'}]


" Development plugins
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-compe'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'

" " Kept desipte native lsp, as source decompression isn't implemented yet
" " for GoToDefinition...
" Plug 'OmniSharp/omnisharp-vim'
" let g:OmniSharp_server_use_mono = 1
" let g:OmniSharp_popup = 0
" let g:OmniSharp_highlighting = 0
" let g:OmniSharp_diagnostic_listen = 0

" Debugger
Plug 'puremourning/vimspector'

" Snippets / boilerplate code
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/ultisnips']
Plug 'honza/vim-snippets'

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0

" For visual search/replace
Plug 'osyo-manga/vim-over'
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

" For better leaderkey integration
Plug 'liuchengxu/vim-which-key'

" Telescope and its dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" Theme stuff, added here because it depends on vim-color-solarized plugin
let g:solarized_termtrans=1
" colorscheme solarized8
" colorscheme nord
colorscheme dracula
