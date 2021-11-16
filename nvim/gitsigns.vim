if isdirectory(expand('~/.vim/bundle/gitsigns.nvim'))
lua << EOF
  require('gitsigns').setup{}

EOF

endif
