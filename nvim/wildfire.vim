" WildFire
if isdirectory(expand('~/.vim/bundle/wildfire.vim/'))
    let g:wildfire_objects = {
    \ '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
    \ 'html,xml' : ['at'],
    \ }
    " 快速選取區塊內容
    nmap <space>v <Plug>(wildfire-fuel)
endif
