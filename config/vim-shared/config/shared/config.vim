if $THEME == 'light'
  set background=light
else
  set background=dark
endif

" I want to use vim, not vi
set nocompatible
" Please don't add default stuff...
let skip_defaults_vim=1

" I don't care about net history
let g:netrw_dirhistmax=0

set encoding=UTF-8

filetype plugin indent on

" In case the runtime is overwritten
set runtimepath^=$VIM_CONFIG

" Line number stuff
set number
set relativenumber

" I can show it when required
set noruler

" I don' t like tabs
set expandtab
set tabstop=2
set softtabstop=2 " Was 0, check the difference
set shiftwidth=2
set smartindent
set smarttab
set autoindent

" easier to see characters when `set paste` is on
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:·,extends:⟩,precedes:⟨

" Search-related config 
set hlsearch
set ignorecase
set smartcase
set incsearch

" Folding
set foldmethod=manual

" Shows completion suggestions
set wildmenu

set viminfo='20,<1000,s1000
" set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
" "           | |    |   |   |    | |  + viminfo file path
" "           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
" "           | |    |   |   |    + disable 'hlsearch' loading viminfo
" "           | |    |   |   + command-line history saved
" "           | |    |   + search history saved
" "           | |    + files marks saved
" "           | + lines saved each register (old name for <, vi6.2)
" "           + save/restore buffer list

set formatoptions-=t   " don't auto-wrap text using text width
set formatoptions+=c   " autowrap comments using textwidth with leader
set formatoptions-=r   " don't auto-insert comment leader on enter in insert
set formatoptions-=o   " don't auto-insert comment leader on o/O in normal
set formatoptions+=q   " allow formatting of comments with gq
set formatoptions-=w   " don't use trailing whitespace for paragraphs
set formatoptions-=a   " disable auto-formatting of paragraph changes
set formatoptions-=n   " don't recognized numbered lists
set formatoptions+=j   " delete comment prefix when joining
set formatoptions-=2   " don't use the indent of second paragraph line
set formatoptions-=v   " don't use broken 'vi-compatible auto-wrapping'
set formatoptions-=b   " don't use broken 'vi-compatible auto-wrapping'
set formatoptions+=l   " long lines not broken in insert mode
set formatoptions+=m   " multi-byte character line break support
set formatoptions+=M   " don't add space before or after multi-byte char
set formatoptions-=B   " don't add space between two multi-byte chars in join 
set formatoptions+=1   " don't break a line after a one-letter word


" I prefer to split below and right
set splitbelow
set splitright

" Let's keep the cursor centered
set scrolloff=15

set textwidth=75 " Good alternative to 80, fits on most screens

" I like to live dangerously
set noswapfile
set nowritebackup
set nobackup
set laststatus=0

" Download and installs the plugin manager
if $PLATFORM != 'mac'
  if empty(glob("$VIM_CONFIG/autoload/plug.vim"))
    silent !curl -fLo $VIM_CONFIG/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif
endif

" Make Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Give more space for displaying messages.
set cmdheight=2

" syntax coloring is always nice
syntax enable
" Theme settings can be found in plugged.vim, moved there because it
" depends on a plugin

" Toggle tmux bar when entering vim
if has_key(environ(), 'TMUX')
  augroup tmux_something
    autocmd VimResume  * call system('tmux set status off')
    autocmd VimEnter   * call system('tmux set status off')
"    autocmd VimLeave   * call system('tmux set status on')
"    autocmd VimSuspend * call system('tmux set status on')
  augroup END
endif

" Give alterative command for terminal requiring TTY
command -nargs=* T :!tmux_process_exec.sh <args>

" Makes use of system clipboard
set clipboard+=unnamedplus
