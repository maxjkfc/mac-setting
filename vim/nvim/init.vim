" Set the shell
    set shell=/bin/zsh
" Set runtimepath
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath

" Load the bundles config
    if filereadable(expand('~/.config/nvim/config/bundles.vim'))
        source ~/.config/nvim/config/bundles.vim
    endif

" Base 
   "set nocompatible          " VIM 不使用和 VI 相容的模式
    set clipboard=unnamed     " On mac and Windows, use * register for copy-paste
    filetype plugin indent on " Automatically detect file types.
    syntax on                 " Syntax highlighting
    set mouse=a               " Automatically enable mouse usage
    set mousehide             " Hide the mouse cursor while typing
    set encoding=utf-8
    scriptencoding utf-8
    
    set shortmess+=filmnrxoOtT              " Abbrev. Of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore                 " Allow for cursor beyond last character
    set history=1000                        " Store a ton of history (default is 20)
    set hidden                              " Allow buffer switching without saving
    set backup                              " Backups are nice ...
    set undofile                            " So is persistent undo ...
    set undolevels=1000                     " Maximum number of changes that can be undone
    set undoreload=10000                    " Maximum number lines to save for undo on a buffer reload
    set writebackup

" GUI 
    colorscheme molokai-max         " use vim theme
    set background=dark             " Assume a dark background
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
    set cursorcolumn
    highlight clear SignColumn      " Sign Column should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    set ruler                       " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                     " Show partial commands in status line and

    set laststatus=2
    "set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code

" Formatting
    set nowrap                              " Do not wrap long lines
    set smartindent
    set shiftwidth=4                        " Use indents of 4 spaces
    set expandtab                           " Tabs are spaces, not tabs
    set tabstop=4                           " An indentation every four columns
    set softtabstop=4                       " Let backspace delete indent
    set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                          " Puts new vsplit windows to the right of the current
    set splitbelow                          " Puts new split windows to the bottom of the current
    
    set directory=~/.vimswp/
    set backupdir=~/.vimbackup
    set undodir=~/.vimundo


" Key Mappings
    let mapleader =','          " set the key map leader
    let maplocalleader = '_'

    " Easier Moving
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
    "To clear search highlighting rather than toggle
    nmap <silent> <leader>/ :nohlsearch<CR>

     " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

     " Some helpers to edit mode
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%
    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " settings for resize splitted window
    nmap w[ :vertical resize -3<CR>
    nmap w] :vertical resize +3<CR>

    nmap w- :resize -3<CR>
    nmap w= :resize +3<CR>


"Plugin
    " Load the fzf config
    if filereadable(expand('~/.config/nvim/config/fzf.vim'))
        source ~/.config/nvim/config/fzf.vim
    endif

    " Load the golang config
    if filereadable(expand('~/.config/nvim/config/golang.vim'))
        source ~/.config/nvim/config/golang.vim
    endif

    " Load the signify config
    if filereadable(expand('~/.config/nvim/config/golang.vim'))
        source ~/.config/nvim/config/vim-signify.vim
    endif

    " Load the rainbow config
    if filereadable(expand('~/.config/nvim/config/rainbow.vim'))
        source ~/.config/nvim/config/rainbow.vim
    endif
    

    " Load the multip-cursor config
    if filereadable(expand('~/.config/nvim/config/multip-cursor.vim'))
        source ~/.config/nvim/config/multip-cursor.vim
    endif

    " Load the deoplete config
    if filereadable(expand('~/.config/nvim/config/deoplete.vim'))
        source ~/.config/nvim/config/deoplete.vim
    endif

    " Load the markdown config
    if filereadable(expand('~/.config/nvim/config/markdown.vim'))
        source ~/.config/nvim/config/markdown.vim
    endif

    " Load the nerdtree config
    if filereadable(expand('~/.config/nvim/config/nerdtree.vim'))
        source ~/.config/nvim/config/nerdtree.vim
    endif

    " Load the easy-align config
    if filereadable(expand('~/.config/nvim/config/easy-align.vim'))
        source ~/.config/nvim/config/easy-align.vim
    endif

    " Load the tagbar config
    if filereadable(expand('~/.config/nvim/config/tagbar.vim'))
        source ~/.config/nvim/config/tagbar.vim
    endif

    " Load the fugitive config
    if filereadable(expand('~/.config/nvim/config/fugitive.vim'))
        source ~/.config/nvim/config/fugitive.vim
    endif

    "Load the lightline config
    if filereadable(expand('~/.config/nvim/config/lightline.vim'))
        source ~/.config/nvim/config/lightline.vim
    endif

    " Load the undotree config
    if filereadable(expand('~/.config/nvim/config/undotree.vim'))
        source ~/.config/nvim/config/undotree.vim
    endif

    " Load the wildfire config
    if filereadable(expand('~/.config/nvim/config/wildfire.vim'))
        source ~/.config/nvim/config/wildfire.vim
    endif

    " Load the easymotion config
    if filereadable(expand('~/.config/nvim/config/easymotion.vim'))
        source ~/.config/nvim/config/easymotion.vim
    endif

    " Load the filetype config
    if filereadable(expand('~/.config/nvim/config/filetype.vim'))
        source ~/.config/nvim/config/filetype.vim
    endif

    " Load the autoformat config
    if filereadable(expand('~/.config/nvim/config/autoformat.vim'))
        source ~/.config/nvim/config/autoformat.vim
    endif

    " Load the ale config
    if filereadable(expand('~/.config/nvim/config/ale.vim'))
        source ~/.config/nvim/config/ale.vim
    endif

    " Load the startify config
    if filereadable(expand('~/.config/nvim/config/startify.vim'))
        source ~/.config/nvim/config/startify.vim
    endif
