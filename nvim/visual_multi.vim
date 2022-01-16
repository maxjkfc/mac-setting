if isdirectory(expand('~/.vim/bundle/vim-visual-multi'))
  let g:VM_leader = ','
  let g:VM_maps = {}
  let g:VM_maps['Motion ,'] = ',,'
  let g:VM_maps['Visual Cursors'] = '\\cc'
endif
