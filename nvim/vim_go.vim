if isdirectory(expand('~/.vim/bundle/vim-go'))

  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1
  " 關閉初始快捷鍵
  let g:go_def_mapping_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go_gopls_enabled = 0
  let g:go_gopls_options = ['-remote=auto']

  augroup golangcmd
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <leader>co <Plug>(go-coverage)
  augroup END

endif
