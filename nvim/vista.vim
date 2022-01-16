if isdirectory(expand('~/.vim/bundle/vista.vim'))
    let g:vista_default_executive='nvim_lsp' 
    nnoremap <space>m :Vista!! <CR>
endif
