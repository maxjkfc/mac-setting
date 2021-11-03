" Set the shell
  set shell=/bin/zsh
" Set runtimepath

" Base 
  set nocompatible            " VIM 不使用和 VI 相容的模式
  set clipboard=unnamed       " On mac and Windows, use * register for copy-paste
  filetype plugin indent on   " Automatically detect file types.
  set mouse=a                 " Automatically enable mouse usage
  set mousehide               " Hide the mouse cursor while typing
  set encoding=utf-8
  scriptencoding utf-8
  
  set shortmess+=filmnrxoOtT              " Abbrev. Of messages (avoids 'hit enter')
  set shortmess+=c
  set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set virtualedit=block                   " Allow for cursor beyond last character
  set history=1000                        " Store a ton of history (default is 20)
  set hidden                              " Allow buffer switching without saving
  set backup                              " Backups are nice ...
  set writebackup
  set undofile                            " So is persistent undo ...
  set undolevels=1000                     " Maximum number of changes that can be undone
  set undoreload=10000                    " Maximum number lines to save for undo on a buffer reload

" GUI 
  syntax on                 " Syntax highlighting
  colorscheme dracula 
  set background=dark             " Assume a dark background
  set tabpagemax=15               " Only show 15 tabs
  set showmode                    " Display the current mode
  set lazyredraw                  " 加速移動
    

  highlight clear SignColumn      " Sign Column should match background
  highlight clear LineNr          " Current line number row will have same background color in relative mode
  set ruler                       " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                     " Show partial commands in status line and

  set laststatus=2
  set backspace=indent,eol,start  " Backspace for dummies
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
  "set foldmethod=indent " 折疊的方式
  "set foldnestmax=1

" Formatting
  set nowrap                              " Do not wrap long lines
  set smartindent
  set shiftwidth=2                        " Use indents of 4 spaces
  set expandtab                           " Tabs are spaces, not tabs
  set tabstop=4                           " An indentation every four columns
  set softtabstop=4                       " Let backspace delete indent
  set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J)
  set splitright                          " Puts new vsplit windows to the right of the current
  set splitbelow                          " Puts new split windows to the bottom of the current
  set autoindent                          
  set nobackup                            " close backup file
  set nowritebackup                       " close backup writting file
  set noswapfile                          " close write file in swap
  set nomodeline
  set modelines=0

  set list lcs=tab:\|\ 


" Basic Key Mappings
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
  nmap <silent> <leader>/n :nohlsearch<CR>

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

  " swap line
  vnoremap <c-k> :m '<-2<CR>gv=gv
  vnoremap <c-j> :m '>+1<CR>gv=gv 
  " move left and right
  vnoremap > >gv 
  vnoremap <Tab> >gv 
  vnoremap < <gv
  
" HighLight
  "複製一行時會有高量顯示是哪一行
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
