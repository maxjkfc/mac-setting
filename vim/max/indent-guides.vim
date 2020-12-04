" vim-indent-guides  區塊破折號
if isdirectory(expand('~/.vim/bundle/vim-indent-guides'))
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    "let g:indent_guides_enable_on_vim_startup = 0

    hi IndentGuidesOdd  ctermbg=white
    hi IndentGuidesEven ctermbg=darkgrey
endif
