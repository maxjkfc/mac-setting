   if has('nvim')
	    set runtimepath^=~/.vim runtimepath+=~/.vim/after
	    let &packpath = &runtimepath
   endif

" Load the bundles config
    if filereadable(expand('~/.vim/config/bundles.vim'))
        source ~/.vim/config/bundles.vim
        source ~/.vim/config/setting.vim

	"Plugin
	    " Load the fzf config
	    if filereadable(expand('~/.vim/config/fzf.vim'))
            source ~/.vim/config/fzf.vim
	    endif

        " Load the coc config
	    if filereadable(expand('~/.vim/config/coc.vim'))
            source ~/.vim/config/coc.vim
	    endif

	    " Load the golang config
	    if filereadable(expand('~/.vim/config/vim-go.vim'))
            source ~/.vim/config/vim-go.vim
	    endif

	    " Load the signify config
	    if filereadable(expand('~/.vim/config/vimSignify.vim'))
            source ~/.vim/config/vimSignify.vim
	    endif

	    " Load the rainbow config
	    if filereadable(expand('~/.vim/config/rainbow.vim'))
            source ~/.vim/config/rainbow.vim
	    endif

        " Load the indent-guides config
	    if filereadable(expand('~/.vim/config/indent-guides.vim'))
            source ~/.vim/config/indent-guides.vim
	    endif

	    " Load the markdown config
	    if filereadable(expand('~/.vim/config/markdown.vim'))
            source ~/.vim/config/markdown.vim
	    endif

	    " Load the nerdtree config
	    if filereadable(expand('~/.vim/config/nerdtree.vim'))
            source ~/.vim/config/nerdtree.vim
	    endif

	    " Load the easyAlign config
	    if filereadable(expand('~/.vim/config/easyAlign.vim'))
            source ~/.vim/config/easyAlign.vim
	    endif

	    " Load the tagbar config
	    if filereadable(expand('~/.vim/config/tagbar.vim'))
            source ~/.vim/config/tagbar.vim
	    endif

	    " Load the fugitive config
	    if filereadable(expand('~/.vim/config/fugitive.vim'))
            source ~/.vim/config/fugitive.vim
	    endif

		if filereadable(expand('~/.vim/config/airline.vim'))
		    source ~/.vim/config/airline.vim
		endif

	    " Load the undotree config
	    if filereadable(expand('~/.vim/config/undotree.vim'))
		    source ~/.vim/config/undotree.vim
	    endif

	    " Load the wildfire config
	    if filereadable(expand('~/.vim/config/wildfire.vim'))
		    source ~/.vim/config/wildfire.vim
	    endif

	    " Load the easymotion config
	    if filereadable(expand('~/.vim/config/easymotion.vim'))
            source ~/.vim/config/easymotion.vim
	    endif

	    " Load the filetype config
	    if filereadable(expand('~/.vim/config/fileType.vim'))
            source ~/.vim/config/fileType.vim
	    endif

         "Load the ale config
        if filereadable(expand('~/.vim/config/ale.vim'))
            source ~/.vim/config/ale.vim
        endif

	    " Load the startify config
	    if filereadable(expand('~/.vim/config/startify.vim'))
            source ~/.vim/config/startify.vim
	    endif

	    " Load the swap line config
	    if filereadable(expand('~/.vim/config/swapLine.vim'))
            source ~/.vim/config/swapLine.vim
	    endif

	    " Load the swap line config
	    if filereadable(expand('~/.vim/config/ultisnips.vim'))
            source ~/.vim/config/ultisnips.vim
	    endif

	    " Load the multiple cursors config
	    if filereadable(expand('~/.vim/config/multiplecursors.vim'))
            source ~/.vim/config/multiplecursors.vim
	    endif
	    if filereadable(expand('~/.vim/config/theme.vim'))
            source ~/.vim/config/theme.vim
	    endif
    endif


	if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
	endif
