let skip_defaults_vim=1
let g:ycm_global_ycm_extra_conf = '~/.config/vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:EclimCompletionMethod = 'omnifunc'
autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete  
let g:tmuxline_powerline_separators = 0
let g:airline_theme = 'minimalist'
set viminfo=""
colorscheme atom 
syntax on
set tabstop=4 number softtabstop=0 expandtab shiftwidth=4 smarttab
filetype plugin indent on
set runtimepath^=~/.config/vim/
