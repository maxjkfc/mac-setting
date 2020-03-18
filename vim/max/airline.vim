" Airline
"
if isdirectory(expand('~/.vim/bundle/vim-airline/'))
    let g:airline_theme='onedark'
    "let g:airline_theme='molokai'
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_extensions = ['tagbar']
    let g:airline#extensions#ale#enabled = 1

    " coc
    let g:airline#extensions#coc#enabled = 1
    let airline#extensions#coc#error_symbol = 'E:'
    let airline#extensions#coc#warning_symbol = 'W:'
    let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
    let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'


endif

