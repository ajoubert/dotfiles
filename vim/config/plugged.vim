source $VIM_CONFIG/autoload/plug.vim

" Some plugins are neovim-only
if has('nvim')
  call plug#begin("$VIM_CONFIG/plugged_nvim")
else
  call plug#begin("$VIM_CONFIG/plugged_vim")
end

" Theme / colors
Plug 'rafi/awesome-vim-colorschemes'

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


" Markdown and note taking
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
let g:instant_markdown_autostart = 0
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/.vimwiki/wiki/', 'path_html': '~/.vimwiki/html/', 'syntax': 'markdown', 'ext': '.md'}]


if has('nvim')
  " Development plugins
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdcommenter'

  " Kept desipte native lsp, as source decompression isn't implemented yet
  " for GoToDefinition...
  Plug 'OmniSharp/omnisharp-vim'
  let g:OmniSharp_server_use_mono = 1
  let g:OmniSharp_popup = 0
  let g:OmniSharp_highlighting = 0
  let g:OmniSharp_diagnostic_listen = 0

  " Debugger
  Plug 'puremourning/vimspector'

  " Snippets / boilerplate code
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  Plug 'honza/vim-snippets'

  " If you want :UltiSnipsEdit to split your window.
  " let g:UltiSnipsEditSplit="vertical"

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0
end

" For visual search/replace
Plug 'osyo-manga/vim-over'
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

" For better leaderkey integration
Plug 'liuchengxu/vim-which-key'

call plug#end()

" Theme stuff, added here because it depends on vim-color-solarized plugin
let g:solarized_termtrans=1
colorscheme solarized8
