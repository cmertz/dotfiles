"
" externalize global mappings to make them override
" plugin defined mappings
"

" navigate through tabs with
nnoremap <silent><Tab>   :bn<CR>
nnoremap <silent><S-Tab> :bp<CR>

" comment plugin
nnoremap <silent>// :TComment<CR>
vnoremap <silent>// :TComment<CR>

nnoremap <silent><C-t> :TagbarToggle<CR>
nnoremap <silent>:bd :bp<cr>:bd #<cr>

" make vim feel more editory
nnoremap <silent><C-s> :w<CR>
inoremap <silent><C-s> <ESC>:w<CR>i
nnoremap <silent><C-f> /
inoremap <silent><C-f> <ESC> /
nnoremap <silent><C-q> :qall<CR>
inoremap <silent><C-q> <ESC>:qall<CR>
