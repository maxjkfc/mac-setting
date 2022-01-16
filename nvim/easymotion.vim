if isdirectory(expand('~/.vim/bundle/vim-easymotion'))
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

   " JK motions: Line motions
    " map <leader><leader>j <Plug>(easymotion-j)
    " map <leader><leader>k <Plug>(easymotion-k)
    nmap mf <Plug>(easymotion-f)
    nmap mF <Plug>(easymotion-F)
    nmap mt <Plug>(easymotion-t)
    nmap mT <Plug>(easymotion-T)
    nmap ms <Plug>(easymotion-s)
    nmap mn <Plug>(easymotion-n)
    nmap m; <Plug>(easymotion-next)
    nmap m, <Plug>(easymotion-prev)
endif
