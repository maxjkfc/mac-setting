" Golang
if isdirectory(expand('~/.vim/bundle/vim-go'))
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = 'goimports'

    let g:go_test_timeout = '30s'

    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    let g:go_auto_sameids = 1
    let g:go_snippet_engine = 'ultisnips'
    let g:go_doc_popup_window = 1

    let g:go_metalinter_command='golangci-lint'
    " gopls
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'

    " set to use coc.vim -> disable vim-go: GoDef short cut
    let g:go_def_mapping_enabled = 0 

    augroup golangcmd
        au FileType go nmap <Leader>s <Plug>(go-implements)
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <Leader>en <Plug>(go-rename)
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <Leader>gd <Plug>(go-doc)
        au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        au FileType go nmap <leader>co <Plug>(go-coverage)
    augroup END
endif
