" Bootstrap vim-plug
"
" From https://github.com/jfchevrette/dotfiles/blob/master/vim/.vim/vimrc
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" color scheme
Plug 'altercation/vim-colors-solarized'

Plug 'ap/vim-buftabline'

" go development stuff
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries', 'for': 'go'}

" mark changed lines on the side
Plug 'airblade/vim-gitgutter'

" sidebar
Plug 'majutsushi/tagbar'

" align stuff
Plug 'godlygeek/tabular'

" toggle one line comments matching the contents of the buffer
Plug 'tomtom/tcomment_vim'

" vim git ftplugins and stuff
Plug 'tpope/vim-git'

" opa / rego
Plug 'tsandall/vim-rego', {'for': 'rego'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
