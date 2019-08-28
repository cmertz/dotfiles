" init plugins
source $HOME/.config/nvim/plug.vim

" colorscheme
set background=light
set termguicolors
colorscheme solarized

" line number
set number

" mouse support
set mouse=a

" encoding and fileencoding
set encoding=utf-8

" get rid of backup and swp files
set nobackup
set nowritebackup
set noswapfile

" highlight search results
set hlsearch

" make search case insensitive
set ignorecase

" wrap lines longer than window size
set wrap

" replace newly inserted <tab> with <space>
set expandtab

" number of <space> a <tab> is replaced with
set tabstop=2

" number of <space> used for one indentation level
set shiftwidth=2

" number of <space> a <tab> is replaced with during editing
set softtabstop=2

" status line
set statusline=%<%f\ %{empty(&ft)?'':'('.&ft.')'}\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" indentation
set smartindent

" use x11 clipboard
set clipboard=unnamedplus

" turn on filetype detection and dependent plugins and indentation
filetype plugin indent on

" automatically reload buffer content once after external change
set autoread
au CursorHold * checktime

" remove trailing whitespaces on write
autocmd BufWritePre * :%s/\s\+$//e

" Use deoplete
let g:deoplete#enable_at_startup = 1

" remove vertical separator bars
set fillchars+=vert:\ "

" ommit help message
let g:tagbar_compact = 1

" assume config under default for $XDG_CONFIG_HOME ... which we do not set
source $HOME/.config/nvim/global-mappings.vim
