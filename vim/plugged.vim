source $VIM_CONFIG/autoload/plug.vim
call plug#begin("$VIM_CONFIG/plugged")

" Theme / colors

Plug 'altercation/vim-colors-solarized', { 'do': './bin/post_plug_update.sh vim-colors-solarized' }

" Fuzzy search 

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jesseleite/vim-agriculture'
nmap <Leader>f <Plug>RgRawSearch
vmap <Leader>f <Plug>RgRawVisualSelection


" fzf config
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_preview_window = 'right:60%'


" NerdTree and extensions 

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'


" Org mode and its dependencies

Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
let g:utl_cfg_hdl_scm_http="silent !firefox-developer-edition -remote 'ping()' && firefox-developer-edition -remote 'openURL( %u )' || firefox-developer-edition '%u#%f' &"


" Markdown and note taking

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
let g:instant_markdown_autostart = 0
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/.vimwiki/wiki/', 'path_html': '~/.vimwiki/html/', 'syntax': 'markdown', 'ext': '.md'}]


" Development plugins

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rdnetto/YCM-Generator', {  'for': ['cpp', 'c', 'go'], 'branch': 'stable'}
Plug 'gilligan/vim-lldb', {'for': ['cpp', 'c']}
Plug 'honza/vim-snippets' 
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1


" Git

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


" For visual search/replace

Plug 'osyo-manga/vim-over'
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s


call plug#end()
