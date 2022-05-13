" use goimports cmd for auto format upon file save
let g:go_fmt_command = "goimports"

" abort tests after 10s
let g:go_test_timeout = '10s'
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" highlight pretty much everything
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" mappings
nmap <c-c> <Plug>(go-referrers)
nmap <c-b> <Plug>(go-def-pop)
nmap <c-d> <Plug>(go-def)
nmap <c-i> <Plug>(go-info)
nmap <c-r> <Plug>(coc-rename)

let g:go_auto_sameids = 1

" put down update time from 800ms
set updatetime=300

" write on make
set autowrite
