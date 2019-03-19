source ~/.config/vim/autoload/plug.vim
call plug#begin('~/.config/vim/plugged')

" Make sure you use single quotes

" Global plugins
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'

" Context-dependent dev stuff
Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'c', 'go', 'sh', 'javascript', 'python', 'rust', 'java'], 'do': './install --all' }
Plug 'rdnetto/YCM-Generator', {  'for': ['cpp', 'c', 'go', 'sh', 'javascript'], 'branch': 'stable'}
Plug 'gilligan/vim-lldb', {'for': ['cpp', 'c']}

call plug#end()
