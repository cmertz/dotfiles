call plug#begin('~/.config/nvim/plugged')

" color scheme
Plug 'altercation/vim-colors-solarized'

" mark changed lines on the side
Plug 'airblade/vim-gitgutter'

" sidebar
Plug 'majutsushi/tagbar'

" align stuff
Plug 'godlygeek/tabular'

" toggle one line comments matching the contents of the buffer
Plug 'tomtom/tcomment_vim'

" code completion
Plug 'Shougo/deoplete.nvim'

" vim git ftplugins and stuff
Plug 'tpope/vim-git'

" go development stuff
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries', 'for': 'go'}

" go code completion
Plug 'zchee/deoplete-go', {'do': 'make', 'for': 'go'}

" terraform stuff
Plug 'hashivim/vim-terraform', {'for': 'tf'}

call plug#end()
