if isdirectory(expand('~/.vim/bundle/colorizer-nvim'))
lua<<EOF
  require'colorizer'.setup()
EOF

endif
