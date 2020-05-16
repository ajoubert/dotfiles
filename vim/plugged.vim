" Global plug config ==== {{{

source $VIM_CONFIG/autoload/plug.vim
call plug#begin("$VIM_CONFIG/plugged")

" ==== }}}

Plug 'altercation/vim-colors-solarized', { 'do': './bin/post_plug_update.sh vim-colors-solarized' }

" Fuzzy search ==== {{{
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" Modify ag's behaviour to optionally open a side window to show file content
" and adds a little window indicating where to find the change
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \                         : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"

" ==== }}}

" NerdTree and extensions ==== {{{

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" let NERDTreeQuitOnOpen=1
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ==== }}}

" Multiple-cursor support ==== {{{

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" ==== }}}

" Orgmode for vim ==== {{{

" Org mode and its dependencies
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
let g:utl_cfg_hdl_scm_http="silent !firefox-developer-edition -remote 'ping()' && firefox-developer-edition -remote 'openURL( %u )' || firefox-developer-edition '%u#%f' &"

" ==== }}}

" Markdown and note taking ==== {{{

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
let g:instant_markdown_autostart = 0

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/.vimwiki/wiki/', 'path_html': '~/.vimwiki/html/', 'syntax': 'markdown', 'ext': '.md'}]

" ==== }}}

" Development plugins ==== {{{

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

" For visual search/replace
Plug 'osyo-manga/vim-over'
cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ==== }}}

call plug#end()
