" WildFire
    if isdirectory(expand('~/.vim/bundle/wildfire.vim/'))
        let g:wildfire_objects = {
        \ '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
        \ 'html,xml' : ['at'],
        \ }


        nmap <leader>s <Plug>(wildfire-quick-select)
    endif

