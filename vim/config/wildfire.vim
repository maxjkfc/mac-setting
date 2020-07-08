" WildFire
    if isdirectory(expand('~/.vim/bundle/wildfire.vim/'))
        let g:wildfire_objects = {
        \ '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
        \ 'html,xml' : ['at'],
        \ }
    endif
