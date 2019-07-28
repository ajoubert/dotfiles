source ~/.config/vim/autoload/plug.vim
call plug#begin('~/.config/vim/plugged')

" Make sure you use single quotes

" Global plugins
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let NERDTreeQuitOnOpen=1
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/calendar.vim'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'

" Org mode and its dependencies
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
Plug 'tpope/vim-speeddating'

" Context-dependent dev stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rdnetto/YCM-Generator', {  'for': ['cpp', 'c', 'go'], 'branch': 'stable'}
Plug 'gilligan/vim-lldb', {'for': ['cpp', 'c']}

call plug#end()
