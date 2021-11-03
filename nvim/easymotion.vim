if isdirectory(expand('~/.vim/bundle/vim-easymotion'))
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

   " JK motions: Line motions
    map <leader><leader>j <Plug>(easymotion-j)
    map <leader><leader>k <Plug>(easymotion-k)
    map <leader><leader>h <Plug>(easymotion-linebackward)
    map <leader><leader>l <Plug>(easymotion-lineforward)
    nmap <leader>s <Plug>(easymotion-s)
endif
