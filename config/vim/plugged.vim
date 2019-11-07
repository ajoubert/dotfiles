source ~/.config/vim/autoload/plug.vim
call plug#begin('~/.config/vim/plugged')

" Make sure you use single quotes

" Global plugins
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

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" let NERDTreeQuitOnOpen=1
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Calendar window with events
Plug 'itchyny/calendar.vim'
" In-view calendar for date selection
Plug 'mattn/calendar-vim'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'

" Org mode and its dependencies
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
let g:utl_cfg_hdl_scm_http="silent !firefox-developer-edition -remote 'ping()' && firefox-developer-edition -remote 'openURL( %u )' || firefox-developer-edition '%u#%f' &"
Plug 'tpope/vim-speeddating'

" Context-dependent dev stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rdnetto/YCM-Generator', {  'for': ['cpp', 'c', 'go'], 'branch': 'stable'}
Plug 'gilligan/vim-lldb', {'for': ['cpp', 'c']}

call plug#end()
