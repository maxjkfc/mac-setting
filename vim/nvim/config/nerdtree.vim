" NerdTree
    if isdirectory(expand('~/.vim/bundle/nerdtree'))
        map <leader>e <plug>NERDTreeTabsToggle<CR>            

        let NERDTreeShowBookmarks=0
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=2
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let NERDChristmasTree = 1
        let NERDTreeDirArrows = 1
        let NERDTreeWinPos = 'left'
        let NERDTreeHijackNetrw = 1
        "let g:nerdtree_tabs_open_on_gui_startup=0
    endif
