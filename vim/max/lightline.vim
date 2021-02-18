
if isdirectory(expand('~/.vim/bundle/lightline.vim/'))
  set noshowmode

    let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], 
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ,  ['coc_status'], ['method']
      \ ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'method': 'NearestMethodOrFunction',
      \ },
      \ }

    call lightline#coc#register()
endif
