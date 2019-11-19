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
