" vim-easymotion
"
    if isdirectory(expand('~/.vim/bundle/vim-easymotion'))
        let g:EasyMotion_do_mapping = 0 " Disable default mappings
        let g:EasyMotion_smartcase = 1

       " JK motions: Line motions
        map <Leader><Leader>j <Plug>(easymotion-j)
        map <Leader><Leader>k <Plug>(easymotion-k)
        map <Leader><Leader>h <Plug>(easymotion-linebackward)
        map <Leader><Leader>l <Plug>(easymotion-lineforward)
        map <Leader><leader>s <Plug>(easymotion-sn)
    endif
