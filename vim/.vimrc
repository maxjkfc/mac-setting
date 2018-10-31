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
	    if filereadable(expand('~/.vim/max/golang.vim'))
            source ~/.vim/max/vim-signify.vim
	    endif

	    " Load the rainbow config
	    if filereadable(expand('~/.vim/max/rainbow.vim'))
            source ~/.vim/max/rainbow.vim
	    endif

	    " Load the multip-cursor config
	    if filereadable(expand('~/.vim/max/multip-cursor.vim'))
            source ~/.vim/max/multip-cursor.vim
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

	    " Load the easy-align config
	    if filereadable(expand('~/.vim/max/easy-align.vim'))
            source ~/.vim/max/easy-align.vim
	    endif

	    " Load the tagbar config
	    if filereadable(expand('~/.vim/max/tagbar.vim'))
            source ~/.vim/max/tagbar.vim
	    endif

	    " Load the fugitive config
	    if filereadable(expand('~/.vim/max/fugitive.vim'))
            source ~/.vim/max/fugitive.vim
	    endif

	    "Load the lightline config
		"if has('nvim') 
			"if filereadable(expand('~/.vim/max/lightline.vim'))
			"source ~/.vim/max/lightline.vim
			"endif
		"else
		    if filereadable(expand('~/.vim/max/airline.vim'))
			source ~/.vim/max/airline.vim
		    endif
		"endif

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
	    if filereadable(expand('~/.vim/max/filetype.vim'))
            source ~/.vim/max/filetype.vim
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
    endif


	if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
	endif
