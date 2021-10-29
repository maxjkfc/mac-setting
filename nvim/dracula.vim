if isdirectory(expand('~/.vim/bundle/dracula'))
  let g:dracula_italic=0
  " 開啟真彩色
  set termguicolors
  " visual highlight 反白顏色
  hi Visual  cterm=bold  ctermbg=magenta gui=bold  guibg=#E06C75

endif
