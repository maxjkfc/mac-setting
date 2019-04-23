   if has('nvim')
	    set runtimepath^=~/.vim runtimepath+=~/.vim/after
	    let &packpath = &runtimepath
   endif

" Load the bundles config
    if filereadable(expand('~/.vim/max/bundles.vim'))
        source ~/.vim/max/bundles.vim
        source ~/.vim/max/setting.vim

	"Plugin
	    " Load the fzf config
	    if filereadable(expand('~/.vim/max/fzf.vim'))
            source ~/.vim/max/fzf.vim
	    endif

	    " Load the golang config
	    if filereadable(expand('~/.vim/max/golang.vim'))
            source ~/.vim/max/golang.vim
	    endif

	    " Load the signify config
	    if filereadable(expand('~/.vim/max/vimSignify.vim'))
            source ~/.vim/max/vimSignify.vim
	    endif

	    " Load the rainbow config
	    if filereadable(expand('~/.vim/max/rainbow.vim'))
            source ~/.vim/max/rainbow.vim
	    endif

	    " Load the multipCursor config
	    if filereadable(expand('~/.vim/max/multipCursor.vim'))
            source ~/.vim/max/multipCursor.vim
	    endif

	    " Load the deoplete config
	    if filereadable(expand('~/.vim/max/deoplete.vim'))
            source ~/.vim/max/deoplete.vim
	    endif

	    " Load the markdown config
	    if filereadable(expand('~/.vim/max/markdown.vim'))
            source ~/.vim/max/markdown.vim
	    endif

	    " Load the nerdtree config
	    if filereadable(expand('~/.vim/max/nerdtree.vim'))
            source ~/.vim/max/nerdtree.vim
	    endif

	    " Load the easyAlign config
	    if filereadable(expand('~/.vim/max/easyAlign.vim'))
            source ~/.vim/max/easyAlign.vim
	    endif

	    " Load the tagbar config
	    if filereadable(expand('~/.vim/max/tagbar.vim'))
            source ~/.vim/max/tagbar.vim
	    endif

	    " Load the fugitive config
	    if filereadable(expand('~/.vim/max/fugitive.vim'))
            source ~/.vim/max/fugitive.vim
	    endif

		if filereadable(expand('~/.vim/max/airline.vim'))
		    source ~/.vim/max/airline.vim
		endif

	    " Load the undotree config
	    if filereadable(expand('~/.vim/max/undotree.vim'))
		    source ~/.vim/max/undotree.vim
	    endif

	    " Load the wildfire config
	    if filereadable(expand('~/.vim/max/wildfire.vim'))
		    source ~/.vim/max/wildfire.vim
	    endif

	    " Load the easymotion config
	    if filereadable(expand('~/.vim/max/easymotion.vim'))
            source ~/.vim/max/easymotion.vim
	    endif

	    " Load the filetype config
	    if filereadable(expand('~/.vim/max/fileType.vim'))
            source ~/.vim/max/fileType.vim
	    endif

	    " Load the autoformat config
	    if filereadable(expand('~/.vim/max/autoformat.vim'))
            source ~/.vim/max/autoformat.vim
	    endif

	    " Load the ale config
	    if filereadable(expand('~/.vim/max/ale.vim'))
            source ~/.vim/max/ale.vim
	    endif

	    " Load the startify config
	    if filereadable(expand('~/.vim/max/startify.vim'))
            source ~/.vim/max/startify.vim
	    endif

	    " Load the swap line config
	    if filereadable(expand('~/.vim/max/swapLine.vim'))
            source ~/.vim/max/swapLine.vim
	    endif
    endif


	if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
	endif
